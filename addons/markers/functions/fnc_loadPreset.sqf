#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Loads a preset from the list & fills the UI with data.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      call mts_markers_fnc_loadPreset
 *
 */

private _mainDisplay = findDisplay MAIN_DISPLAY;
private _presetsList = _mainDisplay displayCtrl PRESETS_LIST;
private _index = lbCurSel _presetsList;
CHECK(_index < 0);

(_mainDisplay displayCtrl NAME_PRESETS_EDIT) ctrlSetText (_presetsList lbText _index);

private _UIData = parseSimpleArray (_presetsList lbData _index);
CHECK(_UIData isEqualTo []);
_UIData call FUNC(setUIData);
