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
 *      3: ARRAY - The marker configuration.
 *          0: ARRAY - Frameshape of the marker.
 *              0: STRING - Identity (blu, red, neu, unk).
 *              1: BOOLEAN - Dashed (e.g. supect).
 *              2: BOOLEAN - Headquaters.
 *          1: ARRAY - Composition of modifier for the marker. IDs are listed in the wiki. (Optional, default: no modifiers)
 *              0: NUMBER - Icon (0 for none).
 *              1: NUMBER - Modifier 1 (0 for none).
 *              2: NUMBER - Modifier 2 (0 for none).
 *          2: ARRAY - Group size array. (Optional, default: no echelon)
 *              0: NUMBER - Group size (0 for none).
 *              1: BOOLEAN - Reinforced or (+) symbol.
 *              2: BOOLEAN - Reduced or (-) symbol (if both are true it will show (±)).
 *          3: ARRAY - Marker text left - Unique designation. Can only be max. 3 characters. (Optional, default: no text)
 *          4: STRING - Marker text right - Higher formation. (Optional, default: no text)
 *          5: ARRAY - Marker text right bottom - Higher formation. Can only be max. 6 characters. (Optional, default: no text)
 *          6: NUMBER - Operational condition of the unit. (0 = fully capable, 1 = damaged, 2 = destroyed)
 *      4: NUMBER - Scale of the marker. (Optional, default: 1.3)
 *      5: NUMBER - Alpha of the marker. (Optional, default: 1)
 *
 *  Returns:
 *     STRING - Marker prefix.
 *
 *  Example:
 *      _namePrefix = ["mtsmarker#123/0/1", 1, [2000,1000], [["blu", false, false], [4,0,0], [4, false, true], ["3","3"], "9", ["4"]]] call mts_markers_fnc_createMarkerLocal
 *
 */

params [
    ["_namePrefix", "", [""]],
    ["_broadcastChannel", -1, [0]],
    ["_pos", [0,0], [[]], [2,3]],
    ["_markerParameter", [], [[]]],
    ["_scale", MARKER_SCALE, [0]],
    ["_alpha", MARKER_ALPHA, [0]]
];

_markerParameter params [
    ["_frameshape", ["", false, false], [[]]],
    ["_modifier", [0,0,0], [[]], 3],
    ["_size", [0,false,false], [[]], 3],
    ["_uniqueDesignation", [], [[]]],
    ["_additionalInfo", "", [""]],
    ["_higherFormation", [], [[]]],
    ["_operationalCondition", OC_FULLY_CAPABLE, [0]]
];
_size params [["_grpsize", 0, [0]], ["_reinforced", false, [false]], ["_reduced", false, [false]]];

CHECK(!hasInterface);
CHECKRET(_namePrefix isEqualTo "", ERROR("No marker prefix"));
CHECKRET((_frameshape select 0) isEqualTo "", ERROR("No frameshape or wrong format. Expected format: [STRING, BOOLEAN, BOOLEAN]"));

_frameshape params [["_identity", "", [""]], ["_dashedFrameshape", false, [false]], ["_isHq", false, [false]]];
_identity = toLower _identity;

//prevent unscaled markers
if (_scale <= 0) then {
    WARNING("Negative scale for markers aren't allowed. Reset marker scale back to default.");
    _scale = MARKER_SCALE;
};

if (_alpha < 0 || _alpha > 1) then {
    WARNING("Alpha value for marker out of bounds (0-1). Reset marker alpha back to default.");
    _alpha = MARKER_ALPHA;
};

if !(_identity in ["blu", "red", "neu", "unk"]) exitWith {
    ERROR_1("Unkown Identity %1", _identity);
};

CHECKRET(_operationalCondition < 0 || _operationalCondition > 2, ERROR("Operational condition must be a number between 0 and 2."));

//create frameshape marker
private _identityComplete = if (_dashedFrameshape) then {
    format ["%1dash", _identity]
} else {
    _identity
};
private _frameshapeType = if (GVAR(useVanillaColors)) then {
    format ["mts_%1_vanilla_frameshape", _identityComplete]
} else {
    format ["mts_%1_frameshape", _identityComplete]
};

