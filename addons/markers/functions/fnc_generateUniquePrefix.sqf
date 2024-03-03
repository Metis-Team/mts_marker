#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Generates unique marker prefix name.
 *
 *  Parameter(s):
 *      0: BOOLEAN - Is marker editable.
 *      1: NUMBER - Channel ID where marker is broadcasted. (Check "currentChannel" command for channel ID; Use -1 for local creation)
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

CHECKRET(((_broadcastChannel > 5) || (_broadcastChannel < -1)),ERROR("Channel ID not supported"));

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
