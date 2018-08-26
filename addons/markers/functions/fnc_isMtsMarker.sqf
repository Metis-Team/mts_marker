#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Checks if pointed map marker is a MTS marker.
 *
 *  Parameter(s):
 *      0: CONTROL - Map control.
 *      1: BOOLEAN - Include the non editable 3DEN markers. (Optional, default: don't include)
 *
 *  Returns:
 *      BOOLEAN - Is mts marker.
 *
 *  Example:
 *      _ismtsmarker = [(findDisplay 12) displayCtrl 51] call mts_markers_fnc_isMtsMarker
 *
 */

params [["_mapCtrl", controlNull, [controlNull]], ["_include3denMarker", false, [false]]];
CHECKRET(isNull _mapCtrl, false);

scopeName "exit";

private _mouseOverMarker = ctrlMapMouseOver _mapCtrl;

if (count (_mouseOverMarker) isEqualTo 2) then {
    if ((_mouseOverMarker select 0) isEqualTo "marker") then {
        private _markerName = _mouseOverMarker select 1;
        if ((_markerName select [0, 9]) isEqualTo "mtsmarker") then {
            true breakOut "exit";
        };
        if (_include3denMarker && (_markerName select [0, 7]) isEqualTo "mts3DEN") then {
            true breakOut "exit";
        };
    };
};
false
