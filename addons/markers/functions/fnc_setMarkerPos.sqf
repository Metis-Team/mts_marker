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
 *      ["mtsmarker#123/0/1", [300,1000]] call mts_markers_fnc_setMarkerPos
 *
 */

params [["_namePrefix", "", [""]], ["_newPos", [0,0], [[]], [2,3]]];

CHECKRET(_namePrefix isEqualTo "", ERROR("No marker prefix"));

//get channel ID from marker prefix
private _markerChannelId = parseNumber ((_namePrefix splitString "/") param [2, "-1"]);

CHECK((_markerChannelId > 5) || {_markerChannelId < -1});

//broadcast marker depending on channel ID
[_namePrefix, _newPos] remoteExecCall [QFUNC(setMarkerPosLocal), ([_markerChannelId] call FUNC(getBroadcastTargets)), true];
