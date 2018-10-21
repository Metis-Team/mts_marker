#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Stores all Presets to the list control.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      call mts_markers_fnc_storePresetsToList
 *
 */

private _presetsList = (findDisplay MAIN_DISPLAY) displayCtrl PRESETS_LIST;

private _presets = [];
for "_i" from 0 to (lbSize _presetsList - 1) do {
    private _name = _presetsList lbText _i;
    private _data = _presetsList lbData _i;
    private _picture = _presetsList lbPicture _i;

    _presets pushBack [_name, _data, _picture];
};

_presetsList setVariable [QGVAR(presetsList), _presets];

call FUNC(updatePresetsList);
