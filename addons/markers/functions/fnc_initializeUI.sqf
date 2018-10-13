#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Opens the interface.
 *      Initializes the UI.
 *      Adds Combobox selections and pictures.
 *
 *  Parameter(s):
 *      0: DISPLAY - Display on which the dialog should apear. (Check mts_markers_fnc_getDisplay)
 *      1: ARRAY - Mouse position on map. (Not needed if parameter 2 is given e.g. nil)
 *      2: STRING - Unique marker prefix for editing set marker. (Not needed if dialog should open with default settings)
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [findDisplay 12, [0.5,0.5]] call mts_markers_fnc_initializeUI
 *
 */

params [["_curMapDisplay", displayNull, [displayNull]], ["_mousePos", [0,0], [[]], 2], ["_namePrefix", "", [""]]];

//Open interface
private _displayCheck = _curMapDisplay createDisplay QGVAR(dialog);
CHECKRET(isNull _displayCheck, ERROR("Failed to create dialog"));

private _mainDisplay = findDisplay MAIN_DISPLAY;
private _mapCtrl = _curMapDisplay displayCtrl MAP_CTRL;
CHECK(isNull _mapCtrl);

if (!is3DEN) then {
    //change mouse cursor
    _mapCtrl ctrlMapCursor ["Track", "Arrow"];

    //when display is closed, reset the mouse cursor
    _mainDisplay displayAddEventHandler ["Unload", {
        params ["_mainDisplay"];
        ((displayParent _mainDisplay) displayCtrl MAP_CTRL) ctrlMapCursor ["Track", "Track"];
    }];
};

//combobox controls
private _iconCtrl = _mainDisplay displayCtrl ICON_DROPDOWN;
private _mod1Ctrl = _mainDisplay displayCtrl MOD1_DROPDOWN;
private _mod2Ctrl = _mainDisplay displayCtrl MOD2_DROPDOWN;
private _echelonCtrl = _mainDisplay displayCtrl ECHELON_DROPDOWN;

private _ctrlArray = [
    [_iconCtrl, GVAR(iconArray), "icon"],
    [_mod1Ctrl, GVAR(mod1Array), "mod1"],
    [_mod2Ctrl, GVAR(mod2Array), "mod2"],
    [_echelonCtrl, GVAR(echelonArray), "echelon"]
];

//fill the icon, mod1, mod2 and echelon comboboxes
{
    _x params ["_ctrl", "_dropdownArray", "_arrayPathPrefix"];

    {
        _x params ["_selectionTextSuffix"];

        private _selectionText = format [LSTRING(ui_%1_%2), _arrayPathPrefix, _selectionTextSuffix];
        private _index = _ctrl lbAdd (localize _selectionText);
        _ctrl lbSetValue [_index, _index];

        private _selectionPicturePath = format [QPATHTOF(data\ui\%1\mts_markers_ui_%1_%2.paa), _arrayPathPrefix, _selectionTextSuffix];
        _ctrl lbSetPicture [_index, _selectionPicturePath];
    } count _dropdownArray;

    //sort icon, mod1 and mod2 dropdowns alphabetically
    if !(_ctrl isEqualTo _echelonCtrl) then {
        lbSort _ctrl;
    };
    _ctrl lbSetCurSel 0;
} forEach _ctrlArray;

private _channelCtrl = _mainDisplay displayCtrl CHANNEL_DROPDOWN;
if (!isMultiplayer || is3DEN) then {
    //hide channel dropdown in singleplayer and 3DEN editor
    _channelCtrl ctrlShow false;
    (_mainDisplay displayctrl CHANNEL_TXT) ctrlShow false;
} else {
    //fill the channel combobox & select current channel
    _channelCtrl ctrlShow true;
    (_mainDisplay displayctrl CHANNEL_TXT) ctrlShow true;

    private _channelDropdownArray = [
        ["str_channel_global", 0, "colorGlobalChannel"],
        ["str_channel_side", 1, "colorSideChannel"],
        ["str_channel_command", 2, "colorCommandChannel"],
        ["str_channel_group", 3, "colorGroupChannel"],
        ["str_channel_vehicle", 4, "colorVehicleChannel"],
        ["str_channel_direct", 5, "colorDirectChannel"]
    ];

    {
        _x params ["_channelText", "_channelID", "_channelColor"];

        if (!((channelEnabled _channelID) isEqualTo [false, false]) || _channelID isEqualTo 3) then {
            private _selectionColor = (configfile >> "RscChatListMission" >> _channelColor) call BIS_fnc_colorConfigToRGBA;
            private _index = _channelCtrl lbAdd (localize _channelText);
            _channelCtrl lbSetValue [_index, _channelID];
            _channelCtrl lbSetColor [_index, _selectionColor];
        };
    } count _channelDropdownArray;
};

private _suspectedCbCtrl = _mainDisplay displayCtrl MOD_CHECKBOX;
private _reinforcedCbCtrl = _mainDisplay displayCtrl REINFORCED_CHECKBOX;
private _reducedCbCtrl = _mainDisplay displayCtrl REDUCED_CHECKBOX;

