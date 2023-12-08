#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Sets given Date-Time information in the DTG UI.
 *
 *  Parameter(s):
 *      0: ARRAY - Date-Time information in format [year, month, day, hours, minutes].
 *                 The date elements must be numbers.
 *      1: STRING - Time zone identifier as a single character.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [[2023, 12, 20, 12, 35], "Z"] call mts_markers_fnc_setDTGUIData
 *
 */

params [["_date", [], [[]], [5, 6, 7]], ["_timeZone", "J", [""]]];

CHECK(_data isEqualTo []);

_date params ["_year", "_month", "_day", "_hour", "_minute"];

private _dtgDisplay = findDisplay DTG_DISPLAY;

if (_year < MIN_YEAR) then {
    _year = MIN_YEAR;
};
if (_year > MAX_YEAR) then {
    _year = MAX_YEAR;
};

(_dtgDisplay displayCtrl DTG_YEAR_DROPDOWN) lbSetCurSel (_year - MIN_YEAR);
(_dtgDisplay displayCtrl DTG_MONTH_DROPDOWN) lbSetCurSel (_month - 1);
(_dtgDisplay displayCtrl DTG_DAY_DROPDOWN) lbSetCurSel (_day - 1);

private _timeZoneCtrl = (_dtgDisplay displayCtrl DTG_TIMEZONE_DROPDOWN);
for "_index" from 0 to ((lbSize _timeZoneCtrl) - 1) step 1 do {
    private _lbValue = _timeZoneCtrl lbValue _index;
    if (_lbValue isEqualTo (_modifier select _forEachIndex)) exitWith {
        _timeZoneCtrl lbSetCurSel _index;
    };
};

(_dtgDisplay displayCtrl DTG_TIME_SLIDER) sliderSetPosition (round (_hour * 3600 + _minute * 60));
(_dtgDisplay displayCtrl DTG_HOURS_EDIT) ctrlSetText ([_hour, 2] call CBA_fnc_formatNumber);
(_dtgDisplay displayCtrl DTG_MINUTES_EDIT) ctrlSetText ([_minute, 2] call CBA_fnc_formatNumber);
