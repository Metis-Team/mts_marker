#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Places marker set/family on map.
 *      Adds the marker set/family to the mts_markers_namespace.
 *      This function has a local effect.
 *
 *  Parameter(s):
 *      0: STRING - Unique marker prefix. Format: mtsmarker#<Random Number>/<Player UID>/<Channel ID>
 *      1: NUMBER - Channel ID where marker is broadcasted. (Check "currentChannel" command for channel ID)
 *      2: ARRAY - Position where the marker will be placed.
 *      3: STRING - Frameshape of the marker (blu, bludash, red, reddash, neu, unk, unkdash).
 *      4: ARRAY - Composition of modifier for the marker. IDs are listed in the wiki. (Optional, default: no modifiers)
 *          0: NUMBER - Icon (0 for none).
 *          1: NUMBER - Modifier 1 (0 for none).
 *          2: NUMBER - Modifier 2 (0 for none).
 *      5: ARRAY - Group size array. (Optional, default: no echelon)
 *          0: NUMBER - Group size (0 for none).
 *          1: BOOLEAN - Reinforced or (+) symbol.
 *          2: BOOLEAN - Reduced or (-) symbol (if both are true it will show (±)).
 *      6: ARRAY - Marker text left. Can only be max. 3 characters. (Optional, default: no text)
 *      7: STRING - Marker text right. (Optional, default: no text)
 *      8: NUMBER - Scale of the marker. (Optional, default: 1.3)
 *
 *  Returns:
 *     STRING - Marker prefix.
 *
 *  Example:
 *      _namePrefix = ["mtsmarker#123/0/1", 1, [2000,1000], "blu", [4,0,0], [4, false, true], ["3","3"], "9"] call mts_markers_fnc_createMarkerLocal
 *
 */

params [
    ["_namePrefix", "", [""]],
    ["_broadcastChannel", -1, [0]],
    ["_pos", [0,0], [[]], [2,3]],
    ["_frameshape", "", [""]],
    ["_modifier", [0,0,0], [[]], 3],
    ["_size", [0,false,false], [[]], 3],
    ["_textleft", [], [[]]],
    ["_textright", "", [""]],
    ["_scale", MARKER_SCALE, [0]]
];
_size params [["_grpsize", 0, [0]], ["_reinforced", false, [false]], ["_reduced", false, [false]]];

CHECK(!hasInterface);
CHECKRET(_namePrefix isEqualTo "", ERROR("No marker prefix"));
CHECKRET(_frameshape isEqualTo "", ERROR("No frameshape"));

//prevent unscaled markers
if (_scale <= 0) then {
    WARNING("Negative scale for markers aren't allowed. Reseted marker scale back to default");
    _scale = MARKER_SCALE;
};

//create frameshape marker
private _frameshapetype = format ["mts_%1_frameshape", _frameshape];
private _markerFrame = createMarkerLocal [format ["%1_frame", _namePrefix], _pos];
_markerFrame setMarkerTypeLocal _frameshapetype;
_markerFrame setMarkerSizeLocal [_scale, _scale];

//create array with every marker name in the set. Minimum is the frameshape
private _markerFamily = [_markerFrame];

//Reset exeptions
private _dashedFrameshape = false;

if ((count _frameshape) > 3) then {
    _frameshape = _frameshape select [0, 3];
    CHECK(_frameshape isEqualTo "neu");
    _dashedFrameshape = true;
};

//add color to the frameshape
private _frameshapecolor = format ["mts_%1_color", _frameshape];
_markerFrame setMarkerColorLocal _frameshapecolor;

//create group size marker
if (_grpsize > 0) then {
    private _unitsize = format ["mts_%1_size_%2", _frameshape, _grpsize];
    private _markerSize = createMarkerLocal [format ["%1_size", _namePrefix], _pos];
    _markerSize setMarkerTypeLocal _unitsize;
    _markerSize setMarkerSizeLocal [_scale, _scale];

    _markerFamily pushBack _markerSize;
};

