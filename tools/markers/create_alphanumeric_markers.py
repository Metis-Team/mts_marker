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
version = '1.2.0'

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

anchors = ['lb', 'rb']

def create_image(font: FreeTypeFont, letter: str, pos: int, anchor: str = 'lb'):
    """Creates a image of a character in given position and location (anchor).

    Args:
        font (FreeTypeFont): Character font.
        letter (str): The character to print.
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

    v_offset = text_v_offset
    if anchor == 'lb':
        offset_direction = -1
        v_offset += letter_width
    else:
        offset_direction = 1

    x = image.size[0] / 2 + offset_direction * (v_offset + pos * letter_width)
    y = image.size[1] / 2 + text_h_offset

    draw = ImageDraw.Draw(image)
    draw.text((x, y), letter, fill=(0, 0, 0), font=font, anchor='ls')

    return image

def create_all_images(char_sets: dict[str, dict[str]], anchors: list[str], font: FreeTypeFont):
    """Creates all images for the characters defined in given sets.

    Args:
        char_sets (dict[str, dict[str]]): Character sets to create.
        anchors (list[str]): The locations of the character relative to the frameshape to create.
        font (FreeTypeFont): Character font.

    Returns:
        list(tuple(Image, Path)): A list of character image object and relative file path to the output directory.
    """

    images: list[tuple[ImageType, pathlib.Path]] = []
    for set_name, alphabet in char_sets.items():
        for anchor in anchors:
            for pos in range(num_of_letters):
                image_dir = pathlib.Path(set_name, anchor, str(pos))

                for letter in alphabet['characters']:
                    image = create_image(font, letter, pos, anchor)

                    # Some chars are not allowed in file names, so replace them according
                    # a substitution table if available
                    if alphabet['substitutions'] is not None:
                        letter = alphabet['substitutions'].get(letter, letter)

                    file_name = f'mts_markers_{set_name}_{anchor}_{pos}_{letter}.png'
                    export_file = image_dir / file_name

                    images.append((image, export_file))

    return images

def write_translation_table(file: TextIOWrapper, char_sets: dict[str, dict[str]]):
    """Writes the SQF translation table for special characters to given file.

    Args:
        file (File): The file to write to.
    """

    for set_name, alphabet in char_sets.items():
        if alphabet['substitutions'] is None:
            continue

        file.write(f'// Variables used for translating special characters into marker names\n')
        file.write(f'GVAR({set_name}CharactersTranslation) = createHashMapFromArray [\n')

        num_of_chars = len(alphabet['substitutions'].items())
        for i, (char, substitution) in enumerate(alphabet['substitutions'].items()):
            comma = ',' if i != (num_of_chars - 1) else '' # Do not append comma when last array element
            file.write(f'    [\"{char}\", \"{substitution}\"]{comma}\n')

        file.write(f'];\n\n')

def write_valid_characters(file: TextIOWrapper, char_sets: dict[str, dict[str]]):
    """Writes the allowed/valid characters SQF variables to given file.

    Args:
        file (File): The file to write to.
        char_sets (dict[str, dict[str]]): Character sets created.
    """

    variables: list[str] = []
    for set_name, alphabet in char_sets.items():
        file.write(f'// Variables used for validating characters\n')

        chars = ', '.join(map(lambda c: f'\"{c}\"', alphabet['characters'])) # '"A", "B", "C", ...'
        var_name = f'GVAR({set_name}Characters)'
        variables.append(var_name)
        file.write(f'{var_name} = [{chars}];\n')

    variables_concat = ' + '.join(variables)
    file.write(f'GVAR(validCharacters) = {variables_concat};\n\n')

def write_include_files(output_dir: pathlib.Path, char_sets: dict[str, dict[str]], verbose: bool = False):
    """Writes all marker include files for the exported images.

    Args:
        output_dir (Path): Path to the output directory.
        char_sets (dict[str, dict[str]]): Character sets created.
        verbose (bool, optional): Print additional information to console. Defaults to False.
    """

    includes: list[str] = []
    for alphabet in char_sets.values():
        for anchor in anchors:
            file_name = f'{alphabet["cfg_name_prefix"]}{anchor.upper()}.hpp'
            includes.append(file_name)

            with open(output_dir / file_name, 'w') as f:
                comment = util.get_generated_comment_lines(f'Character markers for anchor {anchor}')
                f.writelines(comment)

                for pos in range(num_of_letters):
                    for letter in alphabet['characters']:
                        # Same as in the image creating process
                        if alphabet['substitutions'] is not None:
                            letter = alphabet['substitutions'].get(letter, letter)

                        macro = alphabet['get_macro'](anchor, pos, letter)
                        f.write(macro + '\n')

                    f.write('\n')

            if verbose:
                print(f'Created \"{file_name}\"')

    with open(output_dir / 'CfgMarkersCharacters.hpp', 'w') as f:
        for include in includes:
            f.write(f'#include \"{include}\"\n')

    if verbose:
        print('Created \"CfgMarkersCharacters.hpp\"\n')

def write_marker_variables(output_dir: pathlib.Path, char_sets: dict[str, dict[str]]):
    path = output_dir / 'initCharacterMarkerVariables.hpp'
    with open(path, 'w') as f:
        comment = util.get_generated_comment_lines()
        f.writelines(comment)

        write_translation_table(f, char_sets)
        write_valid_characters(f, char_sets)

    return path

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
    print(f'Found ImageToPaa tool: \"{image_to_paa}\"')

    print('Creating images...')
    images = create_all_images(printable_char_sets, anchors, font)

    print('Cleaning export folder:', clean_images)
    if clean_images:
        shutil.rmtree(args.output_dir)

    print('Exporting only PNG files:', png_only)

    # Export images in parallel
    util.export_images(images, args.output_dir, args.workers, image_to_paa=image_to_paa, png_only=png_only)

    print(f'Exported {len(images)} images.\n')

    print('Creating include files...')
    write_include_files(args.output_dir, printable_char_sets, verbose=True)

    print('Generating SQF substitute tables and character variables...')
    path = write_marker_variables(args.output_dir, printable_char_sets)
    print(f'Created \"{path.name}\"\n')

    print('Finished generating character marker files.')
    d,h,m,s = util.fract_sec(timeit.default_timer() - start_time)
    print(f'Total program time elapsed: {h:2}h {m:2}m {s:4.3f}s')


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='Creates alphanumeric markers used for the unique designation and higher formation and exports them as *.paa files.'
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

# python create_alphanumeric_markers.py -o ./images
