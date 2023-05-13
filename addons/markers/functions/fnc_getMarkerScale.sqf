#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Returns the scale/size of the given marker (similar to Arma's getMarkerSize command).
 *
 *  Parameter(s):
 *      0: STRING - Marker prefix.
 *
 *  Returns:
 *      NUMBER - Marker size. If marker does not exists, it returns 0.
 *
 *  Example:
 *      ["mtsmarker#123/0/1"] call mts_markers_fnc_getMarkerScale
 *
 */

params [["_namePrefix", "", [""]]];

CHECKRET(_namePrefix isEqualTo "", ERROR("No marker prefix"));
(GVAR(namespace) getVariable [_namePrefix, []]) param [3, 0]
