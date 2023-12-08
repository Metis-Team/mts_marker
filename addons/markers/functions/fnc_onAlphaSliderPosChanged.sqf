#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Displays current alpha slider pos in text.
 *
 *  Parameter(s):
 *      0: CONTROL - Slider.
 *      1: NUMBER - Slider position (optional).
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_this, 1] call mts_markers_fnc_onAlphaSliderPosChanged
 *
 */

params ["_ctrl", ["_alpha", MARKER_ALPHA, [0]]];

// Round to 2 decimals
_alpha = _alpha * 100;
_alpha = round _alpha;
_alpha = _alpha / 100;

((ctrlParent _ctrl) displayCtrl ALPHA_TXT) ctrlSetText format [LLSTRING(ui_general_alphaTXT), _alpha];