private _markerFrame = createMarkerLocal [format ["%1_frame", _namePrefix], _pos];
_markerFrame setMarkerTypeLocal _frameshapeType;
_markerFrame setMarkerSizeLocal [_scale, _scale];
_markerFrame setMarkerAlphaLocal _alpha;

//create array with every marker name in the set. Minimum is the frameshape
private _markerFamily = [_markerFrame];

//add color to the frameshape
private _frameshapeColor = if (GVAR(useVanillaColors)) then {
    GVAR(vanillaColorMap) getOrDefault [_identity, ""]
} else {
    format ["mts_%1_color", _identity]
};
CHECKRET(_frameshapeColor isEqualTo "", ERROR_1("Could not get corresponding vanilla color for identity %1.", _identity));

_markerFrame setMarkerColorLocal _frameshapeColor;

if (_isHq) then {
    private _markerHq = createMarkerLocal [format ["%1_hq", _namePrefix], _pos];
    _markerHq setMarkerTypeLocal format ["mts_%1_hq", _identity];
    _markerHq setMarkerSizeLocal [_scale, _scale];
    _markerHq setMarkerAlphaLocal _alpha;

    _markerFamily pushBack _markerHq;
};

//create group size marker
if (_grpsize > 0) then {
    private _unitsize = format ["mts_%1_size_%2", _identity, _grpsize];
    private _markerSize = createMarkerLocal [format ["%1_size", _namePrefix], _pos];
    _markerSize setMarkerTypeLocal _unitsize;
    _markerSize setMarkerSizeLocal [_scale, _scale];
    _markerSize setMarkerAlphaLocal _alpha;

    _markerFamily pushBack _markerSize;
};

//creates (-),(+),(±) marker
if (_reinforced || _reduced) then {
    private _unitsizeMod = "mts_com_size";
    if (_reinforced) then {
        _unitsizeMod = _unitsizeMod + "_reinforced";
    };
    if (_reduced) then {
        _unitsizeMod = _unitsizeMod + "_reduced";
    };

    private _markerSizeMod = createMarkerLocal [format ["%1_size_mod", _namePrefix], _pos];
    _markerSizeMod setMarkerTypeLocal _unitsizeMod;
    _markerSizeMod setMarkerSizeLocal [_scale, _scale];
    _markerSizeMod setMarkerAlphaLocal _alpha;

    _markerFamily pushBack _markerSizeMod;
};

//create all modifiers
{
    private _markertype = format ["mts_%1_mod_%2", _identity, _x];
    private _markerMod = createMarkerLocal [format ["%1_%2", _namePrefix, _x], _pos];
    _markerMod setMarkerTypeLocal _markertype;
    _markerMod setMarkerSizeLocal [_scale, _scale];
    _markerMod setMarkerAlphaLocal _alpha;

    _markerFamily pushBack _markerMod;
} forEach (_modifier call FUNC(getAllModifiers));

//create text marker (right side of marker)
if (_additionalInfo isNotEqualTo "") then {
    private _markerText = createMarkerLocal [format ["%1_text", _namePrefix], _pos];
    _markerText setMarkerTypeLocal "mts_special_textmarker";
    _markerText setMarkerSizeLocal [_scale, _scale];
    _markerText setMarkerAlphaLocal _alpha;
    _markerText setMarkerTextLocal _additionalInfo;

    _markerFamily pushBack _markerText;
};

