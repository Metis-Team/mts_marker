#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Sets the transparancy (alpha) value of given marker.
 *      When alpha equals 1, the marker is visible, but if alpha equals 0, then the marker is invisible.
 *
 *  Parameter(s):
 *      0: STRING - Marker prefix.
 *      1: NUMBER - Alpha value from 0 (invisible) to 1 (fully visible).
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      ["mtsmarker#123/0/1", 0.5] call mts_markers_fnc_setMarkerAlpha
 *
 */

params [["_namePrefix", "", [""]], ["_alpha", MARKER_ALPHA, [0]]];

CHECKRET(_namePrefix isEqualTo "",ERROR("No marker prefix"));

// Get channel ID from marker prefix
private _broadcastChannel = [_namePrefix] call FUNC(getBroadcastChannel);

CHECKRET(((_broadcastChannel > 5) || (_broadcastChannel < -1)),ERROR("Invalid marker prefix. No MTS marker"));

// Broadcast marker depending on channel ID
[_namePrefix, _alpha] remoteExecCall [QFUNC(setMarkerAlphaLocal), ([_broadcastChannel] call FUNC(getBroadcastTargets)), true];

nil
