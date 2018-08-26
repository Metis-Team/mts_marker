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
#define MAP_BRIEFING_DISPLAY 52
#define MAP_PLAYER_DISPLAY 12

//Map Ctrl is same for all 3 displays
#define MAP_CTRL 51

//default marker scale
#define MARKER_SCALE 1.3

//more readable conditions
#define HAS_MAP (("ItemMap" in (assignedItems player)) || ("ItemGPS" in (assignedItems player)))
#define IN_3DEN_MAP ((get3DENActionState "ToggleMap") isEqualTo 1)
