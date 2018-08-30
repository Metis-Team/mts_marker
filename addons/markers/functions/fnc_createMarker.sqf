#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Executes createMarkerLocal function with given player channel locality.
 *
 *  Parameter(s):
 *      0: ARRAY - Position where the marker will be placed.
 *      1: NUMBER - Channel ID where marker is broadcasted. (Check "currentChannel" command for channel ID; Use -1 for local creation (only with non-editable markers))
 *      2: BOOLEAN - Is marker editable.
 *      3: STRING - Frameshape of the marker. (blu, bludash, red, reddash, neu, unk, unkdash)
 *      4: ARRAY - Composition of modifier for the marker. (Optional, default: no modifiers)
 *          0: NUMBER - Icon (0 for none).
 *          1: NUMBER - Modifier 1 (0 for none).
 *          2: NUMBER - Modifier 2 (0 for none).
 *      5: ARRAY - Group size array. (Optional, default: no echelon)
 *          0: NUMBER - Group size (0 for none).
 *          1: BOOLEAN - Reinforced or (+) symbol.
 *          2: BOOLEAN - Reduced or (-) symbol (if both are true it will show (±)).
 *      6: ARRAY - Marker text left. (Optional, default: no text)
 *      7: STRING - Marker text right. (Optional, default: no text)
 *      8: NUMBER - Scale of the marker. (Optional, default: 1.3)
 *
 *  Returns:
 *      STRING - Marker prefix.
 *
 *  Example:
 *     _namePrefix = [[2000,1000], 1, true, "blu", [4,0,0], [4, false, true], ["3","3"], "9"] call mts_markers_fnc_createMarker
 *
 */

params [
    ["_pos", [0,0], [[]], [2,3]],
    ["_broadcastChannel", -1, [0]],
    ["_editable", true, [true]],
    ["_frameshape", "", [""]],
    ["_modifier", [0,0,0], [[]], 3],
    ["_size", [0,false,false], [[]], 3],
    ["_textleft", [], [[]]],
    ["_textright", "", [""]],
    ["_scale", MARKER_SCALE, [0]]
];

CHECKRET(((_broadcastChannel > 5) || (_broadcastChannel < -1)), ERROR("Channel ID not supported"));
CHECKRET(_frameshape isEqualTo "", ERROR("No frameshape"));

//get player UID
private _playerUID = getPlayerUID player;
if ((_playerUID isEqualTo "_SP_PLAYER_") || {_playerUID isEqualTo "_SP_AI_"} || {_playerUID isEqualTo ""}) then {
    _playerUID = "0";
};

private _namePrefix = [_editable, _playerUID, _broadcastChannel] call FUNC(generateUniquePrefix);
[_namePrefix, _broadcastChannel, _pos, _frameshape, _modifier, _size, _textleft, _textright, _scale] remoteExecCall [QFUNC(createMarkerLocal), ([_broadcastChannel] call FUNC(getBroadcastTargets)), true];

_namePrefix
