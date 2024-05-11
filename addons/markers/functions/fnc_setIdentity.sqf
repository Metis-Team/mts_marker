#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Executes commands for identity buttons.
 *      Saves the frameshape to a control.
 *
 *  Parameter(s):
 *      0: CONTROL - Marker configuration control group.
 *      0: STRING - Identity of button.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_identityCtrlGrp, "blu"] call mts_markers_fnc_setIdentity
 *
 */

params [["_cfgCtrlGrp", controlNull, [controlNull]], ["_identity", "blu", [""]]];

private _identityCtrlGrp = _cfgCtrlGrp controlsGroupCtrl IDENTITY_BUTTON_GROUP;
private _friendlyBtnCtrl = _identityCtrlGrp controlsGroupCtrl FRIENDLY_BTN_FRAME;
private _hostileBtnCtrl = _identityCtrlGrp controlsGroupCtrl HOSTILE_BTN_FRAME;
private _neutralBtnCtrl = _identityCtrlGrp controlsGroupCtrl NEUTRAL_BTN_FRAME;
private _unknownBtnCtrl = _identityCtrlGrp controlsGroupCtrl UNKNOWN_BTN_FRAME;
private _suspectedCbCtrl = _cfgCtrlGrp controlsGroupCtrl SUSPECT_CHECKBOX;
private _checkboxTxtCtrl = _cfgCtrlGrp controlsGroupCtrl SUSPECT_TXT;

{
    _x ctrlShow false;
} forEach [_friendlyBtnCtrl, _hostileBtnCtrl, _neutralBtnCtrl, _unknownBtnCtrl];

switch (_identity) do {
    case "blu": {
        //show the "suspected" button
        _suspectedCbCtrl ctrlShow true;
        _checkboxTxtCtrl ctrlSetText LLSTRING(ui_identity_assumed_friend);

        //show frame of the button
        _friendlyBtnCtrl ctrlShow true;
    };
    case "red": {
        //show the "suspected" button
        _suspectedCbCtrl ctrlShow true;
        _checkboxTxtCtrl ctrlSetText LLSTRING(ui_identity_suspect);

        //show frame of the button
        _hostileBtnCtrl ctrlShow true;
    };
    case "neu": {
        //hide the "suspected" button
        _suspectedCbCtrl ctrlShow false;
        _suspectedCbCtrl cbSetChecked false;
        _checkboxTxtCtrl ctrlSetText "";

        //show frame of the button
        _neutralBtnCtrl ctrlShow true;
    };
    case "unk": {
        //show the "suspected" button
        _suspectedCbCtrl ctrlShow true;
        _checkboxTxtCtrl ctrlSetText LLSTRING(ui_identity_pending);

        //show frame of the button
        _unknownBtnCtrl ctrlShow true;
    };
};

//save the current selected identity to the button
_cfgCtrlGrp setVariable [QGVAR(currentIdentitySelected), _identity];
