#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Sets the current system time in the Date-Time Group configuration dialog.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      call mts_markers_fnc_setDTGUIToSystemTime
 *
 */

private _now = systemTime;
private _nowUTC = systemTimeUTC;

private _timeZone = [_now, _nowUTC] call FUNC(getTimeZoneIdentifier);

[_now, _timeZone] call FUNC(setDTGUIData);
