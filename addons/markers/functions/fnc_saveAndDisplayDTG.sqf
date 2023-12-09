#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Saves and displays the Date-Time Group UI data in the DTG button for later processing.
 *
 *  Parameter(s):
 *      0: ARRAY - Date-Time Group information.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_dateTimeGroup] call mts_markers_fnc_saveAndDisplayDTG
 *
 */

params ["_dateTimeGroup"];

private _dtgButton = (findDisplay MAIN_DISPLAY) displayCtrl DTG_BUTTON;

private _dtgChars = _dateTimeGroup call FUNC(toDTGCharaters);
_dtgButton ctrlSetText (_dtgChars joinString "");
_dtgButton setVariable [QGVAR(dateTimeGroup), _dateTimeGroup];
