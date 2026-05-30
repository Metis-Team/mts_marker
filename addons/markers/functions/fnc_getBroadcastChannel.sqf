#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Returns the marker broadcast channel of origin.
 *
 *  Parameter(s):
 *      0: STRING - Marker prefix.
 *
 *  Returns:
 *      NUMBER - Channel ID where marker is broadcasted.
 *
 *  Example:
 *      _broadcastChannel = ["mtsmarker#123/0/1"] call mts_markers_fnc_getBroadcastChannel
 *
 */

params [["_namePrefix", "", [""]]];

CHECKRET(_namePrefix isEqualTo "",ERROR("No marker prefix"));

switch ([_namePrefix] call FUNC(isMtsMarker)) do {
     case 1: {
        parseNumber ((_namePrefix splitString "/") param [2, "-1"])
     };
     case 2: {
        parseNumber ((_namePrefix splitString "~") param [1, "-1"])
     };
     default {
        -2
     };
 };