// create text marker (bottom left of marker)
if ((count _uniqueDesignation) > 0) then {
    TRACE_1("uniqueDesignation input", _uniqueDesignation);
    scopeName "textLeftCreation";
    //only take the first three characters of the left text
    if ((count _uniqueDesignation) > UNIQUE_DESIGNATION_MAX_CHARS) then {
        _uniqueDesignation resize UNIQUE_DESIGNATION_MAX_CHARS;
    };


    //check if all characters are valid & make all characters uppercase
    {
        _x = toUpper _x;
        _uniqueDesignation set [_forEachIndex, _x];
        if !(_x in GVAR(validCharacters)) then {
            //only allow valid characters that are in the array
            WARNING("Invalid character in marker text bottom left. Creating marker without unique designation");
            _uniqueDesignation = [];
            breakOut "textLeftCreation";
        };
    } forEach _uniqueDesignation;

    //always write the text from right to left (2 = right, 1 = middle, 0 = left)
    private _letterPos = 0;

    for "_numIndex" from ((count _uniqueDesignation) - 1) to 0 step -1 do {
        private _letter = _uniqueDesignation select _numIndex;

        ([_namePrefix, "uniqueDesignation", _letterPos, _letter] call FUNC(getCharMarkerType)) params ["_letterType", "_markerName"];
        TRACE_3("uniqueDesignation", _letter, _letterType, _markerName);

        private _markerUniqueDesignation = createMarkerLocal [_markerName, _pos];
        _markerUniqueDesignation setMarkerTypeLocal _letterType;
        _markerUniqueDesignation setMarkerSizeLocal [_scale, _scale];
        _markerUniqueDesignation setMarkerAlphaLocal _alpha;

        _markerFamily pushBack _markerUniqueDesignation;

        _letterPos = _letterPos + 1;
    };
};

// create text marker (bottom right of marker)
if ((count _higherFormation) > 0) then {
    TRACE_1("higherFormation input", _higherFormation);

    scopeName "textRightCreation";
    //only take the first three characters of the left text
    if ((count _higherFormation) > HIGHER_FORMATION_MAX_CHARS) then {
        _higherFormation resize HIGHER_FORMATION_MAX_CHARS;
    };

    //check if all characters are valid & make all characters uppercase
    {
        _x = toUpper _x;
        _higherFormation set [_forEachIndex, _x];
        if !(_x in GVAR(validCharacters)) then {
            //only allow valid characters that are in the array
            WARNING("Invalid character in marker text bottom right. Creating marker without higher formation");
            _higherFormation = [];
            breakOut "textRightCreation";
        };
    } forEach _higherFormation;

    {
        private _letter = _x;

        ([_namePrefix, "higherFormation", _forEachIndex, _letter] call FUNC(getCharMarkerType)) params ["_letterType", "_markerName"];
        TRACE_3("higherFormation", _letter, _letterType, _markerName);

        private _markerHigherFormation = createMarkerLocal [_markerName, _pos];
        _markerHigherFormation setMarkerTypeLocal _letterType;
        _markerHigherFormation setMarkerSizeLocal [_scale, _scale];
        _markerHigherFormation setMarkerAlphaLocal _alpha;

        _markerFamily pushBack _markerHigherFormation;
    } forEach _higherFormation;
};

if (_operationalCondition > 0) then {
    private _opCondAmplifier = "mts_com_opcond";
    if (_operationalCondition isEqualTo OC_DAMAGED) then {
        _opCondAmplifier = _opCondAmplifier + "_damaged";
    };
    if (_operationalCondition isEqualTo OC_DESTROYED) then {
        _opCondAmplifier = _opCondAmplifier + "_destroyed";
    };

    private _markerOpCond = createMarkerLocal [format ["%1_opcond", _namePrefix], _pos];
    _markerOpCond setMarkerTypeLocal _opCondAmplifier;
    _markerOpCond setMarkerSizeLocal [_scale, _scale];
    _markerOpCond setMarkerAlphaLocal _alpha;

    _markerFamily pushBack _markerOpCond;
};

GVAR(localMarkers) set [_namePrefix, CBA_missionTime, true];

private _markerInformation = GVAR(namespace) getVariable [_namePrefix, []];
if (_markerInformation isEqualTo []) then { //save in mts_markers_namespace
    //save inmutable variables of marker
    GVAR(namespace) setVariable [_namePrefix, [_markerFamily, _markerParameter, _broadcastChannel], true];

    if (is3DEN) then {
        //save 3DEN marker data in a hidden attribute
        private _3denData = "Scenario" get3DENMissionAttribute QGVAR(3denData);
        _3denData pushbackUnique _this;
        set3DENMissionAttributes [["Scenario", QGVAR(3denData), _3denData]];
    };
};

_namePrefix
