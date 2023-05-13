#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Returns marker position.
 *
 *  Parameter(s):
 *      0: STRING - Marker prefix.
 *      1: BOOLEAN - Preserve elevation. (Optional, default: false)
 *
 *  Returns:
 *      ARRAY - format PositionAGL if preserve elevation is true or [x,y,0] if preserve elevation is false
 *
 *  Example:
 *      ["mtsmarker#123/0/1"] call mts_markers_fnc_getMarkerPos
 *
 */

params [["_namePrefix", "", [""]], ["_preserveElevation", false, [false]]];

CHECKRET(_namePrefix isEqualTo "", ERROR("No marker prefix"));

getMarkerPos [format["%1_frame", _namePrefix], _preserveElevation];
