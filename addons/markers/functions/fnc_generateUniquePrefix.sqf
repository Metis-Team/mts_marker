#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Generates unique marker prefix name.
 *
 *  Parameter(s):
 *      0: BOOLEAN - Is marker editable.
 *      1: STRING - Player UID.
 *      2: NUMBER - Channel ID where marker is broadcasted. (Check "currentChannel" command for channel ID)
 *
 *  Returns:
 *      STRING - Unique marker Prefix
 *
 *  Example:
 *      [true, (getPlayerUID player), 0] call mts_markers_fnc_generateUniquePrefix
 *
 */

params [["_editable", true, [true]], ["_playerUID", "0", [""]], ["_broadcastChannel", 5, [0]]];
private ["_namePrefix"];

//generate unique marker name & return
private _uniqueName = false;
while {!_uniqueName} do {
    private _randomnumber = floor (random 100000);
    if (_editable) then {
        _namePrefix = format ["mtsmarker#%1/%2/%3", _randomnumber, _playerUID, _broadcastChannel];
    } else {
        _namePrefix = format ["mts3DEN#%1", _randomnumber];
    };
    private _checkname = format ["%1_frame", _namePrefix];
    if !(_checkname in allMapMarkers) then {_uniqueName = true;};
};

_namePrefix
