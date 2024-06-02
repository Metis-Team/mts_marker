#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Handles clicked event of identity button.
 *
 *  Parameter(s):
 *      0: CONTROL - Button clicked.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_this select 0] call mts_markers_fnc_onIdentityButtonClick
 *
 */

params ["_btnCtrl"];

private _identityCtrlGrp = ctrlParentControlsGroup _btnCtrl;
private _cfgCtrlGrp = ctrlParentControlsGroup _identityCtrlGrp;

private _identity = _btnCtrl getVariable [QGVAR(identity), ""];

[_cfgCtrlGrp, _identity] call FUNC(setIdentity);

[_cfgCtrlGrp] call FUNC(updateMarkerPreview);
