#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Fills the marker name corresponding to the selected Preset.
 *      Function is triggered by an EH.
 *
 *  Parameter(s):
 *      0: CONTROL - Presets listbox
 *      1: NUMBER - Index of the currently selected Preset.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [(findDisplay 5000) displayCtrl 1000, 1] call mts_markers_fnc_onPresetsLBSelChanged
 *
 */

params ["_presetsList", "_selectedIndex"];

private _mainDisplay = ctrlParent _presetsList;

private _markername = _presetsList lbText _selectedIndex;

(_mainDisplay displayctrl NAME_PRESETS_EDIT) ctrlSetText _markername;
