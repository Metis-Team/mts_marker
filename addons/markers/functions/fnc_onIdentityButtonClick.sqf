#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Handles clicked event of identity button.
 *
 *  Parameter(s):
 *      0: CONTROL - Button clicked.
 *      1: STRING - Identity of the button.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_this select 0, "blu"] call mts_markers_fnc_onIdentityButtonClick
 *
 */

params ["_btnCtrl", "_identity"];

private _identityCtrlGrp = ctrlParentControlsGroup _btnCtrl;
private _cfgCtrlGrp = ctrlParentControlsGroup _identityCtrlGrp;

[_cfgCtrlGrp, _identity] call FUNC(setIdentity);

[_cfgCtrlGrp] call FUNC(updateMarkerPreview);
