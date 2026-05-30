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
 *      BOOLEAN - Successful.
 *
 *  Example:
 *      ["mtsmarker#123/0/1"] call mts_markers_fnc_deleteMarker
 *
 */

params [["_namePrefix", "", [""]]];

CHECKRET(_namePrefix isEqualTo "",ERROR("No marker prefix"); false);

//get channel ID from marker prefix
private _broadcastChannel = [_namePrefix] call FUNC(getBroadcastChannel);

CHECKRET(((_broadcastChannel > 5) || (_broadcastChannel < -1)),ERROR("Invalid marker prefix. No MTS marker"); false);

private _targets = [_broadcastChannel] call FUNC(getBroadcastTargets);

//broadcast marker depending on channel ID
[_namePrefix] remoteExecCall [
    QFUNC(deleteMarkerLocal),
    _targets,
    _targets isNotEqualTo 0
];

// We can only safely remove global markers from JIP
// Special cases are side markers where we do not remove JIP.
// Example: Create marker in west side -> switch side -> remove marker:
// The marker should still be created if JIP in west.
if (_targets isEqualTo 0) then {
    {
        private _jipId = format [QGVAR(%1_%2), _x, _namePrefix];
        remoteExec ["", _jipId]; // remove the order from the JIP queue
    } forEach ["createMarker", "setMarkerAlpha", "setMarkerPos", "setMarkerScale"];
};

true
