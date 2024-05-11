#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Returns the Land Unit dimension specific marker configuration from the UI.
 *      This function is dimension specific and implements the "uiGetData" hook.
 *
 *  Parameter(s):
 *      0: CONTROL - Marker configuration control group.
 *
 *  Returns:
 *      ARRAY - Dimension specific marker configuration, i.e. frameshape, modifers, group size and text data.
 *
 *  Example:
 *      _markerParameter = [_cfgCtrlGrp] call mts_markers_fnc_getUIData
 *
 */

params [["_cfgCtrlGrp", controlNull, [controlNull]]];

//get identity
private _identity = _cfgCtrlGrp getVariable [QGVAR(currentIdentitySelected), ""];
if (_identity isEqualTo "") exitWith {
    ERROR_1("No identity saved in control group.",_cfgCtrlGrp);
    []
};

// Check if frameshape is dashed or HQ
private _dashedFrameshape = cbChecked (_cfgCtrlGrp controlsGroupCtrl SUSPECT_CHECKBOX);
private _isHq = cbChecked (_cfgCtrlGrp controlsGroupCtrl HQ_CHECKBOX);

private _iconCtrl = _cfgCtrlGrp controlsGroupCtrl ICON_DROPDOWN;
private _mod1Ctrl = _cfgCtrlGrp controlsGroupCtrl MOD1_DROPDOWN;
private _mod2Ctrl = _cfgCtrlGrp controlsGroupCtrl MOD2_DROPDOWN;

//get values
private _lbIconValue = _iconCtrl lbValue (lbCurSel _iconCtrl);
private _lbMod1Value = _mod1Ctrl lbValue (lbCurSel _mod1Ctrl);
private _lbMod2Value = _mod2Ctrl lbValue (lbCurSel _mod2Ctrl);

//get all modifer
private _modifier = [_lbIconValue, _lbMod1Value, _lbMod2Value];

//get group size
private _grpsize = lbCurSel (_cfgCtrlGrp controlsGroupCtrl ECHELON_DROPDOWN);

//get echelon modifier values
private _reinforced = cbChecked (_cfgCtrlGrp controlsGroupCtrl REINFORCED_CHECKBOX);
private _reduced = cbChecked (_cfgCtrlGrp controlsGroupCtrl REDUCED_CHECKBOX);

//get the bottom left text (unique designation)
private _uniqueDesignation = (toUpper (ctrlText (_cfgCtrlGrp controlsGroupCtrl UNIQUE_EDIT))) splitString "";

//get the bottom right text (higher formation)
private _higherFormation = (toUpper (ctrlText (_cfgCtrlGrp controlsGroupCtrl HIGHER_EDIT))) splitString "";

//get the right text (additional information)
private _additionalInfo = ctrlText (_cfgCtrlGrp controlsGroupCtrl ADDITIONAL_EDIT);

// Operational condition
private _operationalCondition = OC_FULLY_CAPABLE;
if (cbChecked (_cfgCtrlGrp controlsGroupCtrl DAMAGED_CHECKBOX)) then {
    _operationalCondition = OC_DAMAGED;
};
if (cbChecked (_cfgCtrlGrp controlsGroupCtrl DESTROYED_CHECKBOX)) then {
    _operationalCondition = OC_DESTROYED;
};

// Get the Date-Time Group saved in the button
private _dateTimeGroup = (_cfgCtrlGrp controlsGroupCtrl DTG_BUTTON) getVariable [QGVAR(dateTimeGroup), []];

// Get direction of movement
private _directionSelIndex = lbCurSel (_cfgCtrlGrp controlsGroupCtrl DIRECTION_DROPDOWN);
// Direction index 0 is no direction, 1 is N, 2 is NNE, ...
private _direction = "";
if (_directionSelIndex > 0 && _directionSelIndex < (count GVAR(directions) + 1)) then {
    _direction = GVAR(directions) select (_directionSelIndex - 1);
};

// These will be the marker parameters in createMarker
[
    [_identity, _dashedFrameshape, _isHq],
    _modifier,
    [_grpsize, _reinforced, _reduced],
    _uniqueDesignation,
    _additionalInfo,
    _higherFormation,
    _operationalCondition,
    _dateTimeGroup,
    _direction
]
