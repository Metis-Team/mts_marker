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

params [["_mapCtrl", controlNull, [controlNull]], ["_includeNoEditMarker", false, [false]]];
CHECKRET(isNull _mapCtrl, "");

private _mouseOverMarker = ctrlMapMouseOver _mapCtrl;
private _type = _mouseOverMarker param [0, ""];
CHECKRET(!(_type isEqualTo "marker"), "");
private _markerName = _mouseOverMarker select 1;

private _isMtsMarker = [_markerName] call FUNC(isMtsMarker);
CHECKRET(_isMtsMarker isEqualTo 0, "");

if (_isMtsMarker isEqualTo 1 || _includeNoEditMarker) exitWith {
    (_markerName splitString "_") select 0
};

""
