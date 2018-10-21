#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Updates the Presets list after every key event of the searchbar.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      call mts_markers_fnc_updatePresetsList
 *
 */

private _mainDisplay = findDisplay MAIN_DISPLAY;
private _presetsList = _mainDisplay displayctrl PRESETS_LIST;

private _search = toLower (ctrlText (_mainDisplay displayctrl SEARCH_PRESETS_EDIT));
private _presets = _presetsList getVariable QGVAR(presetsList);

lbClear _presetsList;

{
    _x params ["_name", "_data", "_picture"];

    if !(((toLower _name) find _search) isEqualTo -1) then {
        private _index = _presetsList lbAdd _name;
        _presetsList lbSetData [_index, _data];
        _presetsList lbSetPicture [_index, _picture];
    };
} count _presets;

_presetsList lbSetCurSel -1;

nil
