#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Saves a marker preset to the profile & adds it to the list.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      call mts_markers_fnc_savePreset
 *
 */

private _mainDisplay = findDisplay MAIN_DISPLAY;

//get the name of the Preset
private _presetName = ctrlText (_mainDisplay displayCtrl NAME_PRESETS_EDIT);
CHECKRET(_presetName isEqualTo "", hint LLSTRING(ui_hint_marker_name_empty));

//get all marker data for the Preset
private _UIData = call FUNC(getUIData);

//choose the picture according to the identity of the marker
private _identity = (_UIData param [0, []]) param [0, ""];
CHECK(_identity isEqualTo "");
private _picture = format [QPATHTOF(data\ui\mts_markers_ui_%1_frameshape.paa), _identity];

//save name, index, marker data and picture of the Preset to the profile
private _presets = profileNamespace getVariable [QGVAR(presets), []];
private _presetIndex = count _presets;
_presets pushBack [_presetName, _presetIndex, _UIData, _picture];
profileNamespace setVariable [QGVAR(presets), _presets];
saveProfileNamespace;

//update the Presets list
call FUNC(updatePresetsList);
