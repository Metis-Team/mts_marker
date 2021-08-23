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
 *      3: ARRAY - Frameshape of the marker (For string (deprecated): blu, bludash, red, reddash, neu, unk, unkdash).
 *          0: STRING - Identity (blu, red, neu, unk).
 *          1: BOOLEAN - Dashed (e.g. supect).
 *      4: ARRAY - Composition of modifier for the marker. IDs are listed in the wiki. (Optional, default: no modifiers)
 *          0: NUMBER - Icon (0 for none).
 *          1: NUMBER - Modifier 1 (0 for none).
 *          2: NUMBER - Modifier 2 (0 for none).
 *      5: ARRAY - Group size array. (Optional, default: no echelon)
 *          0: NUMBER - Group size (0 for none).
 *          1: BOOLEAN - Reinforced or (+) symbol.
 *          2: BOOLEAN - Reduced or (-) symbol (if both are true it will show (±)).
 *      6: ARRAY - Marker text left. Can only be max. 3 characters. (Optional, default: no text)
 *      7: STRING - Marker text right. (Optional, default: no text)
 *      8: NUMBER - Scale of the marker. (Optional, default: 1.3)
 *
 *  Returns:
 *      STRING - Marker prefix.
 *
 *  Example:
 *     _namePrefix = [[2000,1000], 1, true, ["blu", false], [4,0,0], [4, false, true], ["3","3"], "9"] call mts_markers_fnc_createMarker
 *
 */

params [
    ["_pos", [0,0], [[]], [2,3]],
    ["_broadcastChannel", -1, [0]],
    ["_editable", true, [true]],
    ["_markerParameter", [], [[]]],
    ["_scale", MARKER_SCALE, [0]]
];

CHECKRET(((_broadcastChannel > 5) || (_broadcastChannel < -1)), ERROR("Channel ID not supported"));

CHECKRET(!(_frameshape isEqualTypeParams [ARR_2("", false)]) || ((_frameshape select 0) isEqualTo ""), ERROR("No frameshape or wrong format. Expected format: [STRING, BOOLEAN]"));

//get player UID
private _playerUID = getPlayerUID player;
if ((_playerUID isEqualTo "_SP_PLAYER_") || {_playerUID isEqualTo "_SP_AI_"} || {_playerUID isEqualTo ""}) then {
    _playerUID = "0";
};

private _namePrefix = [_editable, _broadcastChannel, _playerUID] call FUNC(generateUniquePrefix);
[_namePrefix, _broadcastChannel, _pos, _markerParameter, _scale] remoteExecCall [QFUNC(createMarkerLocal), ([_broadcastChannel] call FUNC(getBroadcastTargets)), true];

_namePrefix
