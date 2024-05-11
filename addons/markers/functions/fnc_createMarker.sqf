#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Creates marker with given channel locality.
 *
 *  Parameter(s):
 *      0: ARRAY - Position where the marker will be placed.
 *      1: NUMBER - Channel ID where marker is broadcasted. (Check "currentChannel" command for channel ID (-1 up to 5 are supported); Use -1 for local creation)
 *      2: BOOLEAN - Is the marker editable.
 *      3: STRING - Marker dimension identifier.
 *      4: ARRAY - The dimension specific marker configuration.
 *      5: NUMBER - Scale of the marker. (Optional, default: 1.3)
 *      6: NUMBER - Alpha of the marker. (Optional, default: 1)
 *
 *  Returns:
 *      STRING - Marker prefix.
 *
 *  Example:
 *     _namePrefix = [[2000,1000], 1, true, [["blu", false, false], [4,0,0], [4, false, true], ["3","3"], "9", ["4"]]] call mts_markers_fnc_createMarker
 *
 */

// Backwards compability
if (_this isEqualTypeParams [[], 0, true, []]) then {
    // Old parameter format without dimension
    _this insert [3, [DEFAULT_DIMENSION]];
};

params [
    ["_pos", [0,0], [[]], [2,3]],
    ["_broadcastChannel", -1, [0]],
    ["_editable", true, [true]],
    ["_dimension", "", [""]],
    ["_markerParameter", [], [[]]],
    ["_scale", MARKER_SCALE, [0]],
    ["_alpha", MARKER_ALPHA, [0]]
];

CHECKRET(((_broadcastChannel > 5) || (_broadcastChannel < -1)),ERROR("Channel ID not supported"));

//get player UID
private _playerUID = getPlayerUID player;
if ((_playerUID isEqualTo "_SP_PLAYER_") || {_playerUID isEqualTo "_SP_AI_"} || {_playerUID isEqualTo ""}) then {
    _playerUID = "0";
};

private _namePrefix = [_editable, _broadcastChannel, _playerUID] call FUNC(generateUniquePrefix);
[_namePrefix, _broadcastChannel, _pos, _dimension, _markerParameter, _scale, _alpha] remoteExecCall [QFUNC(createMarkerLocal), ([_broadcastChannel] call FUNC(getBroadcastTargets)), true];

_namePrefix
