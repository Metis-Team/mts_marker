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
private _identity = (_mainDisplay displayctrl FRIENDLY_BTN_FRAME) getVariable [QGVAR(currentIdentitySelected), ""];
CHECKRET(_identity isEqualTo "", ERROR("No identity"));

//check if frameshape is dashed
private _dashedFrameshape = cbChecked (_mainDisplay displayCtrl MOD_CHECKBOX);

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

//get the left text (unique designation)
private _textleft = (toUpper (ctrlText (_mainDisplay displayCtrl UNIQUE_EDIT))) splitString "";

//get the right text (higher formation)
private _textright = ctrlText (_mainDisplay displayCtrl HIGHER_EDIT);


[[_identity, _dashedFrameshape], _modifier, [_grpsize, _reinforced, _reduced], _textleft, _textright]
