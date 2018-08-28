#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

ADDON = true;

CHECK(!hasInterface);

//create namespace
if (isServer || (!isMultiplayer)) then {
    GVAR(namespace) = true call CBA_fnc_createNamespace;
    publicVariable QGVAR(namespace);
};

#include "initKeybinds.hpp"
#include "initMarkerVariables.hpp"

if (is3DEN) then {
    {
        _x call FUNC(createMarkerLocal);
    } forEach ("Scenario" get3DENMissionAttribute QGVAR(3denData));
};
