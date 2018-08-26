#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Executes commands for identity buttons.
 *      Saves the frameshape to a control.
 *      Updates marker preview after selecting identity.
 *
 *  Parameter(s):
 *      0: STRING - Identity of button.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      ["blu"] call mts_markers_fnc_identityButtonsAction
 *
 */

params [["_identity", "", [""]]];

private _mainDisplay = findDisplay MAIN_DISPLAY;
private _friendlyBtnCtrl = _mainDisplay displayctrl FRIENDLY_BTN_FRAME;
private _hostileBtnCtrl = _mainDisplay displayctrl HOSTILE_BTN_FRAME;
private _neutralBtnCtrl = _mainDisplay displayctrl NEUTRAL_BTN_FRAME;
private _unknownBtnCtrl = _mainDisplay displayctrl UNKNOWN_BTN_FRAME;
private _suspectedCbCtrl = _mainDisplay displayctrl MOD_CHECKBOX;
private _checkboxTxtCtrl = _mainDisplay displayctrl CHECKBOX_TXT;

private _ctrlsToHide = [];
call {
    if (_identity isEqualTo "blu") exitWith {
        //show the "suspected" button
        _suspectedCbCtrl ctrlShow true;
        _checkboxTxtCtrl ctrlSetText LLSTRING(ui_identity_assumed_friend);

        //show frame of the button
        _friendlyBtnCtrl ctrlShow true;

        _ctrlsToHide = [_hostileBtnCtrl, _neutralBtnCtrl, _unknownBtnCtrl];
    };
    if (_identity isEqualTo "red") exitWith {
        //show the "suspected" button
        _suspectedCbCtrl ctrlShow true;
        _checkboxTxtCtrl ctrlSetText LLSTRING(ui_identity_suspect);

        //show frame of the button
        _hostileBtnCtrl ctrlShow true;

        _ctrlsToHide = [_friendlyBtnCtrl, _neutralBtnCtrl, _unknownBtnCtrl];
    };
    if (_identity isEqualTo "neu") exitWith {
        //hide the "suspected" button
        _suspectedCbCtrl ctrlShow false;
        _suspectedCbCtrl cbSetChecked false;
        _checkboxTxtCtrl ctrlSetText "";

        //show frame of the button
        _neutralBtnCtrl ctrlShow true;

        _ctrlsToHide = [_friendlyBtnCtrl, _hostileBtnCtrl, _unknownBtnCtrl];
    };
    if (_identity isEqualTo "unk") exitWith {
        //show the "suspected" button
        _suspectedCbCtrl ctrlShow true;
        _checkboxTxtCtrl ctrlSetText LLSTRING(ui_identity_pending);

        //show frame of the button
        _unknownBtnCtrl ctrlShow true;

        _ctrlsToHide = [_friendlyBtnCtrl, _hostileBtnCtrl, _neutralBtnCtrl]
    };
};

//hide all other frames
{
    _x ctrlShow false;
} count _ctrlsToHide;

//save the current selected identity to the button
_friendlyBtnCtrl setVariable [QGVAR(currentIdentitySelected), _identity];

//update marker preview
[false] call FUNC(transmitUIData);
