#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Checks if marker is a MTS marker.
 *
 *  Parameter(s):
 *      0: STRING - Marker name.
 *
 *  Returns:
 *      NUMBER - 0: isn't a MTS marker, 1: is an editable MTS marker, 2: is a non-editable MTS marker.
 *
 *  Example:
 *      _ismtsmarker = ["mtsmarker#123/0/1"] call mts_markers_fnc_isMtsMarker
 *
 */

params [["_markerName", "", [""]]];
CHECKRET(_markerName isEqualTo "",0);

private _markerNamePrefix = toLower (_markerName select [0, 9]);

if (_markerNamePrefix isEqualTo "mtsmarker") exitWith {
    1
};
if (_markerNamePrefix isEqualTo "mtsnoedit") exitWith {
    2
};

0
