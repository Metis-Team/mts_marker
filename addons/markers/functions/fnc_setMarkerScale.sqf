#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Broadcast new marker scale/size based on channel of origin.
 *
 *  Parameter(s):
 *      0: STRING - Marker prefix.
 *      1: NUMBER - New marker scale.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      ["mtsmarker#123/0/1", 1.5] call mts_markers_fnc_setMarkerScale
 *
 */

params [["_namePrefix", "", [""]], ["_newScale", MARKER_SCALE, [0]]];

CHECKRET(_namePrefix isEqualTo "", ERROR("No marker prefix"));

//get channel ID from marker prefix
private _broadcastChannel = [_namePrefix] call FUNC(getBroadcastChannel);

CHECKRET(((_broadcastChannel > 5) || (_broadcastChannel < -1)), ERROR("Invalid marker prefix. No MTS marker"));

//broadcast marker depending on channel ID
[_namePrefix, _newScale] remoteExecCall [QFUNC(setMarkerScaleLocal), ([_broadcastChannel] call FUNC(getBroadcastTargets)), true];

nil
