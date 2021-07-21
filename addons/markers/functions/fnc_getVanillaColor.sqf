#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Returns the Arma Vanilla color config name for a marker.
 *
 *  Parameter(s):
 *      0: STRING - Unit identity. (blu, red, neu, unk)
 *
 *  Returns:
 *      STRING - Arma Vanilla color config name or empty string if not found.
 *
 *  Example:
 *      ["blu"] call mts_markers_fnc_getVanillaColor
 *
 */

params ["_identity", "", [""]];

_identity = toLower _identity;

if (_identity isEqualTo "blu") exitWith {
    "colorBLUFOR"
};
if (_identity isEqualTo "red") exitWith {
    "colorOPFOR"
};
if (_identity isEqualTo "neu") exitWith {
    "colorIndependent"
};
if (_identity isEqualTo "unk") exitWith {
    "ColorUNKNOWN"
};

""
