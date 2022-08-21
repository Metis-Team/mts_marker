#!/usr/bin/env python3

import os
import sys
import string
import pathlib
import subprocess
import shutil
import argparse
import timeit
from PIL import Image, ImageFont, ImageDraw
from tqdm.contrib.concurrent import thread_map

if sys.platform == 'win32':
    import winreg

# Configuration
version = '1.1.0'

# Some char cannot used in file names.
# That's why we need to substitute the char with another string.
# Keys are the special chars, values is whats used as the file name.
special_chars = {
    '#': 'hash',
    '/': 'slash',
    '\\': 'backslash',
    '.': 'dot',
    '+': 'plus',
    '-': 'minus',
    ' ': 'space',
    '(': 'parenthesesleft',
    ')': 'parenthesesright',
    '[': 'bracketsleft',
    ']': 'bracketsright',
    '{': 'bracesleft',
    '}': 'bracesright',
    '=': 'equal',
    '~': 'tilde',
    ':': 'colon',
    ',': 'comma',
    '|': 'pipe',
    '*': 'asterisk',
    '^': 'circumflex',
    '_': 'underscore',
}

def get_alphanum_macro(anchor, pos, letter):
    return f'ALPHANUMMARKER({anchor},{pos},{letter});'

def get_special_macro(anchor, pos, letter):
    return f'SPECIALCHARMARKER({anchor},{pos},{letter});'

printable_char_sets = {
    'alphanum': {
        'characters': string.ascii_uppercase + string.digits,
        'substitutions': None,
        'cfg_name_prefix': 'CfgMarkersAlphanumeric',
        'get_macro': get_alphanum_macro,
    },
    'special': {
        'characters': ''.join(special_chars.keys()),
        'substitutions': special_chars,
        'cfg_name_prefix': 'CfgMarkersSpecialChars',
        'get_macro': get_special_macro,
    }
}

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

anchors = ['lb', 'rb']

def create_image(letter, pos, anchor = 'lb'):
    img = Image.new('RGBA', img_size)

    letter_size = font.getbbox(letter, anchor='ls')
    letter_width = letter_size[2] - letter_size[0]
    letter_height = letter_size[3] - letter_size[1]

    # For some reason the width of the letter K is bigger then it should
    if letter == 'K':
        letter_width -= 1

    v_offset = text_v_offset
    if anchor == 'lb':
        offset_direction = -1
        v_offset += letter_width
    else:
        offset_direction = 1

    x = img.size[0] / 2 + offset_direction * (v_offset + pos * letter_width)
    y = img.size[1] / 2 + text_h_offset

    draw = ImageDraw.Draw(img)
    draw.text((x, y), letter, fill=(0, 0, 0), font=font, anchor='ls')

    return img

def create_all_images():
    images = []
    for set_name, alphabet in printable_char_sets.items():
        for anchor in anchors:
            for pos in range(num_of_letters):
                export_dir = os.path.join(images_dir, set_name, anchor, str(pos))

                for letter in alphabet['characters']:
                    img = create_image(letter, pos, anchor)

                    # Some chars are not allowed in file names, so replace them according
                    # a substitution table if available
                    if alphabet['substitutions'] is not None:
                        letter = alphabet['substitutions'].get(letter, letter)

                    file_name = f'mts_markers_{set_name}_{anchor}_{pos}_{letter}.png'
                    export_file = os.path.join(export_dir, file_name)

                    images.append((export_file, img))

    return images

def find_image_to_paa_tool():
    reg = winreg.ConnectRegistry(None, winreg.HKEY_CURRENT_USER)
    try:
        k = winreg.OpenKey(reg, r'Software\bohemia interactive\arma 3 tools')
        arma3tools_path = winreg.QueryValueEx(k, 'path')[0]
        winreg.CloseKey(k)
    except:
        raise Exception('BadTools', 'Could not find Arma 3 Tools.')

    image_to_paa_path = os.path.join(arma3tools_path, 'ImageToPAA', 'ImageToPAA.exe')

    if os.path.isfile(image_to_paa_path):
        return image_to_paa_path
    else:
        raise Exception('BadTools', 'Arma 3 Tools are not installed correctly.')

def save_image_as_paa(image_info):
    global image_to_paa

    path = image_info[0]
    img = image_info[1]

    file_dir = os.path.dirname(path)
    pathlib.Path(file_dir).mkdir(parents=True, exist_ok=True)

    file_name = os.path.basename(path)
    img.save(path)

    if sys.platform == 'win32' and not png_only:
        subprocess.run([image_to_paa, path], stdout=subprocess.DEVNULL)

    if delete_png:
        pathlib.Path(path).unlink(missing_ok=True)

