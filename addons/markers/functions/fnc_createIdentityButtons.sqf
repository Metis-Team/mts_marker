#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Description
 *
 *  Parameter(s):
 *      0: TYPE - Parameter description
 *
 *  Returns:
 *      TYPE - Description
 *
 *  Example:
 *      _this call mts_markers_fnc_createIdentityButtons
 *
 */

params [["_parentCtrlGrp", controlNull, [controlNull]], ["_identites", [], [[]]]];

private _mainDisplay = ctrlParent _parentCtrlGrp;
private _identityBtnCtrlGrp = _mainDisplay ctrlCreate ["RscControlsGroupNoScrollbars", IDENTITY_BUTTON_GROUP, _parentCtrlGrp];
(ctrlPosition _parentCtrlGrp) params ["", "", "_parentCtrlGrpW", ""];

private _identityBtnCtrlGrpPos = [
    POS_W(0),
    POS_H(0.5),
    _parentCtrlGrpW,
    POS_H(FRAME_BUTTON_H + 2 * PADDING)
];
_identityBtnCtrlGrp ctrlSetPosition _identityBtnCtrlGrpPos;
_identityBtnCtrlGrp ctrlCommit 0;

private _btnCtrlGrp = _mainDisplay ctrlCreate ["RscControlsGroupNoScrollbars", -1, _identityBtnCtrlGrp];
private _numButtons = count _identites;

private _btnGrpW = POS_W(_numButtons * FRAME_BUTTON_W + (_numButtons + 1) * PADDING);
private _btnGrpH = POS_H(FRAME_BUTTON_H + 2 * PADDING);


_btnCtrlGrp ctrlSetPosition [
    (_identityBtnCtrlGrpPos select 2) / 2 - _btnGrpW / 2,
    (_identityBtnCtrlGrpPos select 3) / 2 - _btnGrpH / 2,
    _btnGrpW,
    _btnGrpH
];
_btnCtrlGrp ctrlCommit 0;

private _identityTxtCtrl = _mainDisplay ctrlCreate [QGVAR(RscText), -1, _identityBtnCtrlGrp];
private _identityTxtCtrlPos = [
    POS_W(0.5),
    (_identityBtnCtrlGrpPos select 3) / 2 - POS_H(1 / 2),
    POS_W(7.5),
    POS_H(1)
];
_identityTxtCtrl ctrlSetPosition _identityTxtCtrlPos;
_identityTxtCtrl ctrlSetText LLSTRING(ui_general_identityTXT);
_identityTxtCtrl ctrlCommit 0;

private _frameCtrlMap = createHashMap;
private _suspectTxtMap = createHashMap;

{
    _x params [["_identity", "", [""]], ["_icon", "", [""]], ["_tooltip", "", [""]], ["_suspectTxt", "", [""]]];

    private _xywh = [
        POS_W(_forEachIndex * FRAME_BUTTON_W + (_forEachIndex + 1) * PADDING),
        POS_H(PADDING),
        POS_W(FRAME_BUTTON_W),
        POS_H(FRAME_BUTTON_H)
    ];

    private _frameCtrl = _mainDisplay ctrlCreate [QGVAR(RscFrame), -1, _btnCtrlGrp];
    _frameCtrl ctrlSetPosition _xywh;
    _frameCtrl ctrlCommit 0;

    private _iconCtrl = _mainDisplay ctrlCreate ["RscPicture", -1, _btnCtrlGrp];
    _iconCtrl ctrlSetPosition _xywh;
    _iconCtrl ctrlSetText _icon;
    _iconCtrl ctrlCommit 0;

    private _btnCtrl = _mainDisplay ctrlCreate [QGVAR(RscTransparentButton), -1, _btnCtrlGrp];
    _btnCtrl ctrlSetPosition _xywh;
    _btnCtrl ctrlSetTooltip _tooltip;
    _btnCtrl ctrlCommit 0;

    _btnCtrl setVariable [QGVAR(identity), _identity];
    _btnCtrl ctrlAddEventHandler ["ButtonClick", LINKFUNC(onIdentityButtonClick)];

    _frameCtrlMap set [_identity, _frameCtrl];

    if (_suspectTxt isNotEqualTo "") then {
        _suspectTxtMap set [_identity, _suspectTxt];
    };
} forEach _identites;

_identityBtnCtrlGrp setVariable [QGVAR(frameCtrlMap), _frameCtrlMap];
_identityBtnCtrlGrp setVariable [QGVAR(suspectTxtMap), _suspectTxtMap];

private _suspectTextCtrl = _mainDisplay ctrlCreate [QGVAR(RscText), -1, _identityBtnCtrlGrp];
private _suspectTextCtrlPos = [
    (_identityBtnCtrlGrpPos select 2) - POS_W(7),
    _identityTxtCtrlPos select 1,
    POS_W(7 - 0.5),
    POS_H(1)
];
_suspectTextCtrl ctrlSetPosition _suspectTextCtrlPos;
_suspectTextCtrl ctrlCommit 0;

private _suspectCheckboxCtrl = _mainDisplay ctrlCreate [QGVAR(RscCheckBoxSound), -1, _identityBtnCtrlGrp];
_suspectCheckboxCtrl ctrlSetPosition [
    (_suspectTextCtrlPos select 0) - POS_W(1),
    _suspectTextCtrlPos select 1,
    POS_W(1),
    POS_H(1)
];
// Trigger update marker preview when checked
_suspectCheckboxCtrl ctrlAddEventHandler ["CheckedChanged", {[ctrlParentControlsGroup (_this select 0)] call FUNC(updateMarkerPreview)}];
_suspectCheckboxCtrl ctrlCommit 0;

_identityBtnCtrlGrp setVariable [QGVAR(suspectCtrls), [_suspectCheckboxCtrl, _suspectTextCtrl]];

_identityBtnCtrlGrp
