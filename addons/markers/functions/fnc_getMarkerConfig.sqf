#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Returns marker config parameter.
 *
 *  Parameter(s):
 *      0: STRING - Marker prefix.
 *
 *  Returns:
 *      0: ARRAY - The marker configuration.
 *          0: ARRAY - Frameshape of the marker.
 *              0: STRING - Identity (blu, red, neu, unk).
 *              1: BOOLEAN - Dashed (e.g. supect).
 *          1: ARRAY - Composition of modifier for the marker. IDs are listed in the wiki.
 *              0: NUMBER - Icon (0 for none).
 *              1: NUMBER - Modifier 1 (0 for none).
 *              2: NUMBER - Modifier 2 (0 for none).
 *          2: ARRAY - Group size array.
 *              0: NUMBER - Group size (0 for none).
 *              1: BOOLEAN - Reinforced or (+) symbol.
 *              2: BOOLEAN - Reduced or (-) symbol (if both are true it will show (±)).
 *          3: ARRAY - Marker text left - Unique designation.
 *          4: STRING - Marker text right - Higher formation.
 *          5: ARRAY - Marker text right bottom - Higher formation.
 *  Example:
 *      ["mtsmarker#123/0/1"] call mts_markers_fnc_getMarkerConfig
 *
 */

params [["_namePrefix", "", [""]]];

CHECKRET(_namePrefix isEqualTo "", ERROR("No marker prefix"));

(GVAR(namespace) getVariable _namePrefix) param [1]
