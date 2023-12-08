import contextlib
import pathlib
import subprocess
import sys

from PIL import Image, ImageDraw
from PIL.Image import Image as ImageType
from PIL.ImageFont import FreeTypeFont
import tqdm
import joblib

if sys.platform == 'win32':
    import winreg

def fract_sec(s):
    """Gets the days, hours, minutes and seconds from total time elapsed in seconds.

    Args:
        s (float): Total time elapsed in seconds.

    Returns:
        int, int, int, float: Days, hours, minutes and seconds.
    """

    temp = float(s) / (60 * 60 * 24)
    d = int(temp)
    temp = (temp - d) * 24
    h = int(temp)
    temp = (temp - h) * 60
    m = int(temp)
    temp = (temp - m) * 60
    sec = temp

    return d, h, m, sec

# https://stackoverflow.com/a/58936697
@contextlib.contextmanager
def tqdm_joblib(tqdm_object: tqdm.tqdm):
    """Context manager to patch joblib to report into tqdm progress bar given as argument"""
    class TqdmBatchCompletionCallback(joblib.parallel.BatchCompletionCallBack):
        def __call__(self, *args, **kwargs):
            tqdm_object.update(n=self.batch_size)
            return super().__call__(*args, **kwargs)

    old_batch_callback = joblib.parallel.BatchCompletionCallBack
    joblib.parallel.BatchCompletionCallBack = TqdmBatchCompletionCallback
    try:
        yield tqdm_object
    finally:
        joblib.parallel.BatchCompletionCallBack = old_batch_callback
        tqdm_object.close()


def find_image_to_paa_tool():
    """Returns the path to the ImageToPAA conversion tool.

    Raises:
        Exception: Could not find Arma 3 Tools.
        Exception: Arma 3 Tools are not installed correctly.

    Returns:
        Path: Path to the ImageToPAA conversion tool.
    """

    reg = winreg.ConnectRegistry(None, winreg.HKEY_CURRENT_USER)
    try:
        k = winreg.OpenKey(reg, r'Software\bohemia interactive\arma 3 tools')
        arma3tools_path = pathlib.Path(winreg.QueryValueEx(k, 'path')[0])
        winreg.CloseKey(k)
    except Exception:
        raise Exception('BadTools', 'Could not find Arma 3 Tools.')

    paa_tool_path = arma3tools_path / 'ImageToPAA' / 'ImageToPAA.exe'

    if not paa_tool_path.exists():
        raise Exception('BadTools', f'Arma 3 Tools are not installed correctly. \"{paa_tool_path}\" does not exist.')

    return paa_tool_path


def export_images(images: list[tuple[ImageType, pathlib.Path]], output_dir: pathlib.Path, workers: int = -1, **kwargs):
    with tqdm_joblib(tqdm.tqdm(desc='Exporting images', total=len(images))) as pbar:
        with joblib.Parallel(n_jobs=workers) as parallel:
            parallel(joblib.delayed(export_image)(image, output_dir / path, **kwargs) for image, path in images)


def export_image(image: ImageType, path: pathlib.Path, image_to_paa: pathlib.Path,
                 png_only: bool = False, keep_png: bool = False):
    """
    Exports image to disk.
    Image will be exported as *.paa unless png_only flag is set.

    Args:
        image (Image): Image to export.
        path (Path): Full export path of the image.
        image_to_paa (Path): Path to the ImageToPAA conversion tool.
        png_only (bool): Only export as PNG.
        keep_png (bool): Keep the PNG after converting to PAA.
    """
    path.parent.mkdir(parents=True, exist_ok=True)
    image.save(path)

    if not png_only:
        subprocess.run([image_to_paa, str(path)], stdout=subprocess.DEVNULL)
        # Delete PNG file afterwards
        if not keep_png:
            path.unlink(missing_ok=True)

def get_generated_comment_lines(additional_comment: str = None):
    """
    Returns the a SQF comment stating that the file is generated and should not be changed.
    An additional comment can be passed which is displayed above the warning.

    Args:
        additional_comment (str, optional): An additional comment displayed above the warning. Defaults to None.

    Returns:
        list[str]: SQF comment as list of lines.
    """
    lines: list[str] = []

    generate_message = 'This file is generated and should not be edited!'
    dashes = '-' * len(generate_message)

    lines.append(f'// {dashes}\n')
    if additional_comment:
        lines.append(f'// {additional_comment}\n')
    lines.append(f'// {generate_message}\n')
    lines.append(f'// {dashes}\n\n')

    return lines
