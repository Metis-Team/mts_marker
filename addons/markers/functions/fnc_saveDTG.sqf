#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Gets the UI data of the Date-Time Group and saves them in the DTG button for later processing.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      call mts_markers_fnc_saveDTG
 *
 */

private _mainDisplay = findDisplay MAIN_DISPLAY;
private _dtgButton = _mainDisplay displayCtrl DTG_BUTTON;

private _dateTimeGroup = [] call FUNC(getDTGUIData);

private _dtgChars = _dateTimeGroup call FUNC(toDTGCharaters);
_dtgButton ctrlSetText (_dtgChars joinString "");
_dtgButton setVariable [QGVAR(dateTimeGroup), _dateTimeGroup];
