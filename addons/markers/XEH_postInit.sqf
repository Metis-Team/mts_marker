#include "script_component.hpp"

CHECK(!hasInterface);

//create all 3DEN markers
{
    private _args = [_x] call FUNC(convertCreateMarkerParams);
    _args call FUNC(createMarkerLocal);
} forEach (getMissionConfigValue [QGVAR(3denData), []]);
