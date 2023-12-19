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
private _displayCheck = _curMapDisplay createDisplay QGVAR(Dialog);
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
    if (_ctrl isNotEqualTo _echelonCtrl) then {
        lbSort _ctrl;
    };
    _ctrl lbSetCurSel 0;
} forEach _ctrlArray;

// Direction of Movement
private _directionCtrl = _mainDisplay displayCtrl DIRECTION_DROPDOWN;
private _directionIndex = _directionCtrl lbAdd LLSTRING(ui_direction_empty);
_directionCtrl lbSetPicture [_directionIndex, "#(argb,8,8,3)color(0,0,0,0)"];

{
    _x params ["_dir", "_dirShort"];

    private _index = _directionCtrl lbAdd (localize _dir);
    private _picturePath = format [QPATHTOF(data\ui\dir\mts_markers_ui_dir_%1.paa), GVAR(directions) select _forEachIndex];
    _directionCtrl lbSetPicture [_index, _picturePath];

    // Set transparent picture to the right this will be the padding right for the text right
    _directionCtrl lbSetPictureRight [_index, "#(argb,8,8,3)color(0,0,0,0)"];
    _directionCtrl lbSetTextRight [_index, localize _dirShort];
} forEach GVAR(directionLocalization);
_directionCtrl lbSetCurSel 0;

// Channel
private _channelCtrl = _mainDisplay displayCtrl CHANNEL_DROPDOWN;
if (!isMultiplayer || is3DEN) then {
    //hide channel dropdown in singleplayer and 3DEN editor
    _channelCtrl ctrlShow false;
    (_mainDisplay displayCtrl CHANNEL_TXT) ctrlShow false;
} else {
    //fill the channel combobox & select current channel
    _channelCtrl ctrlShow true;
    (_mainDisplay displayCtrl CHANNEL_TXT) ctrlShow true;

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

private _suspectedCbCtrl = _mainDisplay displayCtrl SUSPECT_CHECKBOX;
private _reinforcedCbCtrl = _mainDisplay displayCtrl REINFORCED_CHECKBOX;
private _reducedCbCtrl = _mainDisplay displayCtrl REDUCED_CHECKBOX;
private _hqCbCtrl = _mainDisplay displayCtrl HQ_CHECKBOX;

private _markerScale = MARKER_SCALE;
private _markerAlpha = MARKER_ALPHA;

// Operational Condition
private _damagedCbCtrl = _mainDisplay displayCtrl DAMAGED_CHECKBOX;
private _destroyedCbCtrl = _mainDisplay displayCtrl DESTROYED_CHECKBOX;

private _setPosAndPrefix = {
    params [
        ["_mainDisplay", displayNull, [displayNull]],
        ["_namePrefix", "", [""]],
        ["_mapCtrl", controlNull, [controlNull]],
        ["_mousePos", [0,0], [[]], 2]
    ];
    private "_pos";

    if (_namePrefix isNotEqualTo "") then {
        _pos = getMarkerPos (format["%1_frame", _namePrefix]);
    };
    if !(isNull _mapCtrl) then {
        _pos = _mapCtrl ctrlMapScreenToWorld _mousePos;
    };

    CHECK(isNil "_pos" || isNull _mainDisplay);
    private _okBtnCtrl = _mainDisplay displayCtrl OK_BUTTON;
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
    private _broadcastChannel = -1;
    if (GVAR(saveLastSelection) && (_namePrefix isEqualTo "")) then {
        if (GVAR(lastSelection) isEqualTo []) then {
            _markerParameter set [0, ["blu", false]];
        } else {
            _markerParameter = GVAR(lastSelection);
        };

        if (isMultiplayer) then {
            private _selectedChannel = currentChannel;
            if (_selectedChannel > 5) then {_selectedChannel = 3;};
            _broadcastChannel = _selectedChannel;
        };

        [_mainDisplay, nil, _mapCtrl, _mousePos] call _setPosAndPrefix;
    } else {
        //get marker family parameter & information from namespace
        private _markerInformation = GVAR(namespace) getVariable [_namePrefix, [[]]];
        _markerParameter = _markerInformation param [1, [], [[]]];
        _broadcastChannel = _markerInformation param [2, -1, [0]];
        _markerScale = [_namePrefix] call FUNC(getMarkerScale);
        _markerAlpha = [_namePrefix] call FUNC(getMarkerAlpha);

        [_mainDisplay, _namePrefix] call _setPosAndPrefix;
    };
    CHECK(_markerParameter isEqualTo []);

    //select the original broadcast channel in dropdown
    for "_index" from 0 to ((lbSize _channelCtrl) -1) do {
        private _channelID = _channelCtrl lbValue _index;
        if (_channelID isEqualTo _broadcastChannel) exitWith {
            _channelCtrl lbSetCurSel _index;
        };
    };

    _markerParameter call FUNC(setUIData);
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
} forEach [
    _iconCtrl,
    _mod1Ctrl,
    _mod2Ctrl,
    _echelonCtrl,
    _directionCtrl];

{
    _x ctrlAddEventHandler ["CheckedChanged", {[false] call FUNC(transmitUIData);}];
} forEach [
    _suspectedCbCtrl,
    _reinforcedCbCtrl,
    _reducedCbCtrl,
    _hqCbCtrl,
    _damagedCbCtrl,
    _destroyedCbCtrl
];

//fill the Presets list with saved Presets from the profile
call FUNC(updatePresetsList);

//add EH for the Preset interaction
private _presetsList = _mainDisplay displayCtrl PRESETS_LIST;
_presetsList ctrlAddEventHandler ["LBSelChanged", LINKFUNC(onPresetsLBSelChanged)];
_presetsList ctrlAddEventHandler ["LBDblClick", LINKFUNC(loadPreset)];

//add EH for the searchbar
private _searchCtrl = _mainDisplay displayCtrl SEARCH_PRESETS_EDIT;
_searchCtrl ctrlAddEventHandler ["KeyDown", LINKFUNC(updatePresetsList)];
_searchCtrl ctrlAddEventHandler ["KeyUp", LINKFUNC(updatePresetsList)];

{
    _x ctrlAddEventHandler ["CheckedChanged", LINKFUNC(onOperationalConditionChanged)];
} forEach [
    _damagedCbCtrl,
    _destroyedCbCtrl
];

private _scaleSlider = _mainDisplay displayCtrl SCALE_SLIDER;
_scaleSlider sliderSetPosition _markerScale;
[_scaleSlider, _markerScale] call FUNC(onScaleSliderPosChanged);
_scaleSlider ctrlAddEventHandler ["SliderPosChanged", LINKFUNC(onScaleSliderPosChanged)];
_scaleSlider ctrlAddEventHandler ["MouseButtonUp", LINKFUNC(onScaleSliderMouseButtonUp)];

private _alphaSlider = _mainDisplay displayCtrl ALPHA_SLIDER;
_alphaSlider sliderSetPosition _markerAlpha;
[_alphaSlider, _markerAlpha] call FUNC(onAlphaSliderPosChanged);
_alphaSlider ctrlAddEventHandler ["SliderPosChanged", LINKFUNC(onAlphaSliderPosChanged)];
_alphaSlider ctrlAddEventHandler ["MouseButtonUp", LINKFUNC(onAlphaSliderMouseButtonUp)];
