#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Returns the marker type class for a character.
 *      Handles all characters such as alphanum and special.
 *
 *  Parameter(s):
 *      0: STRING - The marker prefix.
 *      1: STRING - The field the character is located. Can only be "higherFormation" or "uniqueDesignation".
 *      2: NUMBER - The position of the character. A smaller pos means closer to center/frameshape.
 *      3: STRING - The character to depict. MUST be uppercase!
 *
 *  Returns:
 *      ARRAY - Marker type and it's composition.
 *          0: STRING - The type used to create the marker.
 *          1: STRING - The full marker name that should be used.
 *          2: ARRAY - The composition of the type.
 *              0: STRING - The marker prefix.
 *              1: STRING - The type of character marker: "alphanum" or "special"
 *              2: STRING - The anchor of the character: "rb" or "lb"
 *              3: NUMBER - Position of the character
 *              4: STRING - The character itself but if it's special the translated version. E.g. # -> "hash"
 *
 *  Example:
 *      ["mtsmarker#123/0/1", "higherFormation", 2, "/"] call mts_markers_fnc_getCharMarkerType
 *
 */

params [["_namePrefix", "", [""]], ["_field", "", [""]], ["_pos", 0, [0]], ["_char", "", [""]]];

private _anchor = switch (_field) do {
    case "higherFormation": {
        "rb"
    };
    case "uniqueDesignation": {
        "lb"
    };
};

private _charId = _char;
private _charType = "alphanum";
if (_char in GVAR(specialCharacters)) then {
    _charId = GVAR(specialCharactersTranslation) get _char;
    _charType = "special";
};

private _type = format ["mts_%1_%2_%3_%4", _charType, _anchor, _pos, _charId];
private _markerName = format ["%1_%2_%3_%4_%5", _namePrefix, _charType, _anchor, _pos, _charId];

[_type, _markerName, [_namePrefix, _charType, _anchor, _pos, _charId]]
