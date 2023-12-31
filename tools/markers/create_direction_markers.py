#!/usr/bin/env python3

import sys
import pathlib
import shutil
import argparse
import timeit
import math
from typing import NamedTuple

from PIL import Image, ImageDraw
from PIL.Image import Image as ImageType

import helper.util as util

# Configuration
version = '1.0.0'

img_size = (1024, 1024)
icon_size = (32, 32)

directions = ['N', 'NNE', 'NE', 'ENE', 'E', 'ESE', 'SE', 'SSE', 'S', 'SSW', 'SW', 'WSW', 'W', 'WNW', 'NW', 'NNW']

# Used to estimate arrow length
base_line_length = 75
line_width = 7
arrow_head = (22, 22)
offsets = {
    'blu': {
        'default': {
            'offset': (0, 49),
            'line': 80,
        },
        'hq': {
            'offset': (-57, 49),
            'line': 80,
        },
    },
    'red': {
        'default': {
            'offset': (0, 62),
            'line': 67,
        },
        'hq': {
            'offset': (-56, 10),
            'line': 119,
        },
    },
    'neu': {
        'default': {
            'offset': (0, 54),
            'line': 75,
        },
        'hq': {
            'offset': (-42, 54),
            'line': 75,
        },
    },
    'unk': {
        'default': {
            'offset': (0, 64),
            'line': 65,
        },
        'hq': {
            'offset': (-52, 9),
            'line': 120,
        },
    },
}

identities = {
    'blu': 'Blufor',
    'red': 'Redfor',
    'neu': 'Neutral',
    'unk': 'Unknown',
}

def get_dir_macro(direction):
    return f'DIR_MARKER({direction});'

def get_alternative_dir_macro(mod, direction):
    return f'DIR_MOD_MARKER({mod},{direction});'

class Point(NamedTuple):
    x: float
    y: float


def create_dir_image(angle: float, offset: tuple[int, int], line_len: int):
    # Work on image double the size because it will be resized at the last step to have antialiasing.
    scale = 2
    image = Image.new('RGBA', (img_size[0] * scale, img_size[1] * scale))

    offset = (offset[0] * scale, offset[1] * scale)
    line_len *= scale

    # Rotate angle so arrow points up.
    # Reminder: In the image coordinate system y goes down.
    angle = math.radians(angle - 90)

    color = (0, 0, 0)
    arrow_head_w, arrow_head_h = (arrow_head[0] * scale, arrow_head[1] * scale)
    arrow_len = 0.9 * (base_line_length * scale - arrow_head_h)

    center = Point(image.size[0] / 2, image.size[1] / 2)

    top = Point(center.x + offset[0], center.y + offset[1])
    arrow_start = Point(top.x, top.y + line_len)
    arrow_end = Point(arrow_start.x + arrow_len * math.cos(angle),
                      arrow_start.y + arrow_len * math.sin(angle))
    arrow_head_end = Point(arrow_start.x + (arrow_len + arrow_head_h) * math.cos(angle),
                           arrow_start.y + (arrow_len + arrow_head_h) * math.sin(angle))

    alpha = math.atan2(arrow_end.y - arrow_start.y, arrow_end.x - arrow_start.x) - math.pi / 2
    a = (arrow_head_w / 2) * math.cos(alpha)
    b = (arrow_head_w / 2) * math.sin(alpha)
    vtx0 = Point(arrow_end.x + a, arrow_end.y + b)
    vtx1 = Point(arrow_end.x - a, arrow_end.y - b)

    draw = ImageDraw.Draw(image)

    draw.line([top, arrow_start, arrow_end], fill=color, width=(line_width * scale), joint='curve')
    draw.polygon([arrow_head_end, vtx0, vtx1], fill=color)

    image = image.resize(img_size, resample=Image.LANCZOS)

    return image

def create_hq_image(offset: tuple[int, int], line_len: int):
    # Work on image double the size because it will be resized at the last step to have antialiasing.
    scale = 2
    image = Image.new('RGBA', (img_size[0] * scale, img_size[1] * scale))

    offset = (offset[0] * scale, offset[1] * scale)
    line_len *= scale

    color = (0, 0, 0)

    center = Point(image.size[0] / 2, image.size[1] / 2)

    top = Point(center.x + offset[0], center.y + offset[1])
    bottom = Point(top.x, top.y + line_len)

    draw = ImageDraw.Draw(image)

    draw.line([top, bottom], fill=color, width=(line_width * scale))

    image = image.resize(img_size, resample=Image.LANCZOS)

    return image

def create_ui_icon(angle: float):
    scale = 2
    image = Image.new('RGBA', (icon_size[0] * scale, icon_size[1] * scale))

    line_w = 3 * scale

    color = (255, 255, 255)
    arrow_head_w, arrow_head_h = (10 * scale, 10 * scale)
    arrow_len = int(0.80 * image.size[1] - arrow_head_h)

    center = Point(image.size[0] / 2, image.size[1] / 2)

    arrow_start = Point(center.x, int(0.10 * image.size[1]))
    arrow_end = Point(arrow_start.x, arrow_start.y + arrow_len)
    arrow_head_end = Point(arrow_start.x, arrow_start.y + (arrow_len + arrow_head_h))

    a = (arrow_head_w / 2)
    vtx0 = Point(arrow_end.x + a, arrow_end.y)
    vtx1 = Point(arrow_end.x - a, arrow_end.y)

    draw = ImageDraw.Draw(image)

    draw.line([arrow_start, arrow_end], fill=color, width=line_w, joint='curve')
    draw.polygon([arrow_head_end, vtx0, vtx1], fill=color)

    image = image.rotate(angle)
    image = image.transpose(Image.Transpose.FLIP_TOP_BOTTOM)
    image = image.resize(icon_size, resample=Image.LANCZOS)

    return image

