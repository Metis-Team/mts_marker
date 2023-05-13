#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Returns all editable and non-editable Metis marker on the map.
 *
 *  Parameter(s):
 *      0: BOOLEAN - Include non-editable markers. (Optional, default: true)
 *
 *  Returns:
 *      ARRAY - Marker prefixes.
 *
 *  Example:
 *      [false] call mts_markers_fnc_getAllMarkers
 *
 */

params [["_nonEditable", true, [true]]];

private _allMarkers = allVariables GVAR(namespace);

if !(_nonEditable) then {
    _allMarkers = _allMarkers select {[_x] call FUNC(isMtsMarker) isEqualTo 1};
};

_allMarkers
