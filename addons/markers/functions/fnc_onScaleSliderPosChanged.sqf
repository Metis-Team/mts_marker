#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Displays current scale slider pos in text.
 *
 *  Parameter(s):
 *      0: CONTROL - Slider.
 *      1: NUMBER - Slider position (optional).
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_this, 1] call mts_markers_fnc_onScaleSliderPosChanged
 *
 */

params ["_ctrl", ["_scale", MARKER_SCALE, [0]]];

// Round to 2 decimals
_scale = _scale * 100;
_scale = round _scale;
_scale = _scale / 100;

((ctrlParent _ctrl) displayCtrl SCALE_TXT) ctrlSetText format [LLSTRING(ui_general_scaleTXT), _scale];
