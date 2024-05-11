#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Validates the Land Unit marker parameter/config after the user pressed confirm and before the marker is created.
 *      This function is dimension specific and implements the "uiValidateData" hook.
 *
 *  Parameter(s):
 *      0: ARRAY - Dimension specific marker parameter.
 *
 *  Returns:
 *      BOOLEAN - Marker parameter are valid.
 *
 *  Example:
 *      _parameterAreValid = [_markerParameter] call mts_markers_fnc_validateUIData
 *
 */

params [["_markerParameter", [], [[]]]];

CHECKRET(_markerParameter isEqualTo [],false);

scopeName "main";
private _uniqueDesignation = _markerParameter param [3, []];
{
    if !(_x in GVAR(validCharacters)) then {
        //only allow valid characters that are in the array
        if (is3DEN) then {
            [LLSTRING(ui_hint_character_invalid), 1, 5, true] call BIS_fnc_3DENNotification;
        } else {
            hint LLSTRING(ui_hint_character_invalid);
        };
        false breakOut "main";
    };
} count _uniqueDesignation;

private _higherFormation = _markerParameter param [5, []];
{
    if !(_x in GVAR(validCharacters)) then {
        //only allow valid characters that are in the array
        if (is3DEN) then {
            [LLSTRING(ui_hint_character_invalid), 1, 5, true] call BIS_fnc_3DENNotification;
        } else {
            hint LLSTRING(ui_hint_character_invalid);
        };
        false breakOut "main";
    };
} count _higherFormation;

true
