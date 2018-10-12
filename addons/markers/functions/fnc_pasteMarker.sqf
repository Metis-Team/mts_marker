#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Creates marker from previously saved marker prefix in copyMarker function.
 *
 *  Parameter(s):
 *      0: CONTROL - Map control.
 *      1: ARRAY - Mouse position on map.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *     [(findDisplay 12) displayCtrl 51, getMousePosition] call mts_markers_fnc_pasteMarker
 *
 */

params[["_mapCtrl", controlNull, [controlNull]], ["_mousepos", [0,0], [[]], [2]]];

CHECK(GVAR(clipboard) isEqualTo "");

private _markerInformation = GVAR(namespace) getVariable [GVAR(clipboard), []];
CHECK(_markerInformation isEqualTo []);

(_markerInformation select 1) params ["_frameshape", "_modifier", "_size", "_textLeft", "_textRight", "_broadcastChannel", "_scale"];

private _pos = _mapCtrl ctrlMapScreenToWorld _mousepos;

[_pos, _broadcastChannel, !is3DEN, _frameshape, _modifier, _size, _textLeft, _textRight, _scale] call FUNC(createMarker);
nil
