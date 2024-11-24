#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Returns the marker set with the given marker prefix.
 *
 *  Parameter(s):
 *      0: STRING - Marker prefix.
 *
 *  Returns:
 *      ARRAY - Names of all markers in one set. If failed, empty array is returned.
 *
 *  Example:
 *      _markerFamily = ["mtsmarker#123/0/1"] call mts_markers_fnc_getMarkerFamily
 *
 */

params [["_namePrefix", "", [""]]];
CHECKRET(_namePrefix isEqualTo "",[]);

private _markerInformation = GVAR(namespace) getVariable [_namePrefix, [[]]];

(_markerInformation select 0)
