#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Constructs and returns the Date-Time Group charaters.
 *
 *  Parameter(s):
 *      0: ARRAY - Year, month, day, hours, minutes.
 *      1: STRING - Standard time zone identifier (one character).
 *
 *  Returns:
 *      ARRAY - Date-Time Group charaters in format [D, D, H, H, M, M, Z, mmm, Y, Y].
 *              To get the equivalent stirng, just join the element with joinString "".
 *              Returns empty array on invalid date.
 *
 *  Example:
 *      [[2023, 12, 7, 12, 35], "A"] call mts_markers_fnc_toDTGCharaters
 *
 */

params [["_date", [], [[]], [5, 6, 7]], ["_timeZone", "J", [""]]];
TRACE_2("params", _date, _timeZone);

CHECKRET((_date isEqualTo []) || (count _timeZone != 1), []);

_date params [["_year", MIN_YEAR, [0]], ["_month", 1, [0]], ["_day", 1, [0]], ["_hour", 0, [0]], ["_minute", 0, [0]]];

CHECKRET(_month < 1 || _month > 12, []);
CHECKRET(_day < 1 || _day > 31, []);
CHECKRET(_day < 1 || _day > 31, []);

private _yearStr = [_year, 4] call CBA_fnc_formatNumber;
private _monthAbbrivation = GVAR(monthAbbreviations) get _month;
private _dayStr = [_day, 2] call CBA_fnc_formatNumber;
private _hourStr = [_hour, 2] call CBA_fnc_formatNumber;
private _minuteStr = [_minute, 2] call CBA_fnc_formatNumber;

[
    _dayStr select [0, 1],
    _dayStr select [1, 1],
    _hourStr select [0, 1],
    _hourStr select [1, 1],
    _minuteStr select [0, 1],
    _minuteStr select [1, 1],
    toUpper _timeZone,
    toLower _monthAbbrivation,
    _yearStr select [2, 1],
    _yearStr select [3, 1]
]
