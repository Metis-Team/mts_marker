#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Generates unique marker prefix name.
 *
 *  Parameter(s):
 *      0: BOOLEAN - Is marker editable.
 *      1: NUMBER - Channel ID where marker is broadcasted.
 *          Check "currentChannel" command for channel ID (-1 up to 5 are supported)
 *          Use -1 for local creation and -10 for global without channel alpha.
 *      2: STRING - Player UID.
 *
 *  Returns:
 *      STRING - Unique marker Prefix
 *
 *  Example:
 *      [true, 0, (getPlayerUID player)] call mts_markers_fnc_generateUniquePrefix
 *
 */

params [["_editable", true, [true]], ["_broadcastChannel", -1, [0]], ["_playerUID", "0", [""]]];
private ["_namePrefix"];

CHECKRET(!([_broadcastChannel] call FUNC(isValidBroadcastChannel)),ERROR("Channel ID not supported"));

// Special case handling for -10 global without alpha.
// Setting -10 at the end does not work, the marker must end with a string that parses to -1
if (_broadcastChannel isEqualTo BC_SCRIPTED_GLOBAL) then {
    _broadcastChannel = BC_SCRIPTED_GLOBAL_MARKER_SUFFIX;
};

//generate unique marker name & return
private _uniqueName = false;
while {!_uniqueName} do {
    private _randomNumber = floor (random 100000);
    if (_editable) then {
        _namePrefix = format ["mtsmarker#%1/%2/%3", _randomNumber, _playerUID, _broadcastChannel];
    } else {
        _namePrefix = format ["mtsnoedit#%1~%2", _randomNumber, _broadcastChannel];
    };
    if ((GVAR(namespace) getVariable [_namePrefix, false]) isEqualTo false) then {_uniqueName = true;};
};

_namePrefix
