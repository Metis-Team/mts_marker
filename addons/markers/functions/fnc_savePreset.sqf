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
private _presetsList = _mainDisplay displayctrl PRESETS_LIST;

private _markerName = ctrlText (_mainDisplay displayctrl NAME_PRESETS_EDIT);
CHECKRET(_markerName isEqualTo "", hint LLSTRING(ui_hint_marker_name_empty));

private _UIData = call FUNC(getUIData);

private _index = _presetsList lbAdd _markerName;
_presetsList lbSetData [_index, str _UIData];

_UIData params ["_frameshape"];

_presetsList lbSetPicture [_index, format [QPATHTOF(data\ui\mts_markers_ui_%1_frameshape.paa), _frameshape select 0]];

private _presets = profileNamespace getVariable [QGVAR(presets), []];
_presets pushBack [_markerName, _UIData];
profileNamespace setVariable [QGVAR(presets), _presets];
saveProfileNamespace;

//update the Presets list
call FUNC(storePresetsToList);
