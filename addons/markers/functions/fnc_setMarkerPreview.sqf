#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds the right picture to the different preview picture layers for comboboxes.
 *
 *  Parameter(s):
 *      0: STRING - Frameshape/identity.
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
 *      ["blu", [4,0,0], [5, false, true]] call mts_markers_fnc_setMarkerPreview
 *
 */

params [
    ["_frameshape", "", [""]],
    ["_modifier", [0,0,0], [[]], 3],
    ["_size", [0,false,false], [[]], 3]
];
_size params [
    ["_grpsize", 0, [0]],
    ["_reinforced", false, [false]],
    ["_reduced", false, [false]]
];

CHECKRET(_frameshape isEqualTo "", ERROR("No frameshape"));

private _mainDisplay = findDisplay MAIN_DISPLAY;
private _previewIdentityCtrl = _mainDisplay displayCtrl PREVIEW_LYR_IDENTITY;
private _previewMod1Ctrl = _mainDisplay displayCtrl PREVIEW_LYR_MOD_1;
private _previewMod2Ctrl = _mainDisplay displayCtrl PREVIEW_LYR_MOD_2;
private _previewMod3Ctrl = _mainDisplay displayCtrl PREVIEW_LYR_MOD_3;
private _previewMod4Ctrl = _mainDisplay displayCtrl PREVIEW_LYR_MOD_4;
private _previewEchelonCtrl = _mainDisplay displayCtrl PREVIEW_LYR_ECHELON;
private _previewSizeModCtrl = _mainDisplay displayCtrl PREVIEW_LYR_SIZE_MOD;

//clear all layers
{
    _x ctrlSetText "";
} count [_previewIdentityCtrl, _previewMod1Ctrl, _previewMod2Ctrl, _previewMod3Ctrl, _previewMod4Ctrl, _previewEchelonCtrl, _previewSizeModCtrl];

private _framshapePrefix = _frameshape;
if (_frameshape isEqualTo "bludash") then {_framshapePrefix = "blu";};
if (_frameshape isEqualTo "reddash") then {_framshapePrefix = "red";};
if (_frameshape isEqualTo "unkdash") then {_framshapePrefix = "unk";};

//set selected identity to corresponding layer
_previewIdentityCtrl ctrlSetText (format [QPATHTOF(data\%1\mts_markers_%2_frameshape_preview.paa), _framshapePrefix, _frameshape]);

//set all modifiers to corresponding layer
private _allModifiers = _modifier call FUNC(getAllModifiers);
if !(_allModifiers isEqualTo []) then {
    private _previewModCtrlArray = [_previewMod1Ctrl, _previewMod2Ctrl, _previewMod3Ctrl, _previewMod4Ctrl];
    for "_selectPos" from 0 to ((count _allModifiers) - 1) step 1 do {
        (_previewModCtrlArray select _selectPos) ctrlSetText (format [QPATHTOF(data\%1\mod\mts_markers_%1_mod_%2.paa), _framshapePrefix, (_allModifiers select _selectPos)]);
    };
};

//set echelon to corresponding layer
if (_grpsize > 0) then {
    _previewEchelonCtrl ctrlSetText (format [QPATHTOF(data\%1\size\mts_markers_%1_size_%2.paa), _framshapePrefix, _grpsize]);
};

//set echelon modifier to corresponding layer
if ((_reinforced) && (!_reduced)) then {
    _previewSizeModCtrl ctrlSetText (format [QPATHTOF(data\%1\size\mts_markers_%1_size_reinforced.paa), _framshapePrefix]);
};
if ((_reduced) && (!_reinforced)) then {
    _previewSizeModCtrl ctrlSetText (format [QPATHTOF(data\%1\size\mts_markers_%1_size_reduced.paa), _framshapePrefix]);
};
if ((_reinforced) && (_reduced)) then {
    _previewSizeModCtrl ctrlSetText (format [QPATHTOF(data\%1\size\mts_markers_%1_size_reinforced_reduced.paa), _framshapePrefix]);
};
