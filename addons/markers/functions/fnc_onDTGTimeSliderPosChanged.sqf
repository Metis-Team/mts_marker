#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Updates the time edits when the time slider is moved.
 *
 *  Parameter(s):
 *      0: CONTROL - Time slider which is moved.
 *      1: NUMBER - Current value of the slider.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      _this call mts_markers_fnc_onDTGTimeSliderPosChanged
 *
 */

params ["_timeSliderCtrl", "_value"];

_value = round _value;

private _dtgDisplay = ctrlParent _timeSliderCtrl;
(_dtgDisplay displayCtrl DTG_HOURS_EDIT) ctrlSetText ([floor (_value / 3600), 2] call CBA_fnc_formatNumber);
(_dtgDisplay displayCtrl DTG_MINUTES_EDIT) ctrlSetText ([floor (_value / 60 % 60), 2] call CBA_fnc_formatNumber);
