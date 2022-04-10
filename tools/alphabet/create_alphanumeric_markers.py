#!/usr/bin/env python3

import os
import sys
import string
import pathlib
import subprocess
import shutil
import argparse
from PIL import Image, ImageFont, ImageDraw
from tqdm.contrib.concurrent import thread_map

if sys.platform == "win32":
    import winreg

# Configuration
version = '1.0.0'

alphabet = string.ascii_uppercase + string.digits
num_of_letters = 6
img_size = (1024, 1024)

text_v_offset = 66 # px left/right from center
text_h_offset = 55 # px down from center

# Parse args
parser = argparse.ArgumentParser(
    description='Creates alphanumeric markers used for the unique designation and higher formation and exports them as *.paa files.'
)
parser.add_argument(
    '-png', '--png-only',
    action='store_true',
    dest='png_only',
    help='Exports markers as *.png files',
)
parser.add_argument(
    '-nc', '--no-clean',
    action='store_true',
    dest='no_clean',
    help='Does not remove all files and directories in the export directory before creating the markers'
)
parser.add_argument(
    '-v', '--version',
    action='version',
    version=version,
    help='Displays the current version of the script'
)

args = parser.parse_args()

# Globals
png_only = args.png_only
delete_png = not args.png_only
clean_images = not args.no_clean

image_to_paa = ''

project_dir = os.path.dirname(__file__)
images_dir = os.path.join(project_dir, 'images')

font_file = os.path.join(project_dir, 'RobotoMono', 'static', 'RobotoMono-SemiBold.ttf')
font = ImageFont.truetype(font_file, size=35) # 26pt == 35px

def create_image(letter, pos, orientation = 'l'):
    img = Image.new('RGBA', img_size)

    letter_size = font.getbbox(letter, anchor='ls')
    letter_width = letter_size[2] - letter_size[0]
    letter_height = letter_size[3] - letter_size[1]

    # For some reason the width of the letter K is bigger then it should
    if (letter == 'K'):
        letter_width -= 1

    v_offset = text_v_offset
    if (orientation == 'l'):
        offset_direction = -1
        v_offset += letter_width
    else:
        offset_direction = 1

    x = img.size[0] / 2 + offset_direction * (v_offset + pos * letter_width)
    y = img.size[1] / 2 + text_h_offset

    draw = ImageDraw.Draw(img)
    draw.text((x, y), letter, fill=(0, 0, 0), font=font, anchor='ls')

    return img

def find_image_to_paa_tool():
    reg = winreg.ConnectRegistry(None, winreg.HKEY_CURRENT_USER)
    try:
        k = winreg.OpenKey(reg, r"Software\bohemia interactive\arma 3 tools")
        arma3tools_path = winreg.QueryValueEx(k, "path")[0]
        winreg.CloseKey(k)
    except:
        raise Exception("BadTools","Could not find Arma 3 Tools.")

    image_to_paa_path = os.path.join(arma3tools_path, "ImageToPAA", "ImageToPAA.exe")

    if os.path.isfile(image_to_paa_path):
        return image_to_paa_path
    else:
        raise Exception("BadTools", "Arma 3 Tools are not installed correctly.")

def save_image_as_paa(image_info):
    global image_to_paa

    path = image_info[0]
    img = image_info[1]

    file_dir = os.path.dirname(path)
    pathlib.Path(file_dir).mkdir(parents=True, exist_ok=True)

    file_name = os.path.basename(path)
    img.save(path)

    if sys.platform == "win32" and not png_only:
        subprocess.run([image_to_paa, path], stdout=subprocess.DEVNULL)

    if delete_png:
        pathlib.Path(path).unlink(missing_ok=True)

def main(args):
    global image_to_paa

    print('Using font file:', font_file)

    # dev_frame = os.path.join(project_dir, 'frameshapes', 'combined_frameshape.png')
    # dev_img = Image.open(dev_frame)
    # img = create_image('A', 0, 'l')
    # dev_img = Image.alpha_composite(dev_img, img)
    # dev_img.show()

    if sys.platform == "win32":
        image_to_paa = find_image_to_paa_tool()
        print('Found ImageToPaa Tool:', image_to_paa)
    else:
        print('Cannot find ImageToPaa on non-windows platform.')
        print('Images will not be converted.')
        delete_png = False

    print('Creating images...')

    images = []
    for orientation in ['l', 'r']:
        for pos in range(num_of_letters):
            export_dir = os.path.join(images_dir, orientation, str(pos))

            for letter in alphabet:
                img = create_image(letter, pos, orientation)

                file_name = f'mts_markers_com_{orientation}_{pos}_{letter}.png'
                export_file = os.path.join(export_dir, file_name)

                images.append((export_file, img))

    print('Cleaning export folder:', clean_images)
    if clean_images:
        shutil.rmtree(pathlib.Path(images_dir))

    print('Exporting only PNG files:', png_only)

    print('Exporting images...')

    # Multithreading
    thread_map(save_image_as_paa, images)

    print(f'Exported {len(images)} images')

if __name__ == "__main__":
    main(args)
