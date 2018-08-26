#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Event triggerd when marker is being moved.
 *
 *  Parameter(s):
 *      0: ARRAY - Arguments for the PerFrameHandler.
 *          0: ARRAY - All names of the marker set.
 *          1: ARRAY - Map control.
 *          2: ARRAY - Original marker alpha value.
 *      1: NUMBER - PerFrameHandler Id.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [[["mtsmarker#123/0/1_frame"], (findDisplay 12) displayCtrl 51, 1], 5] call mts_markers_fnc_moveMarkerInProgress
 *
 */

params ["_args", "_PFHID"];
_args params [["_markerFamily", [], [[]]], ["_mapCtrl", controlNull, [controlNull]], ["_originAlpha", 1, [0]]];

//exit PFH if player stops moving marker or exits map
if ((isNull _mapCtrl) || {!GVAR(MarkerMoveInProgress)}) exitWith {
    _PFHID call CBA_fnc_removePerFrameHandler;
    GVAR(MarkerMoveInProgress) = false;

    {
        _x setMarkerAlphaLocal _originAlpha;
    } count _markerFamily;

    //reset cursor
    _mapCtrl ctrlMapCursor ["Track", "Track"];

    //broadcast marker at new position
    private _lastPos = _mapCtrl posScreenToWorld getMousePosition;
    [_markerFamily, _lastPos] call FUNC(setMarkerPos);
};

//update marker position
private _mousePos = _mapCtrl posScreenToWorld getMousePosition;
{
    _x setMarkerPosLocal _mousePos;
} count _markerFamily;
