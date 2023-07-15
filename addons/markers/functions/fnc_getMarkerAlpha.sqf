#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Returns the alpha value of the given marker (similar to Arma's markerAlpha command).
 *
 *  Parameter(s):
 *      0: STRING - Marker prefix.
 *
 *  Returns:
 *      NUMBER - Alpha value from 0 (invisible) to 1 (fully visible).
 *
 *  Example:
 *      ["mtsmarker#123/0/1"] call mts_markers_fnc_getMarkerAlpha
 *
 */

params [["_namePrefix", "", [""]]];

CHECKRET(_namePrefix isEqualTo "", ERROR("No marker prefix"));

(markerAlpha format ["%1_frame", _namePrefix])
