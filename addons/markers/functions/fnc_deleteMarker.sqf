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
CHECK(_namePrefix isEqualTo "");

//get marker set
private _markerInformation = GVAR(namespace) getVariable [_namePrefix, [[]]];
private _markerFamily = _markerInformation select 0;

//delete every marker in the set & delete it in the namespace
if !(_markerFamily isEqualTo []) then {
    {
        deleteMarker _x;
    } count _markerFamily;
    GVAR(namespace) setVariable [_namePrefix, nil, true];
};

if (is3DEN) then {
    //delete 3DEN marker from attribute
    private _3denData = "Scenario" get3DENMissionAttribute QGVAR(3denData);
    private _index = _3denData findif {(_x select 0) isEqualTo _namePrefix};
    _3denData deleteAt _index;
    set3DENMissionAttributes [["Scenario", QGVAR(3denData), _3denData]];
};
