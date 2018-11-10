#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Show the window for the presets.
 *
 *  Parameter(s):
 *      0: BOOLEAN - Show the window.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [true] call mts_markers_fnc_showPresetsUI
 *
 */

params [["_showPresets", true, [true]]];

private _mainDisplay = findDisplay MAIN_DISPLAY;
private _togglePresetsBtn = _mainDisplay displayCtrl TOGGLE_PRESETS_BUTTON;

if (_showPresets) then {
    _togglePresetsBtn ctrlSetText "<<";
} else {
    _togglePresetsBtn ctrlSetText ">>";
};

{
    (_mainDisplay displayCtrl _x) ctrlShow _showPresets;
} forEach [
    PRESETS_BG,
    PRESETS_HEAD_BG,
    PRESETS_LIST,
    SAVE_PRESETS_BUTTON,
    LOAD_PRESETS_BUTTON,
    SEARCH_PRESETS_BUTTON,
    SEARCH_PRESETS_EDIT,
    PRESETS_NAME_TXT,
    NAME_PRESETS_EDIT,
    CLEAR_PRESETS_BUTTON,
    DELETE_PRESETS_BG,
    DELETE_PRESETS_PIC,
    DELETE_PRESETS_BUTTON
];
