#define COMPONENT markers
#define COMPONENT_BEAUTIFIED Markers
#include "\z\mts\addons\markers\script_mod.hpp"

//#define DEBUG_MODE_FULL
//#define DISABLE_COMPILE_CACHE
//#define CBA_DEBUG_SYNCHRONOUS

#ifdef DEBUG_ENABLED_MARKERS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MARKERS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MARKERS
#endif

#include "\z\mts\addons\markers\script_macros.hpp"

//Dialog IDCs
#include "\z\mts\addons\markers\ui\mts_markers_ui_macros.hpp"

//Map displays
#define MAP_3DEN_DISPLAY 313
#define MAP_BRIEFING_SERVER_DISPLAY 52
#define MAP_BRIEFING_CLIENT_DISPLAY 53
#define MAP_PLAYER_DISPLAY 12

//Map Ctrl is same for all 4 displays
#define MAP_CTRL 51

//default marker scale
#define MARKER_SCALE 1.3

#define UNIQUE_DESIGNATION_MAX_CHARS 3

//more readable conditions
#define HAS_MAP (("ItemMap" in (assignedItems player)) || ("ItemGPS" in (assignedItems player)))
#define IN_3DEN_MAP (is3DEN && {(get3DENActionState "ToggleMap") isEqualTo 1})

// 3DEN Mouse button handler system
#define MOUSE_OFFSET 0xF0
