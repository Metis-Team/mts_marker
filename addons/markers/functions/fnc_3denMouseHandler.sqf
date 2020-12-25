#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Handles executing 3DEN mouse button keybinds via the CBA keybinding system.
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
 *      ["mts_markers_3den_delete_marker", false, _this] call mts_markers_fnc_3denMouseHandler
 *
 */

params ["_cbaActionName", "_isDownHandler", "_buttonEHArgs"];
_buttonEHArgs params ["_display", "_inputButton", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

[_cbaActionName, _isDownHandler, [_display, MOUSE_OFFSET + _inputButton, _shift, _ctrl, _alt]] call FUNC(3denKeyHandler);
