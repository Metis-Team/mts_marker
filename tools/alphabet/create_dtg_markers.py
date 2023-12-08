#!/usr/bin/env python3

import sys
import string
import pathlib
import shutil
import argparse
import timeit
from io import TextIOWrapper

from PIL import Image, ImageFont, ImageDraw
from PIL.Image import Image as ImageType
from PIL.ImageFont import FreeTypeFont

import helper.util as util

# Configuration
version = '1.0.0'

img_size = (1024, 1024)
text_v_offset = 66 # px left/right from center
text_h_offset = 55 # px up from center

alphabet: list[str | list[str]] = [
    string.digits, # Day
    string.digits, # Day
    string.digits, # Hour
    string.digits, # Hour
    string.digits, # Minute
    string.digits, # Minute
    string.ascii_uppercase, # Time zones
    ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'], # Months
    string.digits, # Year
    string.digits, # Year
]

def get_dtg_macro(pos, letter):
    return f'DTGMARKER({pos},{letter});'

def create_image(font: FreeTypeFont, letter: str, pos: int):
    """Creates a image of a character in given position and location (anchor).

    Args:
        font (FreeTypeFont): Character font.
        letter (str): The character(s) to print.
        pos (int): The position of the character. Smaller number means closer to center/frameshape.
        anchor (str, optional): The location of the character relative to the frameshape. Use 'rb' for right bottom, 'lb' for left bottom. Defaults to 'lb'.

    Returns:
        Image: An image object representing the character.
    """

    image = Image.new('RGBA', img_size)

    letter_size = font.getbbox(letter, anchor='ls')
    letter_width = letter_size[2] - letter_size[0]

    # For some reason the width of the letter K is bigger then it should
    if letter == 'K':
        letter_width -= 1

    v_offset = text_v_offset + letter_width

    x = image.size[0] / 2 - (v_offset + pos * letter_width)
    y = image.size[1] / 2 - text_h_offset

    draw = ImageDraw.Draw(image)
    draw.text((x, y), letter, fill=(0, 0, 0), font=font, anchor='ls')

    return image

def create_all_images(alphabet: list[str | list[str]], font: FreeTypeFont):
    """Creates all images for the characters defined.

    Args:
        alphabet (dict[str, dict[str]]): Character sets to create.
        font (FreeTypeFont): Character font.

    Returns:
        list(tuple(Image, Path)): A list of character image object and relative file path to the output directory.
    """

    images: list[tuple[ImageType, pathlib.Path]] = []
    for pos, alphabet in enumerate(reversed(alphabet)):
        image_dir = pathlib.Path('dtg', str(pos))

        for letter in alphabet:
            image = create_image(font, letter, pos)

            file_name = f'mts_markers_dtg_{pos}_{letter}.png'
            export_file = image_dir / file_name

            images.append((image, export_file))

    return images

def write_include_file(path: pathlib.Path, alphabet: list[str | list[str]]):
    """Writes all marker into an include file.

    Args:
        path (Path): Path to the include file.
        markers (list[str | list[str]]): Character sets created.
    """

    with open(path, 'w') as f:
        comment = util.get_generated_comment_lines('Character markers for Date-Time Group')
        f.writelines(comment)

        for pos, alphabet in enumerate(reversed(alphabet)):
            for letter in alphabet:
                macro = get_dtg_macro(pos, letter)
                f.write(macro + '\n')

            f.write('\n')

def main(args: argparse.Namespace):
    start_time = timeit.default_timer()

    if sys.platform != 'win32':
        print('This tool is not support on non-windows devices due to missing Arma Tools.')
        sys.exit(2)

    png_only = args.png_only
    clean_images = not args.no_clean

    font = ImageFont.truetype(str(args.font_file), size=35) # 26pt == 35px
    print('Using font:', font.getname())

    image_to_paa = util.find_image_to_paa_tool()
    print('Found ImageToPaa Tool:', image_to_paa)

    print('Creating images...')
    images = create_all_images(alphabet, font)

    print('Cleaning export folder:', clean_images)
    if clean_images:
        shutil.rmtree(args.output_dir)

    print('Exporting only PNG files:', png_only)

    # Export images in parallel
    util.export_images(images, args.output_dir, args.workers, image_to_paa=image_to_paa, png_only=png_only)

    print(f'Exported {len(images)} images.\n')

    print('Creating include file...')
    include_file = args.output_dir / 'CfgMarkersDateTimeGroup.hpp'
    write_include_file(include_file, alphabet)
    print(f'Created \"{include_file.name}\"')

    print('Finished generating character marker files.')
    d,h,m,s = util.fract_sec(timeit.default_timer() - start_time)
    print(f'Total program time elapsed: {h:2}h {m:2}m {s:4.3f}s')


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='Creates Date-Time Group markers and exports them as *.paa files.'
    )
    parser.add_argument(
        '-v', '--version',
        action='version',
        version=version,
        help='Displays the current version of the script.'
    )
    parser.add_argument(
        '-png', '--png-only',
        action='store_true',
        dest='png_only',
        help='Exports markers as *.png files.',
    )
    parser.add_argument(
        '-nc', '--no-clean',
        action='store_true',
        dest='no_clean',
        help='Does not remove all files and directories in the export directory before creating the markers.'
    )
    parser.add_argument(
        '-o', '--output',
        dest='output_dir',
        type=pathlib.Path,
        required=True,
        help='Output directory where all files will be exported to.'
    )
    parser.add_argument(
        '-f', '--font',
        dest='font_file',
        type=pathlib.Path,
        default=(pathlib.Path(__file__).parent / 'RobotoMono' / 'static' / 'RobotoMono-SemiBold.ttf'),
        help='Path to the font to use.'
    )
    parser.add_argument(
        '--workers',
        dest='workers',
        type=int,
        default=-1,
        help='Number of workers for parallel execution. -1 for all CPUs.'
    )

    args = parser.parse_args()

    main(args)

# python create_dtg_markers.py -o ./images
