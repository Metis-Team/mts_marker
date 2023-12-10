#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

ADDON = true;

// Print version to rpt log
private _version = getText (configFile >> "CfgPatches" >> "mts_markers" >> "versionStr");
INFO_1("Metis Marker version: %1.", _version);

//create namespace
if (isServer || (!isMultiplayer)) then {
    GVAR(namespace) = true call CBA_fnc_createNamespace;
    publicVariable QGVAR(namespace);
};

CHECK(!hasInterface);

#include "initKeybinds.hpp"
#include "init3denKeybinds.hpp"
#include "initSettings.hpp"
#include "initMarkerVariables.hpp"
#include "initCharacterMarkerVariables.hpp"

// Corresponding vanilla colors for each identity
GVAR(vanillaColorMap) = createHashMapFromArray [["blu", "colorBLUFOR"], ["red", "colorOPFOR"], ["neu", "colorIndependent"], ["unk", "ColorUNKNOWN"]];

// Standard time zones according to ATP 6-02.70 Appendix E
// https://armypubs.army.mil/epubs/DR_pubs/DR_a/pdf/web/ARN19477_ATP%206-02x70%20FINAL%20WEB.pdf
GVAR(standardTimeZones) = createHashMapFromArray [
    [-12, "Y"],
    [-11, "X"],
    [-10, "W"],
    [-9, "V"],
    [-8, "U"],
    [-7, "T"],
    [-6, "S"],
    [-5, "R"],
    [-4, "Q"],
    [-3, "P"],
    [-2, "O"],
    [-1, "N"],
    [0, "Z"],
    [1, "A"],
    [2, "B"],
    [3, "C"],
    [4, "D"],
    [5, "E"],
    [6, "F"],
    [7, "G"],
    [8, "H"],
    [9, "I"],
    // skipping J because its reserved for local time
    [10, "K"],
    [11, "L"],
    [12, "M"]
];

// Standard 3 letter abbreviations of the months
GVAR(monthAbbreviations) = createHashMapFromArray [
    [1, "jan"],
    [2, "feb"],
    [3, "mar"],
    [4, "apr"],
    [5, "may"],
    [6, "jun"],
    [7, "jul"],
    [8, "aug"],
    [9, "sep"],
    [10, "oct"],
    [11, "nov"],
    [12, "dec"]
];

// Cardinal and ordinal moving directions
GVAR(directions) = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"];
GVAR(directionLocalization) = [
    ["str_q_north", LSTRING(ui_direction_n_short)],
    [LSTRING(ui_direction_nne), LSTRING(ui_direction_nne_short)],
    ["str_q_north_east", LSTRING(ui_direction_ne_short)],
    [LSTRING(ui_direction_ene), LSTRING(ui_direction_ene_short)],
    ["str_q_east", LSTRING(ui_direction_e_short)],
    [LSTRING(ui_direction_ese), LSTRING(ui_direction_ese_short)],
    ["str_q_south_east", LSTRING(ui_direction_se_short)],
    [LSTRING(ui_direction_sse), LSTRING(ui_direction_sse_short)],
    ["str_q_south", LSTRING(ui_direction_s_short)],
    [LSTRING(ui_direction_ssw), LSTRING(ui_direction_ssw_short)],
    ["str_q_south_west", LSTRING(ui_direction_sw_short)],
    [LSTRING(ui_direction_wsw), LSTRING(ui_direction_wsw_short)],
    ["str_q_west", LSTRING(ui_direction_w_short)],
    [LSTRING(ui_direction_wnw), LSTRING(ui_direction_wnw_short)],
    ["str_q_north_west", LSTRING(ui_direction_nw_short)],
    [LSTRING(ui_direction_nnw), LSTRING(ui_direction_nnw_short)]
];

GVAR(lastSelection) = [];

if (is3DEN) then {
    {
        private _args = [_x] call FUNC(convertCreateMarkerParams);
        _args call FUNC(createMarkerLocal);
    } forEach ("Scenario" get3DENMissionAttribute QGVAR(3denData));
};

GVAR(clipboard) = "";

GVAR(localMarkers) = createHashMap;
