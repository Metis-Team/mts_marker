// This file is generated and should not be edited

// Variables used for translating special characters into marker names
GVAR(specialCharactersTranslation) = createHashMapFromArray [
    ["#", "hash"],
    ["/", "slash"],
    ["\", "backslash"],
    [".", "dot"],
    ["+", "plus"],
    ["-", "minus"],
    [" ", "space"],
    ["(", "parenthesesleft"],
    [")", "parenthesesright"],
    ["[", "bracketsleft"],
    ["]", "bracketsright"],
    ["{", "bracesleft"],
    ["}", "bracesright"],
    ["=", "equal"],
    ["~", "tilde"],
    [":", "colon"],
    [",", "comma"],
    ["|", "pipe"],
    ["*", "asterisk"],
    ["^", "circumflex"],
    ["_", "underscore"]
];

// Variables used for validating characters
GVAR(alphanumCharacters) = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
// Variables used for validating characters
GVAR(specialCharacters) = ["#", "/", "\", ".", "+", "-", " ", "(", ")", "[", "]", "{", "}", "=", "~", ":", ",", "|", "*", "^", "_"];
GVAR(validCharacters) = GVAR(alphanumCharacters) + GVAR(specialCharacters);

