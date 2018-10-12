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
 *      Nothing.
 *
 *  Example:
 *      [(findDisplay 12) displayCtrl 51] call mts_markers_fnc_copyMarker
 *
 */

 params [["_mapCtrl", controlNull, [controlNull]]];
 CHECK(isNull _mapCtrl);

 private _namePrefix = [_mapCtrl, true] call FUNC(getMouseOverMarkerPrefix);
 CHECK(_namePrefix isEqualTo "");

GVAR(clipboard) = _namePrefix;
nil
