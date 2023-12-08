#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Updates the time slider to the correct position when focus is lost on time edit boxes.
 *
 *  Parameter(s):
 *      0: CONTROL - Time edit where hours or minutes can be entered.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      _this call mts_markers_fnc_onDTGTimeEditKillFocus
 *
 */

params ["_editCtrl"];

private _dtgDisplay = ctrlParent _editCtrl;
private _timeSliderCtrl = _dtgDisplay displayCtrl DTG_TIME_SLIDER;
private _timeHoursCtrl = _dtgDisplay displayCtrl DTG_HOURS_EDIT;
private _timeMinutesCtrl = _dtgDisplay displayCtrl DTG_MINUTES_EDIT;

private _value = round (parseNumber ctrlText _timeHoursCtrl * 3600 + parseNumber ctrlText _timeMinutesCtrl * 60);
_timeSliderCtrl sliderSetPosition _value;
_value = sliderPosition _timeSliderCtrl;

_timeHoursCtrl ctrlSetText ([floor (_value / 3600), 2] call CBA_fnc_formatNumber);
_timeMinutesCtrl ctrlSetText ([floor (_value / 60 % 60), 2] call CBA_fnc_formatNumber);
