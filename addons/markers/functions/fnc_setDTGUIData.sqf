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
 *      2: BOOLEAN - Display in short format (Default is that format is not changed from selected one).
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [[2023, 12, 20, 12, 35], "Z"] call mts_markers_fnc_setDTGUIData
 *
 */

params [["_date", [], [[]], [5, 6, 7]], ["_timeZone", "J", [""]], ["_displayShort", nil, [false]]];
TRACE_1("params",_this);

CHECK(_date isEqualTo []);

_date params ["_year", "_month", "_day", "_hour", "_minute"];

private _dtgDisplay = findDisplay DTG_DISPLAY;

_year = MIN_YEAR max (_year min MAX_YEAR);

(_dtgDisplay displayCtrl DTG_YEAR_DROPDOWN) lbSetCurSel (_year - MIN_YEAR);
(_dtgDisplay displayCtrl DTG_MONTH_DROPDOWN) lbSetCurSel (_month - 1);
(_dtgDisplay displayCtrl DTG_DAY_DROPDOWN) lbSetCurSel (_day - 1);

private _timeZoneCtrl = (_dtgDisplay displayCtrl DTG_TIMEZONE_DROPDOWN);
private _timeZoneId = GVAR(alphanumCharacters) findIf {_x isEqualTo _timeZone};
for "_index" from 0 to ((lbSize _timeZoneCtrl) - 1) step 1 do {
    private _lbValue = _timeZoneCtrl lbValue _index;
    if (_lbValue isEqualTo _timeZoneId) exitWith {
        _timeZoneCtrl lbSetCurSel _index;
    };
};

(_dtgDisplay displayCtrl DTG_TIME_SLIDER) sliderSetPosition (round (_hour * 3600 + _minute * 60));
(_dtgDisplay displayCtrl DTG_HOURS_EDIT) ctrlSetText ([_hour, 2] call CBA_fnc_formatNumber);
(_dtgDisplay displayCtrl DTG_MINUTES_EDIT) ctrlSetText ([_minute, 2] call CBA_fnc_formatNumber);

if (!isNil "_displayShort") then {
    (_dtgDisplay displayCtrl DTG_SHORT_FORMAT_CHECKBOX) cbSetChecked _displayShort;
};
