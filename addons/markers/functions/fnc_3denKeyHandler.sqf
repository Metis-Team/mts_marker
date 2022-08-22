#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Handles executing 3DEN keybinds via the CBA keybinding system.
 *      Customizable keybindings are defined normally with the CBA keybinding system and than handles over this handler.
 *
 *  Parameter(s):
 *      0: STRING - The CBA action name defined for the keybind.
 *      1: BOOLEAN - A value indicating whether this keyhandler should execute the down code (TRUE) or up code (FALSE).
 *      2: ARRAY - The key down/up arguments of the eventhandler.
 *
 *  Returns:
 *      BOOLEAN - A value indicating whether the input should be blocked (TRUE) or not (FALSE).
 *
 *  Example:
 *      ["mts_markers_3den_delete_marker", false, _this] call mts_markers_fnc_3denKeyHandler
 *
 */

params ["_cbaActionName", "_isDownHandler", "_keyEHArgs"];
_keyEHArgs params ["_display", "_inputKey", "_ehInputShift", "_ehInputCtrl", "_ehInputAlt"];

CHECK(_inputKey isEqualTo 0);

private _blockInput = false;
private _inputShift = _ehInputShift;
private _inputCtrl = _ehInputCtrl;
private _inputAlt = _ehInputAlt;

switch (true) do {
    case (_inputKey in [42, 54]): { // DIK_LSHIFT, DIK_RSHIFT
        _inputShift = true;
    };
    case (_inputKey in [29, 157]): { // DIK_LCONTROL, DIK_RCONTROL
        _inputCtrl = true;
    };
    case (_inputKey in [56, 184]): { // DIK_LMENU, DIK_RMENU
        _inputAlt = true;
    };
};

private _inputModifiers = [_inputShift, _inputCtrl, _inputAlt];

private _keybindInfo = [LLSTRING(cba_category_name), _cbaActionName] call CBA_fnc_getKeybind;

private _code = if (_isDownHandler) then {
    _keybindInfo param [3, {}]
} else {
    _keybindInfo param [4, {}]
};

private _keybinds = _keybindInfo param [8, []];

{
    _x params ["_key", "_keybindModifier"];

    if (_inputKey isEqualTo _key && _inputModifiers isEqualTo _keybindModifier) exitWith {
        if (_isDownHandler) then {
            [] call _code;
        } else {
            _blockInput = ([nil] apply {[] call _code} param [0, false] isEqualTo true) || {_blockInput};
        };
    };
} forEach _keybinds; // All registered keybinds

_blockInput
