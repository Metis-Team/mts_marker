[
    QGVAR(saveLastSelection),
    "CHECKBOX",
    [LLSTRING(cba_settings_save_last), LLSTRING(cba_settings_save_last_tooltip)],
    LLSTRING(cba_category_name),
    false,
    2,
    {
        GVAR(lastSelection) = [];
    }
] call CBA_settings_fnc_init;

[
    QGVAR(useVanillaColors),
    "CHECKBOX",
    [LLSTRING(cba_settings_use_vanilla_colors), LLSTRING(cba_settings_use_vanilla_colors_tooltip)],
    LLSTRING(cba_category_name),
    false,
    0,
    {}
] call CBA_settings_fnc_init;
