[
    [LLSTRING(cba_category_name), LLSTRING(cba_subcategory_3den_name)],
    QGVAR(3den_create_display),
    LLSTRING(cba_keybinding_open_window),
    "",
    {
        CHECK(!IN_3DEN_MAP);
        private _curMapDisplay = call FUNC(getDisplay);
        if (!isNull _curMapDisplay && isNull (findDisplay MAIN_DISPLAY)) then {
            [_curMapDisplay, getMousePosition] call FUNC(initializeUI);
        };
    },
    [0xB8, [false, false, false]] //AltGr
] call CBA_fnc_addKeybind;

[
    [LLSTRING(cba_category_name), LLSTRING(cba_subcategory_3den_name)],
    QGVAR(3den_delete_marker),
    LLSTRING(cba_keybinding_delete),
    "",
    {
        CHECK(!IN_3DEN_MAP);
        private _curMapDisplay = call FUNC(getDisplay);
        if (!isNull _curMapDisplay) then {
            private _namePrefix = [_curMapDisplay displayCtrl MAP_CTRL, true] call FUNC(getMouseOverMarkerPrefix);
            CHECK(_namePrefix isEqualTo "");
            [_namePrefix] call FUNC(deleteMarker);
        };
    },
    [0xD3, [false, false, false]] //Delete
] call CBA_fnc_addKeybind;

[
    [LLSTRING(cba_category_name), LLSTRING(cba_subcategory_3den_name)],
    QGVAR(3den_edit_marker),
    LLSTRING(cba_keybinding_edit),
    "",
    {
        CHECK(!IN_3DEN_MAP);
        private _curMapDisplay = call FUNC(getDisplay);
        if (!isNull _curMapDisplay && isNull (findDisplay MAIN_DISPLAY)) then {
            private _namePrefix = [_curMapDisplay displayCtrl MAP_CTRL, true] call FUNC(getMouseOverMarkerPrefix);
            CHECK(_namePrefix isEqualTo "");
            [_curMapDisplay, nil, _namePrefix] call FUNC(initializeUI);
        };
    },
    [0x12, [true, false, false]] //Shift + E
] call CBA_fnc_addKeybind;

[
    [LLSTRING(cba_category_name), LLSTRING(cba_subcategory_3den_name)],
    QGVAR(3den_move_marker),
    LLSTRING(cba_keybinding_move),
    {
        CHECK(!IN_3DEN_MAP);
        private _curMapDisplay = call FUNC(getDisplay);
        if (!isNull _curMapDisplay) then {
            [_curMapDisplay displayCtrl MAP_CTRL, true] call FUNC(moveMarkerMouseDown);
        };
    },
    {
        CHECK(!IN_3DEN_MAP);
        if (GVAR(MarkerMoveInProgress)) then {
            GVAR(MarkerMoveInProgress) = false;
        };
    },
    [0xF0, [false, false, true]] //Alt + LMouse
] call CBA_fnc_addKeybind;

[
    [LLSTRING(cba_category_name), LLSTRING(cba_subcategory_3den_name)],
    QGVAR(3den_copy_marker),
    LLSTRING(cba_keybinding_copy),
    "",
    {
        CHECK(!IN_3DEN_MAP);
        private _curMapDisplay = call FUNC(getDisplay);
        if (!isNull _curMapDisplay) then {
            [_curMapDisplay displayCtrl MAP_CTRL] call FUNC(copyMarker);
        };
    },
    [0x2E, [true, false, false]] //Shift + C
] call CBA_fnc_addKeybind;

[
    [LLSTRING(cba_category_name), LLSTRING(cba_subcategory_3den_name)],
    QGVAR(3den_paste_marker),
    LLSTRING(cba_keybinding_paste),
    "",
    {
        CHECK(!IN_3DEN_MAP);
        private _curMapDisplay = call FUNC(getDisplay);
        if (!isNull _curMapDisplay) then {
            [_curMapDisplay displayCtrl MAP_CTRL, getMousePosition] call FUNC(pasteMarker);
        };
    },
    [0x2F, [true, false, false]] //Shift + V
] call CBA_fnc_addKeybind;

// add 3DEN key eventhandlers because CBA keybindung doesn't work in 3DEN editor
if (is3DEN && !(uiNamespace getVariable [QGVAR(added3DENKeyEH), false])) then {
    private _map3denDisplay = findDisplay MAP_3DEN_DISPLAY;

    // prevents multiple keybind assignments when reloading 3DEN
    uiNamespace setVariable [QGVAR(added3DENKeyEH), true];
    _map3denDisplay displayAddEventHandler ["Unload", {
        uiNamespace setVariable [QGVAR(added3DENKeyEH), false];
    }];

    // this will support mouse buttons and standard keys but not mouse wheel or "user action" keys
    // open marker interface hotkey
    _map3denDisplay displayAddEventHandler ["KeyUp", {[QGVAR(3den_create_display), false, _this] call FUNC(3denKeyHandler);}];
    _map3denDisplay displayAddEventHandler ["MouseButtonUp", {[QGVAR(3den_create_display), false, _this] call FUNC(3denMouseHandler);}];

    // delete marker
    _map3denDisplay displayAddEventHandler ["KeyUp", {[QGVAR(3den_delete_marker), false, _this] call FUNC(3denKeyHandler);}];
    _map3denDisplay displayAddEventHandler ["MouseButtonUp", {[QGVAR(3den_delete_marker), false, _this] call FUNC(3denMouseHandler);}];

    // edit marker
    _map3denDisplay displayAddEventHandler ["KeyUp", {[QGVAR(3den_edit_marker), false, _this] call FUNC(3denKeyHandler);}];
    _map3denDisplay displayAddEventHandler ["MouseButtonUp", {[QGVAR(3den_edit_marker), false, _this] call FUNC(3denMouseHandler);}];

    // move marker
    _map3denDisplay displayAddEventHandler ["KeyDown", {[QGVAR(3den_move_marker), true, _this] call FUNC(3denKeyHandler);}];
    _map3denDisplay displayAddEventHandler ["MouseButtonDown", {[QGVAR(3den_move_marker), true, _this] call FUNC(3denMouseHandler);}];
    _map3denDisplay displayAddEventHandler ["KeyUp", {[QGVAR(3den_move_marker), false, _this] call FUNC(3denKeyHandler);}];
    _map3denDisplay displayAddEventHandler ["MouseButtonUp", {[QGVAR(3den_move_marker), false, _this] call FUNC(3denMouseHandler);}];

    // copy marker
    _map3denDisplay displayAddEventHandler ["KeyUp", {[QGVAR(3den_copy_marker), false, _this] call FUNC(3denKeyHandler);}];
    _map3denDisplay displayAddEventHandler ["MouseButtonUp", {[QGVAR(3den_copy_marker), false, _this] call FUNC(3denMouseHandler);}];

    // paste marker
    _map3denDisplay displayAddEventHandler ["KeyUp", {[QGVAR(3den_paste_marker), false, _this] call FUNC(3denKeyHandler);}];
    _map3denDisplay displayAddEventHandler ["MouseButtonUp", {[QGVAR(3den_paste_marker), false, _this] call FUNC(3denMouseHandler);}];
};