def write_translation_table(file):
    for set_name, alphabet in printable_char_sets.items():
        if alphabet['substitutions'] is None:
            continue

        file.write(f'// Variables used for translating special characters into marker names\n')
        file.write(f'GVAR({set_name}CharactersTranslation) = createHashMapFromArray [\n')

        num_of_chars = len(alphabet['substitutions'].items())
        for i, (char, substitution) in enumerate(alphabet['substitutions'].items()):
            comma = ',' if i != (num_of_chars - 1) else '' # Do not append comma when last array element
            file.write(f'    [\"{char}\", \"{substitution}\"]{comma}\n')

        file.write(f'];\n\n')

def write_valid_characters(file):
    variables = []
    for set_name, alphabet in printable_char_sets.items():
        file.write(f'// Variables used for validating characters\n')

        chars = ', '.join(map(lambda c: f'\"{c}\"', alphabet['characters'])) # '"A", "B", "C", ...'
        var_name = f'GVAR({set_name}Characters)'
        variables.append(var_name)
        file.write(f'{var_name} = [{chars}];\n')

    variables_concat = ' + '.join(variables)
    file.write(f'GVAR(validCharacters) = {variables_concat};\n\n')

def write_include_files(verbose=False):
    includes = []
    for alphabet in printable_char_sets.values():
        for anchor in anchors:
            file_name = f'{alphabet["cfg_name_prefix"]}{anchor.upper()}.hpp'
            includes.append(file_name)

            with open(os.path.join(images_dir, file_name), 'w') as f:
                f.write(f'// Character markers for anchor {anchor}\n')
                f.write(f'// This file is generated and should not be edited\n\n')

                for pos in range(num_of_letters):
                    for letter in alphabet['characters']:
                        # Same as in the image creating process
                        if alphabet['substitutions'] is not None:
                            letter = alphabet['substitutions'].get(letter, letter)

                        macro = alphabet['get_macro'](anchor, pos, letter)
                        f.write(macro + '\n')

                    f.write('\n')

            if verbose:
                print(f'Created {file_name}')

    with open(os.path.join(images_dir, 'CfgMarkersCharacters.hpp'), 'w') as f:
        for include in includes:
            f.write(f'#include \"{include}\"\n')

    if verbose:
        print('Created CfgMarkersCharacters.hpp\n')

def fract_sec(s):
    temp = float(s) / (60 * 60 * 24)
    d = int(temp)
    temp = (temp - d) * 24
    h = int(temp)
    temp = (temp - h) * 60
    m = int(temp)
    temp = (temp - m) * 60
    sec = temp

    return d,h,m,sec

def main(args):
    global image_to_paa

    start_time = timeit.default_timer()

    print('Using font file:', font_file)

    # dev_frame = os.path.join(project_dir, 'frameshapes', 'combined_frameshape.png')
    # dev_img = Image.open(dev_frame)
    # img = create_image('A', 0, 'lb')
    # dev_img = Image.alpha_composite(dev_img, img)
    # dev_img.show()

    if sys.platform == 'win32':
        image_to_paa = find_image_to_paa_tool()
        print('Found ImageToPaa Tool:', image_to_paa)
    else:
        print('Cannot find ImageToPaa on non-windows platform.')
        print('Images will not be converted.')
        delete_png = False

    print('Creating images...')
    images = create_all_images()

    print('Cleaning export folder:', clean_images)
    if clean_images:
        shutil.rmtree(pathlib.Path(images_dir))

    print('Exporting only PNG files:', png_only)
    print('Exporting images...')
    # Convert images to paa with multithreading
    thread_map(save_image_as_paa, images)
    print(f'Exported {len(images)} images\n')

    print('Creating include files...')
    write_include_files(True)

    print('Generating SQF substitute tables and character variables...')
    with open(os.path.join(images_dir, 'initCharacterMarkerVariables.hpp'), 'w') as f:
        f.write(f'// This file is generated and should not be edited\n\n')

        write_translation_table(f)
        write_valid_characters(f)

    print('Created initCharacterMarkerVariables.hpp\n')

    print('Finished generating character marker files.')
    d,h,m,s = fract_sec(timeit.default_timer() - start_time)
    print(f'Total program time elapsed: {h:2}h {m:2}m {s:4.3f}s')


if __name__ == "__main__":
    main(args)
