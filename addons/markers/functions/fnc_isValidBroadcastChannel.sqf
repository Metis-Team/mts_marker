#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Check if given channel is a supported broadcast channel.
 *
 *  Parameter(s):
 *      0: NUMBER - Broadcast channel.
 *
 *  Returns:
 *      BOOLEAN - True if valid/supported; otherwise false.
 *
 *  Example:
 *      [-10] call mts_markers_fnc_isValidBroadcastChannel
 *
 */

params [["_broadcastChannel", -2, [0]]];

_broadcastChannel <= 5 && {_broadcastChannel >= -1 || _broadcastChannel isEqualTo -10}
