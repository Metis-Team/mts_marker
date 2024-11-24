#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Sets the scale/size of marker. (Same as vanilla setMarkerSizeLocal)
 *      This function has a local effect.
 *
 *  Parameter(s):
 *      0: STRING - Marker prefix.
 *      1: NUMBER - New marker scale.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      ["mtsmarker#123/0/1", 1.5] call mts_markers_fnc_setMarkerScaleLocal
 *
 */

params [["_namePrefix", "", [""]], ["_newScale", MARKER_SCALE, [0]]];
CHECK(!hasInterface);
CHECKRET(_namePrefix isEqualTo "",ERROR("No marker prefix"));

//get marker set
private _markerFamily = [_namePrefix] call FUNC(getMarkerFamily);
CHECK(_markerFamily isEqualTo []);

//set scale on the marker set
{
    _x setMarkerSizeLocal [_newScale, _newScale];
} count _markerFamily;

if (is3DEN) then {
    //update 3DEN marker's position in attributes
    private _3denData = "Scenario" get3DENMissionAttribute QGVAR(3denData);
    private _index = _3denData findIf {(_x select 0) isEqualTo _namePrefix};
    (_3denData select _index) set [4, _newScale];
    set3DENMissionAttributes [["Scenario", QGVAR(3denData), _3denData]];
};
