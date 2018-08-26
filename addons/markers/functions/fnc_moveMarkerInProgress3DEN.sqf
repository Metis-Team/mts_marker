#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Event triggerd when marker is being moved in 3DEN editor.
 *
 *  Parameter(s):
 *      None
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      call mts_markers_fnc_moveMarkerInProgress3DEN
 *
 */

GVAR(FHVars) params [["_markerFamily", [], [[]]], ["_mapCtrl", controlNull, [controlNull]], ["_originAlpha", 1, [0]]];

//exit PFH if player stops moving marker or exits map
if ((isNull _mapCtrl) || {!GVAR(MarkerMoveInProgress)}) exitWith {
    removeMissionEventHandler ["EachFrame", _thisEventHandler];
    GVAR(MarkerMoveInProgress) = false;

    {
        _x setMarkerAlphaLocal _originAlpha;
    } count _markerFamily;

    //broadcast marker at new position
    private _lastPos = _mapCtrl posScreenToWorld getMousePosition;
    [_markerFamily, _lastPos] call FUNC(setMarkerPos);
};

//update marker position
private _mousePos = _mapCtrl posScreenToWorld getMousePosition;
{
    _x setMarkerPosLocal _mousePos;
} count _markerFamily;
