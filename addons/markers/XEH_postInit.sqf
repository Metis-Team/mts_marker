#include "script_component.hpp"

// Print version to rpt log
private _version = getText (configFile >> "CfgPatches" >> "mts_markers" >> "versionStr");
INFO_1("Metis Marker is version %1.", _version);

CHECK(!hasInterface);

//create all 3DEN markers
{
    _x call FUNC(createMarkerLocal);
} forEach (getMissionConfigValue [QGVAR(3denData), []]);
