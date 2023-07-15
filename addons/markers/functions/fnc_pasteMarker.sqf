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
 *      BOOLEAN - Successful.
 *
 *  Example:
 *     [(findDisplay 12) displayCtrl 51, getMousePosition] call mts_markers_fnc_pasteMarker
 *
 */

private _params = params [["_mapCtrl", controlNull, [controlNull]], ["_mousepos", [0,0], [[]], [2]]];

CHECKRET((GVAR(clipboard) isEqualTo "" || !_params), false);

GVAR(clipboard) params ["_namePrefix", "_scale"];

private _markerInformation = GVAR(namespace) getVariable [_namePrefix, []];
CHECKRET(_markerInformation isEqualTo [], false);

_markerInformation params ["", "_markerParameter"];

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

[_pos, _broadcastChannel, !is3DEN, _markerParameter, _scale] call FUNC(createMarker);
true