private _setPosAndPrefix = {
    params [
        ["_mainDisplay", displayNull, [displayNull]],
        ["_namePrefix", "", [""]],
        ["_mapCtrl", controlNull, [controlNull]],
        ["_mousePos", [0,0], [[]], 2]
    ];
    private "_pos";

    if !(_namePrefix isEqualTo "") then {
        _pos = getMarkerPos (format["%1_frame", _namePrefix]);
    };
    if !(isNull _mapCtrl) then {
        _pos = _mapCtrl ctrlMapScreenToWorld _mousePos;
    };

    CHECK(isNil "_pos" || isNull _mainDisplay);
    private _okBtnCtrl = _mainDisplay displayctrl OK_BUTTON;
    _okBtnCtrl setVariable [QGVAR(editMarkerNamePrefix), _namePrefix];
    _okBtnCtrl setVariable [QGVAR(createMarkerMousePosition), _pos];
};

if ((_namePrefix isEqualTo "") && !GVAR(saveLastSelection)) then {
    //select the current channel in the dropdown
    if (isMultiplayer) then {
        private _selectedChannel = currentChannel;
        if (_selectedChannel > 5) then {_selectedChannel = 3;};

        for "_index" from 0 to ((lbSize _channelCtrl) -1) do {
            private _channelID = _channelCtrl lbValue _index;
            if (_channelID isEqualTo _selectedChannel) exitWith {
                _channelCtrl lbSetCurSel _index;
            };
        };
    };

    //save future marker position
    [_mainDisplay, nil, _mapCtrl, _mousePos] call _setPosAndPrefix;

    //select blufor identity as default & update marker preview
    ["blu"] call FUNC(identityButtonsAction);
} else {
    //when editing marker or saving of last selection is enabled
    private _markerParameter = [];
    if (GVAR(saveLastSelection) && (_namePrefix isEqualTo "")) then {
        if (GVAR(lastSelection) isEqualTo []) then {
            _markerParameter set [0, ["blu", false]];
        } else {
            _markerParameter = GVAR(lastSelection);
        };

        if (isMultiplayer) then {
            private _selectedChannel = currentChannel;
            if (_selectedChannel > 5) then {_selectedChannel = 3;};
            _markerParameter set [5, _selectedChannel];
        };

        [_mainDisplay, nil, _mapCtrl, _mousePos] call _setPosAndPrefix;
    } else {
        //get marker family parameter & information from namespace
        private _markerInformation = GVAR(namespace) getVariable [_namePrefix, [[]]];
        _markerParameter = _markerInformation select 1;

        [_mainDisplay, _namePrefix] call _setPosAndPrefix;
    };
    CHECK(_markerParameter isEqualTo []);

    _markerParameter params [
        ["_frameshape", ["",false], [[]]],
        ["_modifier", [0,0,0], [[]], 3],
        ["_size", [0,false,false], [[]], 3],
        ["_textleft", [], [[]]],
        ["_textright", "", [""]],
        ["_broadcastChannel", -1, [0]]
    ];

    //because of the sorting, the index needs to be found with the help of the value
    {
        _x params ["_ctrl", "_dropdownArray"];

        CHECK(_ctrl isEqualTo _echelonCtrl);

        for "_index" from 0 to ((count _dropdownArray) -1) step 1 do {
            private _lbValue = _ctrl lbValue _index;
            if (_lbValue isEqualTo (_modifier select _forEachIndex)) exitWith {
                _ctrl lbSetCurSel _index;
            };
        };
    } forEach _ctrlArray;

    _echelonCtrl lbSetCurSel (_size select 0);
    _reinforcedCbCtrl cbSetChecked (_size select 1);
    _reducedCbCtrl cbSetChecked (_size select 2);

    (_mainDisplay displayCtrl HIGHER_EDIT) ctrlSetText _textright;
    (_mainDisplay displayCtrl UNIQUE_EDIT) ctrlSetText (_textleft joinString "");

    //select the original broadcast channel in dropdown
    for "_index" from 0 to ((lbSize _channelCtrl) -1) do {
        private _channelID = _channelCtrl lbValue _index;
        if (_channelID isEqualTo _broadcastChannel) exitWith {
            _channelCtrl lbSetCurSel _index;
        };
    };

    //select right identity in the dialog & update preview
    _suspectedCbCtrl cbSetChecked (_frameshape select 1);
    [(_frameshape select 0)] call FUNC(identityButtonsAction);
};

//call same ui events that CBA is adding to the map display. Thanks to commy2 for this work-around!
if ((ctrlIDD _curMapDisplay) isEqualTo MAP_PLAYER_DISPLAY) then {
    _mainDisplay call (uiNamespace getVariable "cba_events_fnc_initDisplayMainMap");
};
if ((ctrlIDD _curMapDisplay) in [MAP_BRIEFING_CLIENT_DISPLAY, MAP_BRIEFING_SERVER_DISPLAY]) then {
    _mainDisplay call (uiNamespace getVariable "cba_events_fnc_initDisplayCurator");
};

//add EH for marker preview updating
{
    _x ctrlAddEventHandler ["LBSelChanged", {[false] call FUNC(transmitUIData);}];
} forEach [_iconCtrl, _mod1Ctrl, _mod2Ctrl, _echelonCtrl];

{
    _x ctrlAddEventHandler ["CheckedChanged", {[false] call FUNC(transmitUIData);}];
} forEach [_suspectedCbCtrl, _reinforcedCbCtrl, _reducedCbCtrl];