//creates (-),(+),(±) marker
if ((_reinforced) && !(_reduced)) then {
    private _unitsizeMod = format ["mts_%1_size_reinforced", _frameshape];
    private _markerSizeMod = createMarkerLocal [format ["%1_size_mod", _namePrefix], _pos];
    _markerSizeMod setMarkerTypeLocal _unitsizeMod;
    _markerSizeMod setMarkerSizeLocal [_scale, _scale];

    _markerFamily pushBack _markerSizeMod;
};
if ((_reduced) && !(_reinforced)) then {
    private _unitsizeMod = format ["mts_%1_size_reduced", _frameshape];
    private _markerSizeMod = createMarkerLocal [format ["%1_size_mod", _namePrefix], _pos];
    _markerSizeMod setMarkerTypeLocal _unitsizeMod;
    _markerSizeMod setMarkerSizeLocal [_scale, _scale];

    _markerFamily pushBack _markerSizeMod;
};
if ((_reinforced) && (_reduced)) then {
    private _unitsizeMod = format ["mts_%1_size_reinforced_reduced", _frameshape];
    private _markerSizeMod = createMarkerLocal [format ["%1_size_mod", _namePrefix], _pos];
    _markerSizeMod setMarkerTypeLocal _unitsizeMod;
    _markerSizeMod setMarkerSizeLocal [_scale, _scale];

    _markerFamily pushBack _markerSizeMod;
};

//create all modifiers
{
    private _markertype = format ["mts_%1_mod_%2", _frameshape, _x];
    private _markerMod = createMarkerLocal [format ["%1_%2", _namePrefix, _x], _pos];
    _markerMod setMarkerTypeLocal _markertype;
    _markerMod setMarkerSizeLocal [_scale, _scale];

    _markerFamily pushBack _markerMod;
} forEach (_modifier call FUNC(getAllModifiers));

//create text marker (right side of marker)
if !(_textright isEqualTo "") then {
    private _markerText = createMarkerLocal [format ["%1_text", _namePrefix], _pos];
    _markerText setMarkerTypeLocal "mts_special_textmarker";
    _markerText setMarkerSizeLocal [_scale, _scale];
    _markerText setMarkerTextLocal _textright;

    _markerFamily pushBack _markerText;
};

//create text marker (left side of marker)
if ((count _textLeft) > 0) then {
    scopeName "textLeftCreation";
    //only take the first three characters of the left text
    if ((count _textLeft) > 3) then {
        _textLeft resize 3;
    };

    //check if all characters are valid & make all characters uppercase
    {
        _x = toUpper _x;
        _textLeft set [_forEachIndex, _x];
        if !(_x in GVAR(validCharacters)) then {
            //only allow valid characters that are in the array
            WARNING("Invalid character in marker text left. Creating marker without unique designation");
            _textLeft = [];
            breakOut "textLeftCreation";
        };
    } forEach _textleft;

    //convert special number markers
    if (_textleft isEqualTo ["1","1"]) then {_textleft = ["11"];};
    if (_textleft isEqualTo ["1","1","1"]) then {_textleft = ["111"];};

    if (_textleft isEqualTo ["I","I"]) then {_textleft = ["II"];};
    if (_textleft isEqualTo ["I","I","I"]) then {_textleft = ["III"];};

    //always write the text from right to left (2 = right, 1 = middle, 0 = left)
    private _numPos = 2;

    for "_numIndex" from ((count _textLeft) -1) to 0 step -1 do {
        private _num = _textLeft select _numIndex;
        private _numType = format ["mts_%1_num_%2_%3", _frameshape, _numPos, _num];
        private _markerNumLeft = createMarkerLocal [format ["%1_num_%2_%3", _namePrefix, _numPos, _num], _pos];
        _markerNumLeft setMarkerTypeLocal _numType;
        _markerNumLeft setMarkerSizeLocal [_scale, _scale];

        _markerFamily pushBack _markerNumLeft;

        _numPos = _numPos - 1;
    };
};

private _markerInformation = GVAR(namespace) getVariable [_namePrefix, []];
if (_markerInformation isEqualTo []) then { //save in mts_markers_namespace
    //save marker parameters for editing purposes
    private _markerParameter = [_frameshape, _dashedFrameshape, _modifier, _size, _textleft, _textright, _broadcastChannel];
    GVAR(namespace) setVariable [_namePrefix, [_markerFamily, _markerParameter], true];

    if (is3DEN) then {
        //save 3DEN marker data in a hidden attribute
        private _3denData = "Scenario" get3DENMissionAttribute QGVAR(3denData);
        _3denData pushbackUnique _this;
        set3DENMissionAttributes [["Scenario", QGVAR(3denData), _3denData]];
    };
};

_namePrefix
