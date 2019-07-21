[
    LLSTRING(cba_category_name),
    QGVAR(create_dialog),
    LLSTRING(cba_keybinding_open_window),
    {
        if (HAS_MAP) then {
            private _curMapDisplay = call FUNC(getDisplay);
            if (!isNull _curMapDisplay && isNull (findDisplay MAIN_DISPLAY)) then {
                [_curMapDisplay, getMousePosition] call FUNC(initializeUI);
                true
            };
        };
    },
    "",
    [0xF0, [true, false, false]] //Shift + LMouse
] call CBA_fnc_addKeybind;

[
    LLSTRING(cba_category_name),
    QGVAR(delete_marker),
    LLSTRING(cba_keybinding_delete),
    {
        if (HAS_MAP) then {
            private _curMapDisplay = call FUNC(getDisplay);
            if (!isNull _curMapDisplay) then {
                private _namePrefix = [_curMapDisplay displayCtrl MAP_CTRL] call FUNC(getMouseOverMarkerPrefix);
                CHECK(_namePrefix isEqualTo "");
                [_namePrefix] call FUNC(deleteMarker);
            };
        };
    },
    "",
    [0xD3, [false, false, false]] //Delete
] call CBA_fnc_addKeybind;

[
    LLSTRING(cba_category_name),
    QGVAR(edit_marker),
    LLSTRING(cba_keybinding_edit),
    {
        if (HAS_MAP) then {
            private _curMapDisplay = call FUNC(getDisplay);
            if (!isNull _curMapDisplay && isNull (findDisplay MAIN_DISPLAY)) then {
                private _namePrefix = [_curMapDisplay displayCtrl MAP_CTRL] call FUNC(getMouseOverMarkerPrefix);
                CHECK(_namePrefix isEqualTo "");
                [_curMapDisplay, nil, _namePrefix] call FUNC(initializeUI);
                true
            };
        };
    },
    "",
    [0x12, [true, false, false]] //Shift + E
] call CBA_fnc_addKeybind;

[
    LLSTRING(cba_category_name),
    QGVAR(move_marker),
    LLSTRING(cba_keybinding_move),
    {
        if (HAS_MAP) then {
            private _curMapDisplay = call FUNC(getDisplay);
            if (!isNull _curMapDisplay) then {
                [_curMapDisplay displayCtrl MAP_CTRL] call FUNC(moveMarkerMouseDown);
            };
        };
    },
    {
        GVAR(MarkerMoveInProgress) = false;
    },
    [0xF0, [false, false, true]] //Alt + LMouse
] call CBA_fnc_addKeybind;

[
    LLSTRING(cba_category_name),
    QGVAR(copy_marker),
    LLSTRING(cba_keybinding_copy),
    {
        if (HAS_MAP) then {
            private _curMapDisplay = call FUNC(getDisplay);
            if (!isNull _curMapDisplay) then {
                [_curMapDisplay displayCtrl MAP_CTRL] call FUNC(copyMarker);
            };
        };
    },
    "",
    [0x2E, [false, true, false]] //Ctrl + C
] call CBA_fnc_addKeybind;

[
    LLSTRING(cba_category_name),
    QGVAR(paste_marker),
    LLSTRING(cba_keybinding_paste),
    {
        if (HAS_MAP) then {
            private _curMapDisplay = call FUNC(getDisplay);
            if (!isNull _curMapDisplay) then {
                [_curMapDisplay displayCtrl MAP_CTRL, getMousePosition] call FUNC(pasteMarker);
            };
        };
    },
    "",
    [0x2F, [false, true, false]] //Ctrl + V
] call CBA_fnc_addKeybind;

