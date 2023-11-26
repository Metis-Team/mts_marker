#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds the right picture to the different preview picture layers for comboboxes.
 *
 *  Parameter(s):
 *      0: ARRAY - Frameshape.
 *          0: STRING - Identity (blu, red, neu, unk).
 *          1: BOOLEAN - Dashed (e.g. supect).
 *      1: ARRAY - Composition of modifier for the marker. (Optional, default: no modifiers)
 *          0: NUMBER - Icon (0 for none).
 *          1: NUMBER - Modifier 1 (0 for none).
 *          2: NUMBER - Modifier 2 (0 for none).
 *      2: ARRAY - Group size array. (Optional, default: no echelon)
 *          0: NUMBER - Group size (0 for none).
 *          1: BOOLEAN - Reinforced or (+) symbol.
 *          2: BOOLEAN - Reduced or (-) symbol (if both are true it will show (±)).
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [["blu", false], [4,0,0], [5, false, true]] call mts_markers_fnc_setMarkerPreview
 *
 */

params [
    ["_frameshape", ["",false], [[]]],
    ["_modifier", [0,0,0], [[]], 3],
    ["_size", [0,false,false], [[]], 3],
    "",
    "",
    "",
    ["_operationalCondition", OC_FULLY_CAPABLE, [0]]
];
_frameshape params [
    ["_identity", "", [""]],
    ["_dashedFrameshape", false, [false]]
];
_size params [
    ["_grpsize", 0, [0]],
    ["_reinforced", false, [false]],
    ["_reduced", false, [false]]
];

CHECKRET(_identity isEqualTo "", ERROR("No identity"));

private _mainDisplay = findDisplay MAIN_DISPLAY;
private _previewIdentityCtrl = _mainDisplay displayCtrl PREVIEW_LYR_IDENTITY;
private _previewMod1Ctrl = _mainDisplay displayCtrl PREVIEW_LYR_MOD_1;
private _previewMod2Ctrl = _mainDisplay displayCtrl PREVIEW_LYR_MOD_2;
private _previewMod3Ctrl = _mainDisplay displayCtrl PREVIEW_LYR_MOD_3;
private _previewMod4Ctrl = _mainDisplay displayCtrl PREVIEW_LYR_MOD_4;
private _previewEchelonCtrl = _mainDisplay displayCtrl PREVIEW_LYR_ECHELON;
private _previewSizeModCtrl = _mainDisplay displayCtrl PREVIEW_LYR_SIZE_MOD;
private _previewOpCondCtrl = _mainDisplay displayCtrl PREVIEW_LYR_OPERATIONAL_CONDITION;

//clear all layers
{
    _x ctrlSetText "";
} count [
    _previewIdentityCtrl,
    _previewMod1Ctrl,
    _previewMod2Ctrl,
    _previewMod3Ctrl,
    _previewMod4Ctrl,
    _previewEchelonCtrl,
    _previewSizeModCtrl,
    _previewOpCondCtrl
];

private _identityComplete = if (_dashedFrameshape) then {
    format ["%1dash", _identity]
} else {
    _identity
};

//set selected identity to corresponding layer
_previewIdentityCtrl ctrlSetText (format [QPATHTOF(data\%1\mts_markers_%2_frameshape_preview.paa), _identity, _identityComplete]);

//set all modifiers to corresponding layer
private _allModifiers = _modifier call FUNC(getAllModifiers);
if (_allModifiers isNotEqualTo []) then {
    private _previewModCtrlArray = [_previewMod1Ctrl, _previewMod2Ctrl, _previewMod3Ctrl, _previewMod4Ctrl];
    for "_selectPos" from 0 to ((count _allModifiers) - 1) step 1 do {
        (_previewModCtrlArray select _selectPos) ctrlSetText (format [QPATHTOF(data\%1\mod\mts_markers_%1_mod_%2.paa), _identity, (_allModifiers select _selectPos)]);
    };
};

//set echelon to corresponding layer
if (_grpsize > 0) then {
    _previewEchelonCtrl ctrlSetText (format [QPATHTOF(data\%1\size\mts_markers_%1_size_%2.paa), _identity, _grpsize]);
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

    _previewSizeModCtrl ctrlSetText (format [QPATHTOF(data\com\size\%1.paa), _sizeModFilename]);
};

if (_operationalCondition > 0) then {
    private _opCondFilename = "mts_markers_com_opcond";
    if (_operationalCondition isEqualTo OC_DAMAGED) then {
        _opCondFilename = _opCondFilename + "_damaged";
    };
    if (_operationalCondition isEqualTo OC_DESTROYED) then {
        _opCondFilename = _opCondFilename + "_destroyed";
    };

    _previewOpCondCtrl ctrlSetText (format [QPATHTOF(data\com\opcond\%1.paa), _opCondFilename]);
};
