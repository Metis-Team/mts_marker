#include "script_component.hpp"

//create all 3DEN markers
{
    _x call FUNC(createMarkerLocal);
} forEach (getMissionConfigValue [QGVAR(3denData), []]);
