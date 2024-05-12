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

// Dialog macros
#include "\z\mts\addons\markers\ui\ui_macros.hpp"
#include "\z\mts\addons\markers\ui\ui_idc.hpp"

#define DEFAULT_DIMENSION "land_unit"

#define COLOR_BUTTON_ENABLED [1, 1, 1, 1]
#define COLOR_BUTTON_DISABLED [0, 0, 0, 1]

// Map displays
#define MAP_3DEN_DISPLAY 313
#define MAP_BRIEFING_SERVER_DISPLAY 52
#define MAP_BRIEFING_CLIENT_DISPLAY 53
#define MAP_PLAYER_DISPLAY 12

// Map Ctrl is same for all 4 displays
#define MAP_CTRL 51

// Default marker scale and alpha
#define MARKER_SCALE 1.3
#define MARKER_ALPHA 1

#define UNIQUE_DESIGNATION_MAX_CHARS 6
#define HIGHER_FORMATION_MAX_CHARS 6

#define MIN_SCALE 0.5
#define MAX_SCALE 2
#define MIN_ALPHA 0.1
#define MAX_ALPHA 1

// More readable conditions
#define HAS_MAP (("ItemMap" in (assignedItems player)) || ("ItemGPS" in (assignedItems player)))
#define IN_3DEN_MAP (is3DEN && {(get3DENActionState "ToggleMap") isEqualTo 1})

// 3DEN Mouse button handler system
#define MOUSE_OFFSET 0xF0

// Operational condition
#define OC_FULLY_CAPABLE 0
#define OC_DAMAGED 1
#define OC_DESTROYED 2

// DTG
#define MIN_YEAR 1900
#define MAX_YEAR 2050
