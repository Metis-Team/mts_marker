#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Function called when briefing display is opened.
 *
 *  Parameter(s):
 *      0: DISPLAY - Briefing display.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      _this call mts_markers_fnc_onBriefingDisplayOpened
 *
 */

params ["_display"];

if ((ctrlIDD _display) in [MAP_BRIEFING_CLIENT_DISPLAY, MAP_BRIEFING_SERVER_DISPLAY]) then {
    _display call (uiNamespace getVariable 'cba_events_fnc_initDisplayCurator');
};
