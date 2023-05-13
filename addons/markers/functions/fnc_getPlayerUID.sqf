#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Returns PlayerUID from marker prefix.
 *
 *  Parameter(s):
 *      0: STRING - Marker prefix.
 *
 *  Returns:
 *      STRING - PlayerUID or "-1" if it isn't an editale Metis marker.
 *
 *  Example:
 *      ["mtsmarker#123/0/1"] call mts_markers_fnc_getPlayerUID
 *
 */

params [["_namePrefix", "", [""]]];

CHECKRET([_namePrefix] call FUNC(isMtsMarker) isNotEqualTo 1, QUOTE(-1));

((_namePrefix splitString "/") param [1])

