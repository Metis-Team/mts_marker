#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Sets the Land Unit dimension specific marker paramaters in the UI.
 *      This function is dimension specific and implements the "uiSetData" hook.
 *
 *  Parameter(s):
 *      0: CONTROL - Marker configuration control group.
 *      1: ARRAY - Same marker configuration as in createDimensionMarker.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_cfgCtrlGrp, _markerParameter] call mts_markers_fnc_setUIData
 *
 */

params [["_cfgCtrlGrp", controlNull, [controlNull]], ["_markerParameter", [], [[]]]];

_markerParameter params [
    ["_frameshape", ["", false, false], [[]]],
    ["_modifier", [0, 0, 0], [[]], 3],
    ["_size", [0, false, false], [[]], 3],
    ["_uniqueDesignation", [], [[]]],
    ["_additionalInfo", "", [""]],
    ["_higherFormation", [], [[]]],
    ["_operationalCondition", 0, [0]],
    ["_dateTimeGroup", [], [[]]],
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

private _ctrlArray = [
    [(_cfgCtrlGrp controlsGroupCtrl ICON_DROPDOWN), GVAR(iconArray)],
    [(_cfgCtrlGrp controlsGroupCtrl MOD1_DROPDOWN), GVAR(mod1Array)],
    [(_cfgCtrlGrp controlsGroupCtrl MOD2_DROPDOWN), GVAR(mod2Array)]
];

// Because of the sorting, the index needs to be found with the help of the value
{
    _x params ["_ctrl", "_dropdownArray"];

    for "_index" from 0 to ((count _dropdownArray) -1) step 1 do {
        private _lbValue = _ctrl lbValue _index;
        if (_lbValue isEqualTo (_modifier select _forEachIndex)) exitWith {
            _ctrl lbSetCurSel _index;
        };
    };
} forEach _ctrlArray;

(_cfgCtrlGrp controlsGroupCtrl ECHELON_DROPDOWN) lbSetCurSel _grpsize;
(_cfgCtrlGrp controlsGroupCtrl REINFORCED_CHECKBOX) cbSetChecked _reinforced;
(_cfgCtrlGrp controlsGroupCtrl REDUCED_CHECKBOX) cbSetChecked _reduced;

(_cfgCtrlGrp controlsGroupCtrl UNIQUE_EDIT) ctrlSetText (_uniqueDesignation joinString "");
(_cfgCtrlGrp controlsGroupCtrl HIGHER_EDIT) ctrlSetText (_higherFormation joinString "");
(_cfgCtrlGrp controlsGroupCtrl ADDITIONAL_EDIT) ctrlSetText _additionalInfo;

(_cfgCtrlGrp controlsGroupCtrl HQ_CHECKBOX) cbSetChecked _isHq;

private _directionIndex = (GVAR(directions) findIf {_x isEqualTo _direction}) + 1; // +1 because no direction is 0
(_cfgCtrlGrp controlsGroupCtrl DIRECTION_DROPDOWN) lbSetCurSel _directionIndex;

switch (_operationalCondition) do {
    case OC_DAMAGED: {
        (_cfgCtrlGrp controlsGroupCtrl DAMAGED_CHECKBOX) cbSetChecked true;
        (_cfgCtrlGrp controlsGroupCtrl DESTROYED_CHECKBOX) cbSetChecked false;
    };
    case OC_DESTROYED: {
        (_cfgCtrlGrp controlsGroupCtrl DAMAGED_CHECKBOX) cbSetChecked false;
        (_cfgCtrlGrp controlsGroupCtrl DESTROYED_CHECKBOX) cbSetChecked true;
    };
    default {
        (_cfgCtrlGrp controlsGroupCtrl DAMAGED_CHECKBOX) cbSetChecked false;
        (_cfgCtrlGrp controlsGroupCtrl DESTROYED_CHECKBOX) cbSetChecked false;
    };
};

[_dateTimeGroup] call FUNC(saveAndDisplayDTG);

// Select right identity in the dialog
(_cfgCtrlGrp controlsGroupCtrl SUSPECT_CHECKBOX) cbSetChecked _dashedFrameshape;
[_cfgCtrlGrp, _identity] call FUNC(setIdentity);
