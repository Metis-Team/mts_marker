//declare elements that will be filled in the combobox
GVAR(iconArray) = [
    ["empty"],
    ["infantry"],
    ["infantry_mechanized", ["infantry", "armor"]],
    ["infantry_motorized", ["infantry", "motorized"]],
    ["armor"],
    ["anti_armor"],
    ["anti_armor_armored", ["anti_armor", "armor"]],
    ["anti_armor_motorized", ["anti_armor", "motorized"]],
    ["maintenance"],
    ["air_defence"],
    ["air_defence_missile", ["air_defence", "missile"]],
    ["fixed_wing"],
    ["rotary_wing"],
    ["uav"],
    ["engineer"],
    ["engineer_armored"],
    ["engineer_motorized", ["engineer", "motorized"]],
    ["artillery"],
    ["artillery_sp"],
    ["mortar"],
    ["mortar_armored"],
    ["reconnaissance"],
    ["reconnaissance_armored", ["reconnaissance", "armor"]],
    ["reconnaissance_motorized", ["reconnaissance", "motorized"]],
    ["surface_surface_missile", ["missile", "surface_surface"]],
    ["cbrn"],
    ["military_intelligence"],
    ["military_police"],
    ["signal_unit"],
    ["combat_service_support"],
    ["medical"],
    ["supply"],
    ["transportation"],
    ["amphibious_infantry", ["amphibious", "infantry"]],
    ["amphibious_armor", ["amphibious", "armor"]],
    ["amphibious_reconnaissance", ["amphibious", "reconnaissance"]],
    ["naval"],
    ["combined_arms"],
    ["joint_fire_support"],
    ["special_forces"],
    ["special_operation_forces"],
    ["radar"]
];

GVAR(mod1Array) = [
    ["empty"],
    ["air_assault"],
    ["attack"],
    ["maintenance_top"],
    ["multiple_rocket_launcher"],
    ["single_rocket_launcher"],
    ["sniper"],
    ["headquarters"],
    ["naval_top"],
    ["radar_top"],
    ["bridging"]
];

GVAR(mod2Array) = [
    ["empty"],
    ["airborne"],
    ["heavy"],
    ["medium"],
    ["light"],
    ["mountain"],
    ["vstol"],
    ["wheeled"]
];

GVAR(echelonArray) = [
    ["empty"],
    ["team"],
    ["squad"],
    ["section"],
    ["platoon"],
    ["company"],
    ["battalion"],
    ["regiment"],
    ["brigade"],
    ["division"],
    ["corps"],
    ["army"],
    ["army_group"]
];

//declare valid characters for the unique designation
GVAR(validCharacters) = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","0","1","2","3","4","5","6","7","8","9"];
