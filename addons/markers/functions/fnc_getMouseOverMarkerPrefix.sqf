#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Returns the mts marker prefix of the pointed marker.
 *
 *  Parameter(s):
 *      0: CONTROL - Map control. (Optional, default: Map control)
 *      1: BOOLEAN - Include non-editable markers. (Optional, default: don't include)
 *
 *  Returns:
 *      STRING - Marker prefix name for the marker set or if failed it will return an empty string.
 *
 *  Example:
 *      _getMarkerFamily = [(findDisplay 12) displayCtrl 51] call mts_markers_fnc_getMouseOverMarkerPrefix
 *
 */

params [["_mapCtrl", controlNull, [controlNull]], ["_include3denMarker", false, [false]]];
CHECKRET(isNull _mapCtrl, "");

private _mouseOverMarker = ctrlMapMouseOver _mapCtrl;

if ([_mapCtrl, _include3denMarker] call FUNC(isMtsMarker)) exitWith {
    private _markerName = _mouseOverMarker select 1;
    private _namePrefix = (_markerName splitString "_") select 0;
    _namePrefix
};
""
