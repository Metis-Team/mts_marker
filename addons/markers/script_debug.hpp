/**
Fast Recompiling via function
**/
// #define DISABLE_COMPILE_CACHE
// To Use: [] call MTS_PREP_RECOMPILE;

#ifdef DISABLE_COMPILE_CACHE
    #define LINKFUNC(x) {_this call FUNC(x)}
    #define PREP_RECOMPILE_START    if (isNil "MTS_PREP_RECOMPILE") then {MTS_RECOMPILES = []; MTS_PREP_RECOMPILE = {{call _x} forEach MTS_RECOMPILES;}}; private _recomp = {
    #define PREP_RECOMPILE_END      }; call _recomp; MTS_RECOMPILES pushBack _recomp;\
        [LLSTRING(cba_category_name), QGVAR(recompile), "Recompile Functions", {\
            private _start = diag_tickTime;\
            [] call MTS_PREP_RECOMPILE;\
            private _end = diag_tickTime;\
            systemChat format ["MTS: Recompile took [%1 ms]", (1000 * (_end - _start)) toFixed 1];\
            true\
        }, {false}, [0x2F, [false, false, false]], false] call CBA_fnc_addKeybind; // V Key
#else
    #define LINKFUNC(x) FUNC(x)
    #define PREP_RECOMPILE_START /* */
    #define PREP_RECOMPILE_END /* */
#endif
