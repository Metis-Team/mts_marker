import contextlib
import tqdm
import joblib

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
