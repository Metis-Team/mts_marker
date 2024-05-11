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

private _data = parseSimpleArray (_presetsList lbData _index);
CHECK(_data isEqualTo []);
_data params ["_dimension", "_markerParameter"];

private _cfgCtrlGrp = [_dimension] call FUNC(setDimension);
private _setUIData = (GVAR(dimensions) get _dimension) get "uiSetData";
[_cfgCtrlGrp, _markerParameter] call _setUIData;
