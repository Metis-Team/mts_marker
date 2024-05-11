#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Returns the dimension specfic configuration of the marker.
 *
 *  Parameter(s):
 *      0: STRING - Marker prefix.
 *
 *  Returns:
 *      ARRAY - The dimension specific marker configuration. Emtpy array if marker with given name prefix does not exist.
 *
 *  Example:
 *      _markerParameter = ["mtsmarker#123/0/1"] call mts_markers_fnc_getMarkerConfig
 *
 */

params [["_namePrefix", "", [""]]];

CHECKRET(_namePrefix isEqualTo "",ERROR("No marker prefix"));

(GVAR(namespace) getVariable [_namePrefix, []]) param [1, []]
