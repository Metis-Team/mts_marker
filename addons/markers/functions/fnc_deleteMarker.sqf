#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Deletes marker based on channel of origin.
 *
 *  Parameter(s):
 *      0: STRING - Marker prefix.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      ["mtsmarker#123/0/1"] call mts_markers_fnc_deleteMarker
 *
 */

params [["_namePrefix", "", [""]]];

CHECKRET(_namePrefix isEqualTo "", ERROR("No marker prefix"));

//get channel ID from marker prefix
private _broadcastChannel = [_namePrefix] call FUNC(getBroadcastChannel);

CHECKRET(((_broadcastChannel > 5) || (_broadcastChannel < -1)), ERROR("Invalid marker prefix. No MTS marker"));

//broadcast marker depending on channel ID
[_namePrefix] remoteExecCall [QFUNC(deleteMarkerLocal), ([_broadcastChannel] call FUNC(getBroadcastTargets)), true];

nil
