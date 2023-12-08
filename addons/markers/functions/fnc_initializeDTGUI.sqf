#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Opens the Date-Time Group configuration sub dialog.
 *      Initializes the UI.
 *      Adds Combobox selections.
 *
 *  Parameter(s):
 *      0: DISPLAY - Parent display on which the dialog should appear.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [findDisplay 5000] call mts_markers_fnc_initializeDTGUI
 *
 */

params [["_parentDisplay", displayNull, [displayNull]]];

// Open Date-Time Group configuration
private _dtgDisplay = _parentDisplay createDisplay QGVAR(DTGDialog);
CHECKRET(isNull _dtgDisplay, ERROR("Failed to create DTG dialog"));

private _dateYearCtrl = _dtgDisplay displayCtrl DTG_YEAR_DROPDOWN;
private _dateMonthCtrl = _dtgDisplay displayCtrl DTG_MONTH_DROPDOWN;
private _dateDayCtrl = _dtgDisplay displayCtrl DTG_DAY_DROPDOWN;
private _timeZoneCtrl = _dtgDisplay displayCtrl DTG_TIMEZONE_DROPDOWN;
private _timeSliderCtrl = _dtgDisplay displayCtrl DTG_TIME_SLIDER;

private _minYear = MIN_YEAR;
private _maxYear = MAX_YEAR;

for "_year" from _minYear to _maxYear step 1 do {
    private _index = _dateYearCtrl lbAdd (str _year);
    _dateYearCtrl lbSetValue [_index, _year];
};

for "_month" from 1 to 12 step 1 do {
    private _dropdownText = format ["str_3den_attributes_date_month%1_text", _month];
    private _index = _dateMonthCtrl lbAdd (localize _dropdownText);
    _dateMonthCtrl lbSetValue [_index, _month];
};

private _currentTimeZone = [systemTime, systemTimeUTC] call FUNC(getTimeZoneIdentifier);
{
    _x params ["_text", "_timeZone"];

    private _index = _timeZoneCtrl lbAdd _x;
    _timeZoneCtrl lbSetValue [_index, _timeZone];
    _timeZoneCtrl lbSetTextRight [_index, _timeZone]

} forEach [
    [LLSTRING(ui_dtg_localTime), "J"],
    [LLSTRING(ui_dtg_systemTime), _currentTimeZone],
    [LLSTRING(ui_dtg_systemUTCTime), "Z"]
];

_dateMonthCtrl ctrlAddEventHandler ["LBSelChanged", LINKFUNC(onDTGMonthSelChanged)];

private _min = 0;
private _max = 86400; // seconds in a day
private _range = _max - _min;
private _currentValue = 0;

_timeSliderCtrl sliderSetRange [_min, _max];
_timeSliderCtrl sliderSetPosition _currentValue;
_timeSliderCtrl sliderSetSpeed [0.05 * _range, 0.1 * _range];
_timeSliderCtrl ctrlAddEventHandler ["SliderPosChanged", LINKFUNC(onDTGTimeSliderPosChanged)];

{
    _x params ["_idc", "_value"];

    private _ctrl = _dtgDisplay displayCtrl _idc;
    _ctrl ctrlSetText ([_value, 2] call CBA_fnc_formatNumber);
    _ctrl ctrlAddEventHandler ["KillFocus", LINKFUNC(onDTGTimeEditKillFocus)];
} forEach [
    [DTG_HOURS_EDIT, floor (_currentValue / 3600)],
    [DTG_MINUTES_EDIT, floor (_currentValue / 60 % 60)]
];

// Set local Arma time as default
[date] call FUNC(setUIDateTime);
