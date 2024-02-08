#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Sets the new marker position.
 *      This function has a local effect.
 *
 *  Parameter(s):
 *      0: STRING - Marker prefix.
 *      1: ARRAY - New marker position.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      ["mtsmarker#123/0/1", [2000,6500]] call mts_markers_fnc_setMarkerPosLocal
 *
 */

params [["_namePrefix", "", [""]], ["_newPos", [0,0], [[]], [2,3]]];
CHECK(!hasInterface);
CHECKRET(_namePrefix isEqualTo "",ERROR("No marker prefix"));

//get marker set
private _markerFamily = [_namePrefix] call FUNC(getMarkerFamily);
CHECK(_markerFamily isEqualTo []);

//move the marker set
{
    _x setMarkerPosLocal _newPos;
} count _markerFamily;

if (is3DEN) then {
    //update 3DEN marker's position in attributes
    private _3denData = "Scenario" get3DENMissionAttribute QGVAR(3denData);
    private _index = _3denData findif {(_x select 0) isEqualTo _namePrefix};
    (_3denData select _index) set [2, _newPos];
    set3DENMissionAttributes [["Scenario", QGVAR(3denData), _3denData]];
};
