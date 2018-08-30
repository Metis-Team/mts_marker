#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Event triggerd when mouse button is pressed on map to start moving the marker.
 *
 *  Parameter(s):
 *      0: CONTROL - Map control. (Optional, default: Map control)
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [(findDisplay 12) displayCtrl 51] call mts_markers_fnc_moveMarkerMouseDown
 *
 */

params [["_mapCtrl", controlNull, [controlNull]], ["_include3denMarker", false, [false]]];
CHECK(isNull _mapCtrl);

//get marker prefix
private _namePrefix = [_mapCtrl, _include3denMarker] call FUNC(getMouseOverMarkerPrefix);
CHECK(_namePrefix isEqualTo "");

//get marker set
private _markerFamily = [_namePrefix] call FUNC(getMarkerFamily);
CHECK(_markerFamily isEqualTo []);

private _originAlpha = markerAlpha (_markerFamily select 0);

GVAR(MarkerMoveInProgress) = true;

{
    _x setMarkerAlphaLocal 0.5;
} count _markerFamily;

// updating position of all markers in markerFamily while moving the marker & make marker see-through
if (is3DEN) then {
    GVAR(FHVars) = [_namePrefix, _markerFamily, _mapCtrl, _originAlpha];
    addMissionEventHandler ["EachFrame", {call FUNC(moveMarkerInProgress3DEN)}];
} else {
    //change cursor
    _mapCtrl ctrlMapCursor ["Track", "Move"];
    [FUNC(moveMarkerInProgress), 0, [_namePrefix, _markerFamily, _mapCtrl, _originAlpha]] call CBA_fnc_addPerFrameHandler;
};
