#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Updates the Presets list after every key event of the searchbar or when called.
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

//get the search filter
private _search = toLower (ctrlText (_mainDisplay displayctrl SEARCH_PRESETS_EDIT));

//get all saved presets
private _presets = profileNamespace getVariable [QGVAR(presets), []];

//clear the list
lbClear _presetsList;

{
    _x params ["_presetName", "_namespaceIndex", "_UIData", "_picture"];

    //only add Presets to the list which are being searched
    if !(((toLower _presetName) find _search) isEqualTo -1) then {
        private _index = _presetsList lbAdd _presetName;
        _presetsList lbSetValue [_index, _namespaceIndex];
        _presetsList lbSetData [_index, str _UIData];
        _presetsList lbSetPicture [_index, _picture];
    };
} count _presets;

//deselect all Presets
_presetsList lbSetCurSel -1;