//add 3DEN key eventhandlers because CBA keybindung doesn't work in 3DEN editor
if (is3DEN && !(uiNamespace getVariable [QGVAR(added3DENKeyEH), false])) then {
    private _map3denDisplay = findDisplay MAP_3DEN_DISPLAY;

    //prevents multiple keybind assignments when reloading 3DEN
    uiNamespace setVariable [QGVAR(added3DENKeyEH), true];
    _map3denDisplay displayAddEventHandler ["Unload", {
        uiNamespace setVariable [QGVAR(added3DENKeyEH), false];
    }];

    //open marker interface hotkey
    _map3denDisplay displayAddEventHandler ["KeyUp", {
        params ["_control", "_key", "_shift", "_ctrl", "_alt"];
        if (_key isEqualTo 0xB8 && !_shift && !_ctrl) then { //AltGr
            if (IN_3DEN_MAP) then {
                private _curMapDisplay = call FUNC(getDisplay);
                if (!isNull _curMapDisplay && isNull (findDisplay MAIN_DISPLAY)) then {
                    [_curMapDisplay, getMousePosition] call FUNC(initializeUI);
                };
            };
        };
    }];

    //delete marker hotkey
    _map3denDisplay displayAddEventHandler ["KeyUp", {
        params ["_control", "_key", "_shift", "_ctrl", "_alt"];
        if (_key isEqualTo 0xD3 && !_shift && !_ctrl && !_alt) then { //Delete
            if (IN_3DEN_MAP) then {
                private _curMapDisplay = call FUNC(getDisplay);
                if (!isNull _curMapDisplay) then {
                    private _namePrefix = [_curMapDisplay displayCtrl MAP_CTRL, true] call FUNC(getMouseOverMarkerPrefix);
                    CHECK(_namePrefix isEqualTo "");
                    [_namePrefix] call FUNC(deleteMarker);
                };
            };
        };
    }];

    //edit marker hotkey
    _map3denDisplay displayAddEventHandler ["KeyUp", {
        params ["_control", "_key", "_shift", "_ctrl", "_alt"];
        if (_key isEqualTo 0x12 && _shift && !_ctrl && !_alt) then { //Shift + E
            if (IN_3DEN_MAP) then {
                private _curMapDisplay = call FUNC(getDisplay);
                if (!isNull _curMapDisplay && isNull (findDisplay MAIN_DISPLAY)) then {
                    private _namePrefix = [_curMapDisplay displayCtrl MAP_CTRL, true] call FUNC(getMouseOverMarkerPrefix);
                    CHECK(_namePrefix isEqualTo "");
                    [_curMapDisplay, nil, _namePrefix] call FUNC(initializeUI);
                };
            };
        };
    }];

    //move marker hotkey
    _map3denDisplay displayAddEventHandler ["MouseButtonDown", {
        params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];
        if (_button isEqualTo 0 && !_shift && !_ctrl && _alt) then { //Alt + LMouseDown
            if (IN_3DEN_MAP) then {
                private _curMapDisplay = call FUNC(getDisplay);
                if (!isNull _curMapDisplay) then {
                    [_curMapDisplay displayCtrl MAP_CTRL, true] call FUNC(moveMarkerMouseDown);
                };
            };
        };
    }];

     //LMouseUp event for Alt + MouseDown, stops marker position updates
    _map3denDisplay displayAddEventHandler ["MouseButtonUp", {
        if (GVAR(MarkerMoveInProgress)) then {
            GVAR(MarkerMoveInProgress) = false;
        };
    }];

    //copy marker hotkey
    _map3denDisplay displayAddEventHandler ["KeyUp", {
        params ["_control", "_key", "_shift", "_ctrl", "_alt"];
        if (_key isEqualTo 0x2E && _shift && !_ctrl && !_alt) then { //Shift + C
            if (IN_3DEN_MAP) then {
                private _curMapDisplay = call FUNC(getDisplay);
                if (!isNull _curMapDisplay) then {
                    [_curMapDisplay displayCtrl MAP_CTRL] call FUNC(copyMarker);
                };
            };
        };

    }];

    //copy marker hotkey
    _map3denDisplay displayAddEventHandler ["KeyUp", {
        params ["_control", "_key", "_shift", "_ctrl", "_alt"];
        if (_key isEqualTo 0x2F && _shift && !_ctrl && !_alt) then { //Shift + V
            if (IN_3DEN_MAP) then {
                private _curMapDisplay = call FUNC(getDisplay);
                if (!isNull _curMapDisplay) then {
                    [_curMapDisplay displayCtrl MAP_CTRL, getMousePosition] call FUNC(pasteMarker);
                };
            };
        };
    }];
};
