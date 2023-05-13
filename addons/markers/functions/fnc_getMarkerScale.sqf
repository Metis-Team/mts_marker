#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Returns marker scale. (Same as vanilla getMarkerSize)
 *
 *  Parameter(s):
 *      0: STRING - Marker prefix.
 *
 *  Returns:
 *      NUMBER - Marker size
 *
 *  Example:
 *      ["mtsmarker#123/0/1"] call mts_markers_fnc_getMarkerSize
 *
 */

params [["_namePrefix", "", [""]]];

CHECKRET(_namePrefix isEqualTo "", ERROR("No marker prefix"));

(GVAR(namespace) getVariable _namePrefix) param [3]
