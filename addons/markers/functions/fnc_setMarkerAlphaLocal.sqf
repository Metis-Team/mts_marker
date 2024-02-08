#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Sets the transparancy (alpha) value of given marker.
 *      When alpha equals 1, the marker is visible, but if alpha equals 0, then the marker is invisible.
 *      This function has a local effect.
 *
 *  Parameter(s):
 *      0: STRING - Marker prefix.
 *      1: NUMBER - Alpha value from 0 (invisible) to 1 (fully visible).
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      ["mtsmarker#123/0/1", 0.5] call mts_markers_fnc_setMarkerAlphaLocal
 *
 */

params [["_namePrefix", "", [""]], ["_alpha", MARKER_ALPHA, [0]]];

CHECK(!hasInterface);
CHECKRET(_namePrefix isEqualTo "",ERROR("No marker prefix"));

// Get marker set
private _markerFamily = [_namePrefix] call FUNC(getMarkerFamily);
CHECK(_markerFamily isEqualTo []);

// Set alpha of marker set
{
    _x setMarkerAlphaLocal _alpha;
} count _markerFamily;

if (is3DEN) then {
    // Update 3DEN marker's alpha in attributes
    private _3denData = "Scenario" get3DENMissionAttribute QGVAR(3denData);
    private _index = _3denData findif {(_x select 0) isEqualTo _namePrefix};
    (_3denData select _index) set [5, _alpha];
    set3DENMissionAttributes [["Scenario", QGVAR(3denData), _3denData]];
};
