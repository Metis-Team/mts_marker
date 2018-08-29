#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Broadcast new marker pos to channel of the origin.
 *
 *  Parameter(s):
 *      0: ARRAY - Names of all markers in one set.
 *      1: ARRAY - New position for the marker set.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [["mtsmarker#123/0/1_frame"], [300,1000]] call mts_markers_fnc_setMarkerPos
 *
 */

params [["_markerFamily", [], [[]]], ["_newPos", [0,0], [[]], [2,3]]];
CHECK(_markerFamily isEqualTo []);

//get marker prefix from marker frameshape which is always present
private _markerFrame = _markerFamily select 0;
CHECK(!(_markerFrame isEqualType ""));
private _namePrefix = (_markerFrame splitString "_") select 0;


//get channel ID from marker prefix
private _markerChannelId = parseNumber ((_namePrefix splitString "/") param [2, "5"]);

//broadcast marker depending on channel ID
if ((_markerChannelId <= 4) && {_markerChannelId >= 0}) then {
    private _broadcastTargets = [
        (call CBA_fnc_players),
        playerSide,
        ((allGroups select {side _x isEqualTo playerSide}) apply {leader _x}),
        (units player),
        (crew cameraOn)
    ] select _markerChannelId;

    [_namePrefix, _newPos] remoteExecCall [QFUNC(setMarkerPosLocal), _broadcastTargets, true];
} else {
    [_namePrefix, _newPos] call FUNC(setMarkerPosLocal);
};
