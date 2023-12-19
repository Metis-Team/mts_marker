#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Returns the NATO time zone identifier for the given time.
 *
 *  Parameter(s):
 *      0: ARRAY - Hours and minutes (e.g. from systemTime).
 *      1: ARRAY - UTC hours and minutes (e.g. from systemTimeUTC).
 *
 *  Returns:
 *      STRING - NATO time zone identifier or empty string if invalid.
 *
 *  Example:
 *      [[21, 47], [20, 47]] call mts_markers_fnc_getTimeZoneIdentifier // returns A
 *
 */

params [["_time", [], [[]]], ["_timeUtc", [], [[]]]];

private _timeZone = [_time, _timeUtc] call FUNC(getTimeZone); // _timeDiffH hour is in range -12..+12
CHECKRET(_timeZone isEqualTo [], "");

// Simplify time zones according to ATP 6-02.70 Appendix E
// Do not consider the minutes
_timeZone params ["_diffHours"];

// Clamp hours betweem -12...+12
_diffHours = -12 max (_diffHours min 12);

GVAR(standardTimeZones) getOrDefault [_diffHours, ""]
