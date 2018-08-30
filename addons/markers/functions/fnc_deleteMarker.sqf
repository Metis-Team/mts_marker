#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Deletes marker.
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

if (is3DEN) then {
    //delete 3DEN marker from attribute
    private _3denData = "Scenario" get3DENMissionAttribute QGVAR(3denData);
    private _index = _3denData findif {(_x select 0) isEqualTo _namePrefix};
    _3denData deleteAt _index;
    set3DENMissionAttributes [["Scenario", QGVAR(3denData), _3denData]];
};
