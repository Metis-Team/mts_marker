#define COMPONENT markers
#define COMPONENT_BEAUTIFIED Markers
#include "\z\mts\addons\markers\script_mod.hpp"

//#define DEBUG_MODE_FULL
//#define DISABLE_COMPILE_CACHE
//#define CBA_DEBUG_SYNCHRONOUS

#include "\a3\ui_f\hpp\defineCommonGrids.inc"

#ifdef DEBUG_ENABLED_MARKERS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MARKERS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MARKERS
#endif

#include "\z\mts\addons\markers\script_macros.hpp"

// Dialog macros
#include "\z\mts\addons\markers\ui\mts_markers_ui_macros.hpp"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define QPOS_X(N) QUOTE(POS_X(N))
#define QPOS_Y(N) QUOTE(POS_Y(N))
#define QPOS_W(N) QUOTE(POS_W(N))
#define QPOS_H(N) QUOTE(POS_H(N))

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
