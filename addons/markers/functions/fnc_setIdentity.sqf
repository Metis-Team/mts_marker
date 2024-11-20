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
 *      [_cfgCtrlGrp, "blu"] call mts_markers_fnc_setIdentity
 *
 */

params [["_cfgCtrlGrp", controlNull, [controlNull]], ["_identity", "blu", [""]]];

private _identityCtrlGrp = _cfgCtrlGrp controlsGroupCtrl IDENTITY_BUTTON_GROUP;

private _frameCtrlMap = _identityCtrlGrp getVariable [QGVAR(frameCtrlMap), createHashMap];
private _suspectTxtMap = _identityCtrlGrp getVariable [QGVAR(suspectTxtMap), createHashMap];

private _suspectCtrls = _identityCtrlGrp getVariable [QGVAR(suspectCtrls), []];
_suspectCtrls params ["_suspectCheckboxCtrl", "_suspectTextCtrl"];

{
    _x ctrlShow false;
} forEach (values _frameCtrlMap);

private _identityFrameCtrl = _frameCtrlMap getOrDefault [_identity, controlNull];
CHECKRET(isNull _identityFrameCtrl,ERROR_1("Identity %1 not valid!",_identity));

_identityFrameCtrl ctrlShow true;

private _suspectTxt = _suspectTxtMap getOrDefault [_identity, ""];
if (_suspectTxt isEqualTo "") then {
    _suspectCheckboxCtrl ctrlShow false;
    _suspectCheckboxCtrl cbSetChecked false;
    _suspectTextCtrl ctrlSetText "";
} else {
    _suspectCheckboxCtrl ctrlShow true;
    _suspectTextCtrl ctrlSetText _suspectTxt;
};

//save the current selected identity to the button
_cfgCtrlGrp setVariable [QGVAR(currentIdentitySelected), _identity];
TRACE_1("Saved identity",_identity);
