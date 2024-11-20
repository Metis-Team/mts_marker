#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Places marker set/family on map.
 *      Adds the marker set/family to the mts_markers_namespace.
 *      This function has a local effect.
 *
 *  Parameter(s):
 *      0: STRING - Unique marker prefix. Format: mtsmarker#<Random Number>/<Player UID>/<Channel ID>
 *      1: NUMBER - Channel ID where marker is broadcasted. (Check "currentChannel" command for channel ID)
 *      2: ARRAY - Position where the marker will be placed.
 *      3: STRING - Marker dimension identifier.
 *      4: ARRAY - The dimension specific marker configuration.
 *      5: NUMBER - Scale of the marker. (Optional, default: 1.3)
 *      6: NUMBER - Alpha of the marker. (Optional, default: 1)
 *
 *  Returns:
 *     STRING - Marker prefix.
 *
 *  Example:
 *      _namePrefix = ["mtsmarker#123/0/1", 1, [2000,1000], "land_unit", [["blu", false, false], [4,0,0], [4, false, true], ["3","3"], "9", ["4"]]] call mts_markers_fnc_createMarkerLocal
 *
 */

// Backwards compability
if (_this isEqualTypeParams ["", 0, [], []]) then {
    // Old parameter format without dimension
    _this insert [3, [DEFAULT_DIMENSION]];
};

params [
    ["_namePrefix", "", [""]],
    ["_broadcastChannel", -1, [0]],
    ["_pos", [0,0], [[]], [2,3]],
    ["_dimension", "", [""]],
    ["_markerParameter", [], [[]]],
    ["_scale", MARKER_SCALE, [0]],
    ["_alpha", MARKER_ALPHA, [0]]
];

CHECK(!hasInterface);
CHECKRET(_namePrefix isEqualTo "",ERROR("No marker prefix."));
CHECKRET(!(_dimension in GVAR(dimensions)),ERROR_1("Dimension %1 is not available.",_dimension));

//prevent unscaled markers
if (_scale <= 0) then {
    WARNING("Negative scale for markers aren't allowed. Reset marker scale back to default.");
    _scale = MARKER_SCALE;
};

if (_alpha < 0 || _alpha > 1) then {
    WARNING("Alpha value for marker out of bounds (0-1). Reset marker alpha back to default.");
    _alpha = MARKER_ALPHA;
};

private _fnc_createMarker = (GVAR(dimensions) get _dimension) get "createMarker";
private _markerFamily = [_namePrefix, _pos, _markerParameter, _scale, _alpha] call _fnc_createMarker;

GVAR(localMarkers) set [_namePrefix, CBA_missionTime, true];

private _markerInformation = GVAR(namespace) getVariable [_namePrefix, []];
if (_markerInformation isEqualTo []) then { // Save in mts_markers_namespace
    // Save immutable variables of marker
    GVAR(namespace) setVariable [_namePrefix, [_markerFamily, _markerParameter, _broadcastChannel, _dimension], true];

    if (is3DEN) then {
        // Save 3DEN marker data in a hidden attribute
        private _3denData = "Scenario" get3DENMissionAttribute QGVAR(3denData);
        _3denData pushBackUnique _this;
        set3DENMissionAttributes [["Scenario", QGVAR(3denData), _3denData]];
    };
};

_namePrefix
