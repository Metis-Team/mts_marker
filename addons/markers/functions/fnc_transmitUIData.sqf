#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Gets the selected data from the UI and transfers it to fnc_createMarker.sqf.
 *      Or if boolean is false then it transfers the data to fnc_setMarkerPreview.sqf.
 *
 *  Parameter(s):
 *      0: BOOLEAN - Is for marker creation or for preview (true for creation).
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [true] call mts_markers_fnc_transmitUIData
 *
 */

params [["_isForMarkerCreation", true, [true]]];

private _mainDisplay = findDisplay MAIN_DISPLAY;

//get all data
private _markerParameter = [] call FUNC(getUIData);

//chose where the data will be transmited
scopeName "main";
if (_isForMarkerCreation) then {
    private _uniqueDesignation = _markerParameter param [3, []];
    {
        if !(_x in GVAR(validCharacters)) then {
            //only allow valid characters that are in the array
            if (is3DEN) then {
                [LLSTRING(ui_hint_character_invalid), 1, 5, true] call BIS_fnc_3DENNotification;
            } else {
                hint LLSTRING(ui_hint_character_invalid);
            };
            breakOut "main";
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
            breakOut "main";
        };
    } count _higherFormation;

    private _okBtnCtrl = _mainDisplay displayctrl OK_BUTTON;
    private _pos = _okBtnCtrl getVariable [QGVAR(createMarkerMousePosition), [0,0]];

    private _broadcastChannel = call {
        if (is3DEN) exitWith {
            0
        };
        if !(isMultiplayer) exitWith {
            -1
        };
        private _channelCtrl = _mainDisplay displayCtrl CHANNEL_DROPDOWN;
        _channelCtrl lbValue (lbCurSel _channelCtrl)
    };
    setCurrentChannel _broadcastChannel;

    //check if marker is being editing, if so delete old marker and create new one
    private _editMarkerNamePrefix = _okBtnCtrl getVariable [QGVAR(editMarkerNamePrefix), ""];
    if (_editMarkerNamePrefix isNotEqualTo "") then {
        [_editMarkerNamePrefix] call FUNC(deleteMarker);
    };

    if (GVAR(saveLastSelection)) then {
        // Only save frameshape, modifier and size
        GVAR(lastSelection) = _markerParameter select [0, 3];
    };
    [_pos, _broadcastChannel, !is3DEN, _markerParameter, MARKER_SCALE] call FUNC(createMarker);
    _mainDisplay closeDisplay 1;
} else {
    _markerParameter call FUNC(setMarkerPreview);
};
