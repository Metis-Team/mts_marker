[
    [LLSTRING(cba_category_name), LLSTRING(cba_subcategory_name)],
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
    [LLSTRING(cba_category_name), LLSTRING(cba_subcategory_name)],
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
    [LLSTRING(cba_category_name), LLSTRING(cba_subcategory_name)],
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
    [LLSTRING(cba_category_name), LLSTRING(cba_subcategory_name)],
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
    [LLSTRING(cba_category_name), LLSTRING(cba_subcategory_name)],
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
    [LLSTRING(cba_category_name), LLSTRING(cba_subcategory_name)],
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
