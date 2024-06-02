#define DEBUG_SYNCHRONOUS
#include "\x\cba\addons\main\script_macros_common.hpp"

// Default versioning level
#define DEFAULT_VERSIONING_LEVEL 2

#define DFUNC(var1) TRIPLES(ADDON,fnc,var1)
#define DEFUNC(var1,var2) TRIPLES(DOUBLES(PREFIX,var1),fnc,var2)

#undef QFUNC
#undef QEFUNC
#define QFUNC(var1) QUOTE(DFUNC(var1))
#define QEFUNC(var1,var2) QUOTE(DEFUNC(var1,var2))

#ifdef DISABLE_COMPILE_CACHE
    #undef PREP
    #define PREP(fncName) DFUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)
#else
    #undef PREP
    #define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#endif

// Replace ERROR macro with version which includes file and line number
#undef ERROR
#define ERROR(MESSAGE) LOG_SYS_FILELINENUMBERS('ERROR',MESSAGE)

// Check
#define CHECK(CONDITION) if (CONDITION) exitWith {}
#define CHECKRET(CONDITION,RETURN) if (CONDITION) exitWith {RETURN;}

#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\a3\ui_f\hpp\defineResincl.inc"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define QPOS_X(N) QUOTE(POS_X(N))
#define QPOS_Y(N) QUOTE(POS_Y(N))
#define QPOS_W(N) QUOTE(POS_W(N))
#define QPOS_H(N) QUOTE(POS_H(N))

#include "\z\mts\addons\markers\script_debug.hpp"
