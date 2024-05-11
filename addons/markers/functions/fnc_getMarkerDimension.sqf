#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Returns the dimension the marker belongs to.
 *
 *  Parameter(s):
 *      0: STRING - Marker prefix.
 *
 *  Returns:
 *      STRING - Dimension identifier Emtpy string if marker with given name prefix does not exist.
 *
 *  Example:
 *      _dimension = ["mtsmarker#123/0/1"] call mts_markers_fnc_getMarkerDimension
 *
 */

params [["_namePrefix", "", [""]]];

CHECKRET(_namePrefix isEqualTo "",ERROR("No marker prefix"));

(GVAR(namespace) getVariable [_namePrefix, []]) param [3, ""]
