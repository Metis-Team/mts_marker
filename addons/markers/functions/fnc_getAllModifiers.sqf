#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Returns all modifier names of the icon, mod1 and mod2 array.
 *
 *  Parameter(s):
 *      0: NUMBER - Icon (0 for none).
 *      1: NUMBER - Modifier 1 (0 for none).
 *      2: NUMBER - Modifier 2 (0 for none).
 *
 *  Returns:
 *      ARRAY - All valid modifier names.
 *
 *  Example:
 *      _allModifiers = [0,0,0] call mts_markers_fnc_getAllModifiers
 *
 */

params [["_iconIndex", 0, [0]], ["_mod1Index", 0, [0]], ["_mod2Index", 0, [0]]];

private _icon = GVAR(iconArray) select _iconIndex;
private _mod1 = GVAR(mod1Array) select _mod1Index;
private _mod2 = GVAR(mod2Array) select _mod2Index;

if (count _icon > 1) then {
    _icon = _icon select 1;
};

((_icon + _mod1 + _mod2) - ["empty"])
