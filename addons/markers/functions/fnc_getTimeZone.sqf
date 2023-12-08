#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Returns the standard time zone for the given time.
 *
 *  Parameter(s):
 *      0: ARRAY - Hours and minutes (e.g. from systemTime).
 *      1: ARRAY - UTC hours and minutes (e.g. from systemTimeUTC).
 *
 *  Returns:
 *      ARRAY - Standard time zone in the format [diffHours, diffMinutes].
 *              diffHours is in range -12 ... +12.
 *              E.g. [-9, 30] => UTC-09:30; [1, 0] => UTC+01:00
 *
 *  Example:
 *      [[21, 47], [20, 47]] call mts_markers_fnc_getTimeZone // returns [1, 0]
 *
 */

params [["_time", [], [[]]], ["_timeUtc", [], [[]]]];

CHECK((_time isEqualTo []) || (_timeUtc isEqualTo []));

// time is passed from systemTime command
if ((count _time) isEqualTo 7) then {
    _time = [_time select 3, _time select 4];
};

// time is passed from systemTimeUTC command
if ((count _timeUtc) isEqualTo 7) then {
    _timeUtc = [_timeUtc select 3, _timeUtc select 4];
};

_time params ["_hours", "_minutes"];
_timeUtc params ["_hoursUtc", "_minutesUtc"];

private _diffHours = _hours - _hoursUtc;
private _diffMinutes = _minutes - _minutesUtc;

if (_diffMinutes < 0) then {
    _diffHours = _diffHours - 1;
    _diffMinutes = _diffMinutes + 60;
};
if (_diffHours < -12) then {
    _diffHours = _diffHours + 24;
};
if (_diffHours > 12) then {
    _diffHours = _diffHours - 24;
};

[_diffHours, _diffMinutes]
