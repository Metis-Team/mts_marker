#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Mimic radio button behavior.
 *
 *  Parameter(s):
 *      0: CONTROL - Checkbox.
 *      1: NUMBER/BOOLEAN - Checkbox state.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_this, 1] call mts_markers_fnc_onOperationalConditionChanged
 *
 */

params ["_ctrl", ["_checked", 0, [0]]];

private _mainDisplay = ctrlParent _ctrl;
private _idc = ctrlIDC _ctrl;

if (_idc isEqualTo DAMAGED_CHECKBOX && _checked isEqualTo 1) then {
    (_mainDisplay displayCtrl DESTROYED_CHECKBOX) cbSetChecked false;
};
if (_idc isEqualTo DESTROYED_CHECKBOX && _checked isEqualTo 1) then {
    (_mainDisplay displayCtrl DAMAGED_CHECKBOX) cbSetChecked false;
};
