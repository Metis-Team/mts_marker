#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Save valid marker nameprefix into global variable.
 *
 *  Parameter(s):
 *      0: CONTROL - Map control.
 *
 *  Returns:
 *      BOOLEAN - Successful.
 *
 *  Example:
 *      [(findDisplay 12) displayCtrl 51] call mts_markers_fnc_copyMarker
 *
 */

params [["_mapCtrl", controlNull, [controlNull]]];
CHECKRET(isNull _mapCtrl, false);

private _namePrefix = [_mapCtrl, true] call FUNC(getMouseOverMarkerPrefix);
CHECKRET(_namePrefix isEqualTo "", false);

private _scale = _namePrefix call FUNC(getMarkerScale);

GVAR(clipboard) = [_namePrefix, _scale];
true
