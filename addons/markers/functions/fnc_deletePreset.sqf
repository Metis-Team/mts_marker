#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Deletes the Preset from the profile & list.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      call mts_markers_fnc_deletePreset
 *
 */

private _presetsList = (findDisplay MAIN_DISPLAY) displayCtrl PRESETS_LIST;
private _index = lbCurSel _presetsList;
CHECK(_index < 0);

_presetsList lbDelete _index;

private _presets = profileNamespace getVariable [QGVAR(presets), []];
_presets deleteAt _index;
profileNamespace setVariable [QGVAR(presets), _presets];
saveProfileNamespace;

//update the Presets list
call FUNC(storePresetsToList);
