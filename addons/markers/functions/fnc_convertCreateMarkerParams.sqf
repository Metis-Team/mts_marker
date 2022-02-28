#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Converts legacy createMarker parameters to new format. (BWC since version 1.3.0)
 *
 *  Parameter(s):
 *      0: ARRAY - Old or new createMarker parameters format.
 *
 *  Returns:
 *      ARRAY - New createMarker format.
 *
 *  Example:
 *      [_this] call mts_markers_fnc_convertCreateMarkerParams
 *
 */

params ["_createMarkerParams"];

// Support old parameter format
private _params = if ((_createMarkerParams select 4) isEqualType 0) then { // Check if scale param is at index 4
    _createMarkerParams
} else {
    private _markerParameter = [_createMarkerParams select 3, _createMarkerParams select 4, _createMarkerParams select 5, _createMarkerParams select 6, _createMarkerParams select 7];
    [_createMarkerParams select 0, _createMarkerParams select 1, _createMarkerParams select 2, _markerParameter, _createMarkerParams select 8]
};

// Support old frameshape format
private _markerParameter = _params select 3;
private _frameshape = _markerParameter select 0;
if (_frameshape isEqualType "") then {
    private _dashedFrameshape = false;

    if ((count _frameshape) > 3) then {
        _frameshape = _frameshape select [0, 3];
        CHECK(_frameshape isEqualTo "neu");
        _dashedFrameshape = true;
    };

    _markerParameter set [0, [_frameshape, _dashedFrameshape]];
};

TRACE_2("Converted createMarker params", _params, _createMarkerParams);

_params
