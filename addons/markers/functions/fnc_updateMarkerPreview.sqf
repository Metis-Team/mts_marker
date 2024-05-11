#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Gets the selected data from the UI and transfers it to the setMarkerPreview function.
 *
 *  Parameter(s):
 *      0: CONTROL - Marker configuration control group.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_cfgCtrlGrp] call mts_markers_fnc_updateMarkerPreview
 *
 */

params [["_cfgCtrlGrp", controlNull, [controlNull]]];

//get all data
private _getUIData = (GVAR(dimensions) get GVAR(currentDimension)) get "uiGetData";
private _markerParameter = [_cfgCtrlGrp] call _getUIData;

[_markerParameter] call FUNC(setMarkerPreview);
