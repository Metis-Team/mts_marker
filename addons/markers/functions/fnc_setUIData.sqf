#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Sets the core data for the UI.
 *
 *  Parameter(s):
 *      0: ARRAY - Frameshape.
 *      1: ARRAY - Modifer.
 *      2: ARRAY - Group size.
 *      3: ARRAY - Left text.
 *      4: STRING - Right text.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [["blu", false], [4,0,0], [4, false, true], ["3","3"], "9"] call mts_markers_fnc_setUIData
 *
 */

params [
    ["_frameshape", ["",false], [[]]],
    ["_modifier", [0,0,0], [[]], 3],
    ["_size", [0,false,false], [[]], 3],
    ["_uniqueDesignation", [], [[]]],
    ["_additionalInfo", "", [""]],
    ["_higherFormation", [], [[]]]
];
_frameshape params [["_identity", "", [""]], ["_dashedFrameshape", false, [false]]];
_size params [["_grpsize", 0, [0]], ["_reinforced", false, [false]], ["_reduced", false, [false]]];

private _mainDisplay = findDisplay MAIN_DISPLAY;

private _ctrlArray = [
    [(_mainDisplay displayCtrl ICON_DROPDOWN), GVAR(iconArray)],
    [(_mainDisplay displayCtrl MOD1_DROPDOWN), GVAR(mod1Array)],
    [(_mainDisplay displayCtrl MOD2_DROPDOWN), GVAR(mod2Array)]
];

//because of the sorting, the index needs to be found with the help of the value
{
    _x params ["_ctrl", "_dropdownArray"];

    for "_index" from 0 to ((count _dropdownArray) -1) step 1 do {
        private _lbValue = _ctrl lbValue _index;
        if (_lbValue isEqualTo (_modifier select _forEachIndex)) exitWith {
            _ctrl lbSetCurSel _index;
        };
    };
} forEach _ctrlArray;

(_mainDisplay displayCtrl ECHELON_DROPDOWN) lbSetCurSel _grpsize;
(_mainDisplay displayCtrl REINFORCED_CHECKBOX) cbSetChecked _reinforced;
(_mainDisplay displayCtrl REDUCED_CHECKBOX) cbSetChecked _reduced;

(_mainDisplay displayCtrl UNIQUE_EDIT) ctrlSetText (_uniqueDesignation joinString "");
(_mainDisplay displayCtrl HIGHER_EDIT) ctrlSetText (_higherFormation joinString "");
(_mainDisplay displayCtrl ADDITIONAL_EDIT) ctrlSetText _additionalInfo;

//select right identity in the dialog & update preview
(_mainDisplay displayCtrl SUSPECT_CHECKBOX) cbSetChecked _dashedFrameshape;
[_identity] call FUNC(identityButtonsAction);
