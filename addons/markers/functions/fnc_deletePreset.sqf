#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Deletes the selected preset from the profile namespace & list.
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

//get the index of the Preset which was marked for deletion
private _deletePresetIndex = _presetsList lbValue _index;

private _presets = profileNamespace getVariable [QGVAR(presets), []];

//delete the Preset from the profile
_presets deleteAt _deletePresetIndex;

//order all Presets indexes correctly again, so that the namespaceIndex equals the index in the preset array
for "_namespaceIndex" from _deletePresetIndex to (count _presets - 1) do {
    (_presets select _namespaceIndex) set [1, _namespaceIndex];
};

//save all changes to the profile
profileNamespace setVariable [QGVAR(presets), _presets];
saveProfileNamespace;

//update the Presets list
call FUNC(updatePresetsList);