def create_all_images(offsets: dict[str, dict[str, dict[str]]]):
    """Creates all images for the characters defined.

    Args:
        offsets (dict[str, dict[str, dict[str]]]): Markers to create. Contains the offsets and line lengths for direction and HQ direction markers.

    Returns:
        tuple(list(tuple(Image, Path))): A list of character image object and relative file path to the output directory. A list of UI icons.
    """

    images: list[tuple[ImageType, pathlib.Path]] = []
    for identity, identity_config in offsets.items():
        direction_dir = pathlib.Path(identity, 'dir')

        hq_image = create_hq_image(identity_config['hq']['offset'], identity_config['hq']['line'])
        hq_file = pathlib.Path(identity, f'mts_markers_{identity}_hq.png')
        images.append((hq_image, hq_file))

        for mod, mode_config in identity_config.items():
            for direction in directions:
                if mod == 'default':
                    file_name = f'mts_markers_{identity}_dir_{direction}.png'
                    image_dir = direction_dir
                else:
                    file_name = f'mts_markers_{identity}_dir_{mod}_{direction}.png'
                    image_dir = direction_dir / mod

                offset = mode_config['offset']
                line_len = mode_config['line']
                angle = 360 / len(directions) * directions.index(direction)

                image = create_dir_image(angle, offset, line_len)

                export_file = image_dir / file_name
                images.append((image, export_file))

    ui_dir = pathlib.Path('ui', 'dir')
    icons: list[tuple[ImageType, pathlib.Path]] = []
    for direction in directions:
        angle = 360 / len(directions) * directions.index(direction)
        icon = create_ui_icon(angle)

        ui_file = ui_dir / f'mts_markers_ui_dir_{direction}.png'
        icons.append((icon, ui_file))

    return images, icons

def write_include_files(output_dir: pathlib.Path, mods: list[str]):
    """Writes all marker into a include files.

    Args:
        path (Path): Path to the directory where the include files should be saved.
        mods (list[str]): Default, HQ, ... modifications.
    """
    with open(output_dir / f'CfgMarkersDirections.hpp', 'w') as f:
        comment = util.get_generated_comment_lines('Character markers for Direction of Movement')
        f.writelines(comment)

        for mod in mods:
            for direction in directions:
                if mod == 'default':
                    macro = get_dir_macro(direction)
                else:
                    macro = get_alternative_dir_macro(mod, direction)
                f.write(macro + '\n')

            f.write('\n')


def debug_create_marker(direction: str, identity: str = 'blu', hq: bool = False):
    direction = direction.upper()
    assert identity in offsets
    assert direction in directions

    dev_frame = pathlib.Path('frameshapes', f'{identity}_frameshape.png')
    with Image.open(dev_frame) as dev_img:
        angle = 360 / len(directions) * directions.index(direction)

        config = offsets[identity]['hq' if hq else 'default']

        img = create_dir_image(angle, offset=config['offset'], line_len=config['line'])
        dev_img = Image.alpha_composite(dev_img, img)

        dev_img.save(pathlib.Path('frameshapes', f'debug_{identity}_{direction}_{hq}.png'))
        dev_img.show()


def main(args: argparse.Namespace):
    start_time = timeit.default_timer()

    if sys.platform != 'win32':
        print('This tool is not support on non-windows devices due to missing Arma Tools.')
        sys.exit(2)

    # debug_create_marker('E', 'blu', hq=True)
    # return

    image_to_paa = util.find_image_to_paa_tool()
    print('Found ImageToPaa Tool:', image_to_paa)

    print('Creating images and icons...')
    images, icons = create_all_images(offsets)

    print('Cleaning export folder:', args.clean)
    if args.clean and args.output_dir.exists():
        shutil.rmtree(args.output_dir)

    print('Exporting only PNG files:', args.png_only)

    # Export images in parallel
    all_images = images + icons
    util.export_images(all_images, args.output_dir, args.workers, image_to_paa=image_to_paa, png_only=args.png_only)

    print(f'Exported {len(all_images)} images.\n')

    print('Creating include file...')
    write_include_files(args.output_dir, offsets['blu'].keys())

    print('Finished generating character marker files.')
    d,h,m,s = util.fract_sec(timeit.default_timer() - start_time)
    print(f'Total program time elapsed: {h:2}h {m:2}m {s:4.3f}s')


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='Creates direction of movement arrow markers and exports them as *.paa files.'
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
        '-c', '--clean',
        action='store_true',
        dest='clean',
        help='Remove all files and directories in the export directory before creating the markers.'
    )
    parser.add_argument(
        '-o', '--output',
        dest='output_dir',
        type=pathlib.Path,
        required=True,
        help='Output directory where all files will be exported to.'
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

# python create_direction_markers.py -o ./images --clean
