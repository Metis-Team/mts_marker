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
CHECKRET(isNull _displayCheck,ERROR("Failed to create dialog"));

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

//call same ui events that CBA is adding to the map display. Thanks to commy2 for this work-around!
if ((ctrlIDD _curMapDisplay) isEqualTo MAP_PLAYER_DISPLAY) then {
    _mainDisplay call (uiNamespace getVariable "cba_events_fnc_initDisplayMainMap");
};
if ((ctrlIDD _curMapDisplay) in [MAP_BRIEFING_CLIENT_DISPLAY, MAP_BRIEFING_SERVER_DISPLAY]) then {
    _mainDisplay call (uiNamespace getVariable "cba_events_fnc_initDisplayCurator");
};

// Add dimension selection buttons
private _dimensionBtnCtrlGrp = _mainDisplay displayCtrl DIMENSIONS_BUTTON_GROUP;
private _dimensionParentCfgCtrlGrp = _mainDisplay displayCtrl CONFIG_DIMENSION_GROUP;
private _dimensionBtnCtrls = [];
private _dimensionCfgCtrlGrps = [];

{
    // Configure dimension button
    private _dimensionBtnCtrl = _mainDisplay ctrlCreate [QGVAR(RscDimensionButton), -1, _dimensionBtnCtrlGrp];
    _dimensionBtnCtrl setVariable [QGVAR(dimension), _x];
    _dimensionBtnCtrl ctrlSetText ((GVAR(dimensions) get _x) get "name");

    (ctrlPosition _dimensionBtnCtrl) params ["", "", "_width", "_height"];
    _dimensionBtnCtrl ctrlSetPosition [_width * _forEachIndex, 0, _width, _height];

    _dimensionBtnCtrl ctrlAddEventHandler ["ButtonClick", {
        params ["_btnCtrl"];
        private _cfgCtrlGrp = [_btnCtrl getVariable QGVAR(dimension)] call FUNC(setDimension);
        [_cfgCtrlGrp] call FUNC(updateMarkerPreview);
    }];

    _dimensionBtnCtrl ctrlCommit 0;
    _dimensionBtnCtrls pushBack _dimensionBtnCtrl;

    // Create all dimension configuration control groups
    private _uiCreate = (GVAR(dimensions) get _x) get "uiCreate";
    private _cfgCtrlGrp = [_dimensionParentCfgCtrlGrp] call _uiCreate;
    _dimensionCfgCtrlGrps pushBack _cfgCtrlGrp;
} forEach GVAR(dimensionKeysSorted);

_dimensionBtnCtrlGrp setVariable [QGVAR(btnCtrls), _dimensionBtnCtrls];
_dimensionParentCfgCtrlGrp setVariable [QGVAR(cfgCtrlGrps), _dimensionCfgCtrlGrps];

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
            private _selectionColor = (configFile >> "RscChatListMission" >> _channelColor) call BIS_fnc_colorConfigToRGBA;
            private _index = _channelCtrl lbAdd (localize _channelText);
            _channelCtrl lbSetValue [_index, _channelID];
            _channelCtrl lbSetColor [_index, _selectionColor];
        };
    } count _channelDropdownArray;
};

private _markerScale = GVAR(defaultMarkerScale); // CBA Setting
private _markerAlpha = GVAR(defaultMarkerAlpha); // CBA Setting

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
    _mainDisplay setVariable [QGVAR(editMarkerNamePrefix), _namePrefix];
    _mainDisplay setVariable [QGVAR(createMarkerMousePosition), _pos];
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

    // Default is dimension with lowest priority value
    private _cfgCtrlGrp = [GVAR(dimensionKeysSorted) select 0] call FUNC(setDimension);
    [_cfgCtrlGrp] call FUNC(updateMarkerPreview);
} else {
    //when editing marker or saving of last selection is enabled
    private _markerParameter = [];
    private _broadcastChannel = -1;
    private _dimension = GVAR(dimensionKeysSorted) select 0; // Default dimension

    if (GVAR(saveLastSelection) && (_namePrefix isEqualTo "")) then {
        if (GVAR(lastSelection) isEqualTo []) then {
            _markerParameter set [0, ["blu", false]]; // Default frame
        } else {
            _markerParameter = GVAR(lastSelection);
        };

        if (isMultiplayer) then {
            private _selectedChannel = currentChannel;
            if (_selectedChannel > 5) then {_selectedChannel = 3;};
            _broadcastChannel = _selectedChannel;
        };

        if (GVAR(currentDimension) isNotEqualTo "") then {
            _dimension = GVAR(currentDimension);
        };

        [_mainDisplay, nil, _mapCtrl, _mousePos] call _setPosAndPrefix;
    } else {
        //get marker family parameter & information from namespace
        private _markerInformation = GVAR(namespace) getVariable [_namePrefix, [[]]];
        _markerParameter = _markerInformation param [1, [], [[]]];
        _broadcastChannel = _markerInformation param [2, -1, [0]];
        _dimension = _markerInformation param [3, "", [""]];

        _markerScale = [_namePrefix] call FUNC(getMarkerScale);
        _markerAlpha = [_namePrefix] call FUNC(getMarkerAlpha);

        [_mainDisplay, _namePrefix] call _setPosAndPrefix;
    };
    CHECK((_markerParameter isEqualTo []) || (_dimension isEqualTo ""));

    //select the original broadcast channel in dropdown
    for "_index" from 0 to ((lbSize _channelCtrl) -1) do {
        private _channelID = _channelCtrl lbValue _index;
        if (_channelID isEqualTo _broadcastChannel) exitWith {
            _channelCtrl lbSetCurSel _index;
        };
    };

    private _cfgCtrlGrp = [_dimension] call FUNC(setDimension);
    private _setUIData = (GVAR(dimensions) get _dimension) get "uiSetData";
    [_cfgCtrlGrp, _markerParameter] call _setUIData;
    [_cfgCtrlGrp] call FUNC(updateMarkerPreview);
};

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
