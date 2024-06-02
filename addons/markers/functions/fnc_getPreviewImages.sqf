#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Returns all images which should be displayed in the preview for a Land Unit dimension specific marker.
 *      This function is dimension specific and implements the "uiGetPreviewImages" hook.
 *
 *  Parameter(s):
 *      Same dimension specific marker configuration as in createDimensionMarker.
 *
 *  Returns:
 *      ARRAY - List of images in order of drawing height (first element = first to draw or furthest back).
 *
 *  Example:
 *      _markerParameters call mts_markers_fnc_getPreviewImages
 *
 */

params [
    ["_frameshape", ["", false, false], [[]]],
    ["_modifier", [0, 0, 0], [[]], 3],
    ["_size", [0, false, false], [[]], 3],
    "", // unique designation (we do not display text marker in the preview, so ignore them)
    "", // additional information
    "", // higher formation
    ["_operationalCondition", OC_FULLY_CAPABLE, [0]],
    "", // Date-Time Group
    ["_direction", "", [""]]
];
_frameshape params [
    ["_identity", "", [""]],
    ["_dashedFrameshape", false, [false]],
    ["_isHq", false, [false]]
];
_size params [
    ["_grpsize", 0, [0]],
    ["_reinforced", false, [false]],
    ["_reduced", false, [false]]
];

CHECKRET(_identity isEqualTo "",ERROR("No identity."));

private _layers = [];

private _identityComplete = if (_dashedFrameshape) then {
    format ["%1dash", _identity]
} else {
    _identity
};

//set selected identity to corresponding layer
_layers pushBack (format [QPATHTOF(data\%1\mts_markers_%2_frameshape_preview.paa), _identity, _identityComplete]);

// This is adding standalone HQ picture.
// If direction is given, the HQ picture will be replaced by direction.
if (_direction isEqualTo "" && _isHq) then {
    _layers pushBack (format [QPATHTOF(data\%1\mts_markers_%1_hq.paa), _identity]);
};

// Set direction of movement arrow to corresponding layer
if (_direction isNotEqualTo "") then {
    if (_isHq) then {
        _layers pushBack (format [QPATHTOF(data\%1\dir\hq\mts_markers_%1_dir_hq_%2.paa), _identity, _direction]);
    } else {
        _layers pushBack (format [QPATHTOF(data\%1\dir\mts_markers_%1_dir_%2.paa), _identity, _direction]);
    };
};

//set all modifiers to corresponding layer
private _allModifiers = _modifier call FUNC(getAllModifiers);
{
    _layers pushBack (format [QPATHTOF(data\%1\mod\mts_markers_%1_mod_%2.paa), _identity, _x]);
} forEach _allModifiers;

//set echelon to corresponding layer
if (_grpsize > 0) then {
    _layers pushBack (format [QPATHTOF(data\%1\size\mts_markers_%1_size_%2.paa), _identity, _grpsize]);
};

//set echelon modifier to corresponding layer
if (_reinforced || _reduced) then {
    private _sizeModFilename = "mts_markers_com_size";
    if (_reinforced) then {
        _sizeModFilename = _sizeModFilename + "_reinforced";
    };
    if (_reduced) then {
        _sizeModFilename = _sizeModFilename + "_reduced";
    };

    _layers pushBack (format [QPATHTOF(data\com\size\%1.paa), _sizeModFilename]);
};

// Set operational condition to corresponding layer
if (_operationalCondition > 0) then {
    private _opCondFilename = "mts_markers_com_opcond";
    if (_operationalCondition isEqualTo OC_DAMAGED) then {
        _opCondFilename = _opCondFilename + "_damaged";
    };
    if (_operationalCondition isEqualTo OC_DESTROYED) then {
        _opCondFilename = _opCondFilename + "_destroyed";
    };

    _layers pushBack (format [QPATHTOF(data\com\opcond\%1.paa), _opCondFilename]);
};

// Return layers
_layers
