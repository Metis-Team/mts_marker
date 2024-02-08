#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Broadcast new marker position based on channel of origin.
 *
 *  Parameter(s):
 *      0: STRING - Marker prefix.
 *      1: ARRAY - New position for the marker set.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      ["mtsmarker#123/0/1", [300,1000]] call mts_markers_fnc_setMarkerPos
 *
 */

params [["_namePrefix", "", [""]], ["_newPos", [0,0], [[]], [2,3]]];

CHECKRET(_namePrefix isEqualTo "",ERROR("No marker prefix"));

//get channel ID from marker prefix
private _broadcastChannel = [_namePrefix] call FUNC(getBroadcastChannel);

CHECKRET(((_broadcastChannel > 5) || (_broadcastChannel < -1)),ERROR("Invalid marker prefix. No MTS marker"));

//broadcast marker depending on channel ID
[_namePrefix, _newPos] remoteExecCall [QFUNC(setMarkerPosLocal), ([_broadcastChannel] call FUNC(getBroadcastTargets)), true];

nil
