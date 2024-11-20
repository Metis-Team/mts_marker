#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Creates and initializes the Land Unit dimension specific marker configuration UI elements.
 *      This function is dimension specific and implements the "uiCreate" hook.
 *
 *  Parameter(s):
 *      0: CONTROL - Parent control group where the configuration control should be created in.
 *
 *  Returns:
 *      CONTROL - Created Land Unit dimension specific UI control group for the marker configuration.
 *
 *  Example:
 *      [_cfgCtrlGrp] call mts_markers_fnc_createConfigurationUI
 *
 */

params [["_parentCtrlGrp", controlNull, [controlNull]]];

private _mainDisplay = ctrlParent _parentCtrlGrp;
private _cfgCtrlGrp = _mainDisplay ctrlCreate [QGVAR(RscConfiguration), -1, _parentCtrlGrp];
_cfgCtrlGrp ctrlSetPosition (ctrlPosition _parentCtrlGrp);
_cfgCtrlGrp ctrlCommit 0;

// Create identity button group
private _identities = [
    ["blu", QPATHTOF(data\ui\mts_markers_ui_blu_frameshape.paa), LLSTRING(ui_identity_friend), LLSTRING(ui_identity_assumed_friend)],
    ["red", QPATHTOF(data\ui\mts_markers_ui_red_frameshape.paa), LLSTRING(ui_identity_hostile), LLSTRING(ui_identity_suspect)],
    ["neu", QPATHTOF(data\ui\mts_markers_ui_neu_frameshape.paa), LLSTRING(ui_identity_neutral)],
    ["unk", QPATHTOF(data\ui\mts_markers_ui_unk_frameshape.paa), LLSTRING(ui_identity_unknown), LLSTRING(ui_identity_pending)]
];
private _identityBtnCtrlGrp = [_cfgCtrlGrp, _identities] call FUNC(createIdentityButtons);

// set default identity
[_cfgCtrlGrp] call FUNC(setIdentity);

private _identity = _cfgCtrlGrp getVariable [QGVAR(currentIdentitySelected), ""];
TRACE_1("Default identity",_identity);

//combobox controls
private _iconCtrl = _cfgCtrlGrp controlsGroupCtrl ICON_DROPDOWN;
private _mod1Ctrl = _cfgCtrlGrp controlsGroupCtrl MOD1_DROPDOWN;
private _mod2Ctrl = _cfgCtrlGrp controlsGroupCtrl MOD2_DROPDOWN;
private _echelonCtrl = _cfgCtrlGrp controlsGroupCtrl ECHELON_DROPDOWN;

private _ctrlArray = [
    [_iconCtrl, GVAR(iconArray), "icon"],
    [_mod1Ctrl, GVAR(mod1Array), "mod1"],
    [_mod2Ctrl, GVAR(mod2Array), "mod2"],
    [_echelonCtrl, GVAR(echelonArray), "echelon"]
];

//fill the icon, mod1, mod2 and echelon comboboxes
{
    _x params ["_ctrl", "_dropdownArray", "_arrayPathPrefix"];

    {
        _x params ["_selectionTextSuffix"];

        private _selectionText = format [LSTRING(ui_%1_%2), _arrayPathPrefix, _selectionTextSuffix];
        private _index = _ctrl lbAdd (localize _selectionText);
        _ctrl lbSetValue [_index, _index];

        private _selectionPicturePath = format [QPATHTOF(data\ui\%1\mts_markers_ui_%1_%2.paa), _arrayPathPrefix, _selectionTextSuffix];
        _ctrl lbSetPicture [_index, _selectionPicturePath];
    } count _dropdownArray;

    //sort icon, mod1 and mod2 dropdowns alphabetically
    if (_ctrl isNotEqualTo _echelonCtrl) then {
        lbSort _ctrl;
    };
    _ctrl lbSetCurSel 0;
} forEach _ctrlArray;

// Direction of Movement
private _directionCtrl = _cfgCtrlGrp controlsGroupCtrl DIRECTION_DROPDOWN;
private _directionIndex = _directionCtrl lbAdd LLSTRING(ui_direction_empty);
_directionCtrl lbSetPicture [_directionIndex, "#(argb,8,8,3)color(0,0,0,0)"];

{
    _x params ["_dir", "_dirShort"];

    private _index = _directionCtrl lbAdd (localize _dir);
    private _picturePath = format [QPATHTOF(data\ui\dir\mts_markers_ui_dir_%1.paa), GVAR(directions) select _forEachIndex];
    _directionCtrl lbSetPicture [_index, _picturePath];

    // Set transparent picture to the right this will be the padding right for the text right
    _directionCtrl lbSetPictureRight [_index, "#(argb,8,8,3)color(0,0,0,0)"];
    _directionCtrl lbSetTextRight [_index, localize _dirShort];
} forEach GVAR(directionLocalization);
_directionCtrl lbSetCurSel 0;

private _reinforcedCbCtrl = _cfgCtrlGrp controlsGroupCtrl REINFORCED_CHECKBOX;
private _reducedCbCtrl = _cfgCtrlGrp controlsGroupCtrl REDUCED_CHECKBOX;
private _hqCbCtrl = _cfgCtrlGrp controlsGroupCtrl HQ_CHECKBOX;

// Operational Condition
private _damagedCbCtrl = _cfgCtrlGrp controlsGroupCtrl DAMAGED_CHECKBOX;
private _destroyedCbCtrl = _cfgCtrlGrp controlsGroupCtrl DESTROYED_CHECKBOX;

//add EH for marker preview updating
{
    _x ctrlAddEventHandler ["LBSelChanged", {[ctrlParentControlsGroup (_this select 0)] call FUNC(updateMarkerPreview)}];
} forEach [
    _iconCtrl,
    _mod1Ctrl,
    _mod2Ctrl,
    _echelonCtrl,
    _directionCtrl
];

{
    _x ctrlAddEventHandler ["CheckedChanged", {[ctrlParentControlsGroup (_this select 0)] call FUNC(updateMarkerPreview)}];
} forEach [
    _reinforcedCbCtrl,
    _reducedCbCtrl,
    _hqCbCtrl,
    _damagedCbCtrl,
    _destroyedCbCtrl
];

{
    _x ctrlAddEventHandler ["CheckedChanged", LINKFUNC(onOperationalConditionChanged)];
} forEach [
    _damagedCbCtrl,
    _destroyedCbCtrl
];

_cfgCtrlGrp
