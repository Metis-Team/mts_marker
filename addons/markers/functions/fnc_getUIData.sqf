#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Returns all data of the UI.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      ARRAY - Frameshape, modifers, group size and text data.
 *
 *  Example:
 *      _UIData = call mts_markers_fnc_getUIData
 *
 */

private _mainDisplay = findDisplay MAIN_DISPLAY;

//get identity
private _identity = (_mainDisplay displayCtrl FRIENDLY_BTN_FRAME) getVariable [QGVAR(currentIdentitySelected), ""];
CHECKRET(_identity isEqualTo "",ERROR("No identity"));

// Check if frameshape is dashed or HQ
private _dashedFrameshape = cbChecked (_mainDisplay displayCtrl SUSPECT_CHECKBOX);
private _isHq = cbChecked (_mainDisplay displayCtrl HQ_CHECKBOX);

private _iconCtrl = _mainDisplay displayCtrl ICON_DROPDOWN;
private _mod1Ctrl = _mainDisplay displayCtrl MOD1_DROPDOWN;
private _mod2Ctrl = _mainDisplay displayCtrl MOD2_DROPDOWN;

//get values
private _lbIconValue = _iconCtrl lbValue (lbCurSel _iconCtrl);
private _lbMod1Value = _mod1Ctrl lbValue (lbCurSel _mod1Ctrl);
private _lbMod2Value = _mod2Ctrl lbValue (lbCurSel _mod2Ctrl);

//get all modifer
private _modifier = [_lbIconValue, _lbMod1Value, _lbMod2Value];

//get group size
private _grpsize = lbCurSel (_mainDisplay displayCtrl ECHELON_DROPDOWN);

//get echelon modifier values
private _reinforced = cbChecked (_mainDisplay displayCtrl REINFORCED_CHECKBOX);
private _reduced = cbChecked (_mainDisplay displayCtrl REDUCED_CHECKBOX);

//get the bottom left text (unique designation)
private _uniqueDesignation = (toUpper (ctrlText (_mainDisplay displayCtrl UNIQUE_EDIT))) splitString "";

//get the bottom right text (higher formation)
private _higherFormation = (toUpper (ctrlText (_mainDisplay displayCtrl HIGHER_EDIT))) splitString "";

//get the right text (additional information)
private _additionalInfo = ctrlText (_mainDisplay displayCtrl ADDITIONAL_EDIT);

// Operational condition
private _operationalCondition = OC_FULLY_CAPABLE;
if (cbChecked (_mainDisplay displayCtrl DAMAGED_CHECKBOX)) then {
    _operationalCondition = OC_DAMAGED;
};
if (cbChecked (_mainDisplay displayCtrl DESTROYED_CHECKBOX)) then {
    _operationalCondition = OC_DESTROYED;
};

// Get the Date-Time Group saved in the button
private _dateTimeGroup = (_mainDisplay displayCtrl DTG_BUTTON) getVariable [QGVAR(dateTimeGroup), []];

// Get direction of movement
private _directionSelIndex = lbCurSel (_mainDisplay displayCtrl DIRECTION_DROPDOWN);
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
