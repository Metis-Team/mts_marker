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

(_markerInformation select 1) params ["_frameshape", "_modifier", "_size", "_textLeft", "_textRight", "", "_scale"];

private _pos = _mapCtrl ctrlMapScreenToWorld _mousepos;

private _broadcastChannel = call {
    if (is3DEN) exitWith {
        0
    };
    if !(isMultiplayer) exitWith {
        -1
    };
    //Default/Multiplayer
    if (currentChannel > 5) then {3} else {currentChannel};
};

[_pos, _broadcastChannel, !is3DEN, _frameshape, _modifier, _size, _textLeft, _textRight, _scale] call FUNC(createMarker);
nil
