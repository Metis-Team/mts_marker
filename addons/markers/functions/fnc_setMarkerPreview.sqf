#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Displays the preview of the dimension specific marker.
 *
 *  Parameter(s):
 *      0: ARRAY - Dimension specific marker parameter.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_markerParameter] call mts_markers_fnc_setMarkerPreview
 *
 */

params [["_markerParameter", [], [[]]]];

private _mainDisplay = findDisplay MAIN_DISPLAY;
private _previewCtrlGrp = _mainDisplay displayCtrl PREVIEW_LYR_GRP;

// clear all layers
{
    ctrlDelete _x;
} forEach (allControls _previewCtrlGrp);

private _getPreviewImages = (GVAR(dimensions) get GVAR(currentDimension)) get "uiGetPreviewImages";
private _layers = _markerParameter call _getPreviewImages;

{
    private _ctrl = _mainDisplay ctrlCreate [QGVAR(RscPreviewLayer), -1, _previewCtrlGrp];
    _ctrl ctrlSetText _x;
} forEach _layers;
