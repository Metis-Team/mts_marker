#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Returns active and a valid map display.
 *
 *  Parameter(s):
 *      None
 *
 *  Returns:
 *      DISPLAY - Active map display. If no map display is active, it will return displayNull.
 *
 *  Example:
 *      _display = call mts_markers_fnc_getDisplay
 *
 */

private ["_curMapDisplay"];

call {
    if (visibleMap && {!isNull (findDisplay MAP_PLAYER_DISPLAY)}) exitWith {
        _curMapDisplay = findDisplay MAP_PLAYER_DISPLAY;
    };
    if (getClientStateNumber in [9,10] && {(!isNull (findDisplay MAP_BRIEFING_CLIENT_DISPLAY)) || (!isNull (findDisplay MAP_BRIEFING_SERVER_DISPLAY))}) exitWith {
        _curMapDisplay = ([(findDisplay MAP_BRIEFING_CLIENT_DISPLAY), (findDisplay MAP_BRIEFING_SERVER_DISPLAY)] select {!isNull _x}) select 0;
    };
    if (is3DEN && {!isNull (findDisplay MAP_3DEN_DISPLAY)}) exitWith {
        _curMapDisplay = findDisplay MAP_3DEN_DISPLAY;
    };
    _curMapDisplay = displayNull;
};

_curMapDisplay
