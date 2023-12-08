#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Handles alpha slider button event. Resets the slider back to default on RMB.
 *
 *  Parameter(s):
 *      0: CONTROL - Slider.
 *      1: NUMBER - Button released.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      _this call mts_markers_fnc_onAlphaSliderMouseButtonUp
 *
 */

params ["_ctrl", "_button"];

// Must be RMB
CHECK(_button isNotEqualTo 1);

_ctrl sliderSetPosition MARKER_ALPHA;
[_ctrl, MARKER_ALPHA] call FUNC(onAlphaSliderPosChanged);
