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
] call CBA_fnc_addSetting;

[
    QGVAR(useVanillaColors),
    "CHECKBOX",
    [LLSTRING(cba_settings_use_vanilla_colors), LLSTRING(cba_settings_use_vanilla_colors_tooltip)],
    LLSTRING(cba_category_name),
    false,
    0,
    {}
] call CBA_fnc_addSetting;

[
    QGVAR(displayShortDTG),
    "CHECKBOX",
    [LLSTRING(cba_settings_default_short_dtg), LLSTRING(cba_settings_default_short_dtg_tooltip)],
    LLSTRING(cba_category_name),
    true,
    2,
    {}
] call CBA_fnc_addSetting;

[
    QGVAR(defaultMarkerScale),
    "SLIDER",
    [LLSTRING(cba_settings_default_marker_scale), LLSTRING(cba_settings_default_marker_scale_tooltip)],
    LLSTRING(cba_category_name),
    [MIN_SCALE, MAX_SCALE, MARKER_SCALE],
    0,
    {}
] call CBA_fnc_addSetting;

[
    QGVAR(defaultMarkerAlpha),
    "SLIDER",
    [LLSTRING(cba_settings_default_marker_alpha), LLSTRING(cba_settings_default_marker_alpha_tooltip)],
    LLSTRING(cba_category_name),
    [MIN_ALPHA, MAX_ALPHA, MARKER_ALPHA],
    0,
    {}
] call CBA_fnc_addSetting;
