#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Deletes marker.
 *      This function has a local effect.
 *
 *  Parameter(s):
 *      0: STRING - Marker prefix.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      ["mtsmarker#123/0/1"] call mts_markers_fnc_deleteMarkerLocal
 *
 */

params [["_namePrefix", "", [""]]];
CHECK(!hasInterface);
CHECKRET(_namePrefix isEqualTo "",ERROR("No marker prefix"));

//get marker set
private _markerFamily = [_namePrefix] call FUNC(getMarkerFamily);
CHECK(_markerFamily isEqualTo []);

//delete every marker in the set
{
    deleteMarkerLocal _x;
} count _markerFamily;

GVAR(localMarkers) deleteAt _namePrefix;

if (is3DEN) then {
    //delete 3DEN marker from attribute
    private _3denData = "Scenario" get3DENMissionAttribute QGVAR(3denData);
    private _index = _3denData findif {(_x select 0) isEqualTo _namePrefix};
    _3denData deleteAt _index;
    set3DENMissionAttributes [["Scenario", QGVAR(3denData), _3denData]];
};
