#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Returnes broadcast targets for remoteExec based on the broadcast channel.
 *
 *  Parameter(s):
 *      0: NUMBER - Broadcast channel.
 *
 *  Returns:
 *      ARRAY/SIDE/OBJECT - Broadcast targets. Array of players, player side or player object.
 *
 *  Example:
 *      [0] call mts_markers_fnc_getBroadcastTargets
 *
 */

params [["_broadcastChannel", -1, [0]]];

switch (_broadcastChannel) do {
    case 0: {
        (call CBA_fnc_players)
    };
    case 1: {
        playerSide
    };
    case 2: {
        ((allGroups select {side _x isEqualTo playerSide}) apply {leader _x})
    };
    case 3: {
        (units player)
    };
    case 4: {
        (crew cameraOn)
    };
    case 5: {
        ((call CBA_fnc_players) select {_x distance player <= 40})
    };
    default {
        player
    };
};