#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Retrieves the selected data from the UI and transfers it to the createMarker function.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [] call mts_markers_fnc_transmitUIData
 *
 */

private _mainDisplay = findDisplay MAIN_DISPLAY;

//get all data
private _cfgCtrlGrp = (_mainDisplay displayCtrl CONFIG_DIMENSION_GROUP) getVariable [QGVAR(currentCfgCtrlGrp), controlNull];
private _getUIData = (GVAR(dimensions) get GVAR(currentDimension)) get "uiGetData";
private _markerParameter = [_cfgCtrlGrp] call _getUIData;

private _validateUIData = (GVAR(dimensions) get GVAR(currentDimension)) get "uiValidateData";
private _parameterAreValid = [_markerParameter] call _validateUIData;
TRACE_1("Validation",_parameterAreValid);
CHECK(!_parameterAreValid);

private _broadcastChannel = call {
    if (is3DEN) exitWith {
        0
    };
    if (!isMultiplayer) exitWith {
        -1
    };
    private _channelCtrl = _mainDisplay displayCtrl CHANNEL_DROPDOWN;
    _channelCtrl lbValue (lbCurSel _channelCtrl)
};
setCurrentChannel _broadcastChannel;

private _markerScale = sliderPosition (_mainDisplay displayCtrl SCALE_SLIDER);
private _markerAlpha = sliderPosition (_mainDisplay displayCtrl ALPHA_SLIDER);

//check if marker is being editing, if so delete old marker and create new one
private _editMarkerNamePrefix = _mainDisplay getVariable [QGVAR(editMarkerNamePrefix), ""];
if (_editMarkerNamePrefix isNotEqualTo "") then {
    [_editMarkerNamePrefix] call FUNC(deleteMarker);
};

if (GVAR(saveLastSelection)) then {
    // Only save frameshape, modifier and size
    GVAR(lastSelection) = _markerParameter select [0, 3];
};

private _pos = _mainDisplay getVariable [QGVAR(createMarkerMousePosition), [0, 0]];

[_pos, _broadcastChannel, !is3DEN, _markerParameter, _markerScale, _markerAlpha] call FUNC(createMarker);
_mainDisplay closeDisplay 1;
