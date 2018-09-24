[
    QGVAR(saveLastSelection),
    "CHECKBOX",
    [LLSTRING(cba_settings_save_last), LLSTRING(cba_settings_save_last_tooltip)],
    LLSTRING(cba_settings_categoryName),
    false,
    0,
    {
        GVAR(lastSelection) = [];
    }
] call CBA_settings_fnc_init;
