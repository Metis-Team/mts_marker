#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Returns the marker broadcast channel of origin.
 *
 *  Parameter(s):
 *      0: STRING - Marker prefix.
 *
 *  Returns:
 *      NUMBER - Channel ID where marker is broadcasted.
 *
 *  Example:
 *      _broadcastChannel = ["mtsmarker#123/0/1"] call mts_markers_fnc_getBroadcastChannel
 *
 */

params [["_namePrefix", "", [""]]];

CHECKRET(_namePrefix isEqualTo "",ERROR("No marker prefix"));

private _channelStr = switch ([_namePrefix] call FUNC(isMtsMarker)) do {
    case 1: {
        (_namePrefix splitString "/") param [2, ""]
    };
    case 2: {
        (_namePrefix splitString "~") param [1, ""]
    };
    default {
        ""
    };
};

if (_channelStr isEqualTo "") exitWith {BC_INVALID};
if (_channelStr isEqualTo BC_SCRIPTED_GLOBAL_MARKER_SUFFIX) exitWith {BC_SCRIPTED_GLOBAL};

parseNumber _channelStr
