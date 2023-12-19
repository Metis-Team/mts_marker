#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Resets the Date-Time Group set in the DTG button.
 *      Does not pass the DTG data for marker creation.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      call mts_markers_fnc_clearDTG
 *
 */

private _mainDisplay = findDisplay MAIN_DISPLAY;
private _dtgButton = _mainDisplay displayCtrl DTG_BUTTON;

_dtgButton ctrlSetText "";
_dtgButton setVariable [QGVAR(dateTimeGroup), nil];
