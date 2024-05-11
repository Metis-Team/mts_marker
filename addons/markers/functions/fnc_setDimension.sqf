#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Changes the marker configuration control to the dimension specific one.
 *
 *  Parameter(s):
 *      0: STRING - Dimension identifier.
 *
 *  Returns:
 *      CONTROL - Active marker configuration control group.
 *
 *  Example:
 *      _cfgCtrlGrp = ["land_unit"] call mts_markers_fnc_setDimension
 *
 */

params [["_dimension", "", [""]]];

CHECK(_dimension isEqualTo "");
CHECKRET(!(_dimension in GVAR(dimensions)),ERROR_1("Dimension %1 is not available.",_dimension));
// CHECK(_dimension isEqualTo GVAR(currentDimension));

private _mainDisplay = findDisplay MAIN_DISPLAY;

private _dimensionBtnCtrlGrp = _mainDisplay displayCtrl DIMENSIONS_BUTTON_GROUP;
private _btnCtrls = _dimensionBtnCtrlGrp getVariable [QGVAR(btnCtrls), []]; // Same length and order as GVAR(dimensionKeysSorted)

private _dimensionCfgCtrlGrp = _mainDisplay displayCtrl CONFIG_DIMENSION_GROUP;
private _cfgCtrlGrps = _dimensionCfgCtrlGrp getVariable [QGVAR(cfgCtrlGrps), []]; // Same length and order as GVAR(dimensionKeysSorted)

private _cfgCtrlGrp = controlNull;
{
    // Toggle "focus" on button of selected dimension
    private _isActiveDimension = _x isEqualTo _dimension;
    private _btnCtrl = _btnCtrls select _forEachIndex;
    if (_isActiveDimension) then {
        _btnCtrl ctrlSetTextColor COLOR_BUTTON_DISABLED;
        _btnCtrl ctrlSetBackgroundColor COLOR_BUTTON_ENABLED;
    } else {
        _btnCtrl ctrlSetTextColor COLOR_BUTTON_ENABLED;
        _btnCtrl ctrlSetBackgroundColor COLOR_BUTTON_DISABLED;
    };

    // Toggle configuration controls
    private _cfgCtrl = _cfgCtrlGrps select _forEachIndex;
    // Use alternative way of hiding a control.
    // Using ctrlShow also effects the visiblity of child controls (see BI wiki).
    if (_isActiveDimension) then {
        _cfgCtrl ctrlSetPosition (ctrlPosition _dimensionCfgCtrlGrp);
    } else {
        _cfgCtrl ctrlSetPosition [0, 0, 0, 0];
    };
    _cfgCtrl ctrlCommit 0;


    // Find the configuration control of the dimension
    if (_isActiveDimension) then {
        _cfgCtrlGrp = _cfgCtrl;
    };
} forEach GVAR(dimensionKeysSorted);

_dimensionCfgCtrlGrp setVariable [QGVAR(currentCfgCtrlGrp), _cfgCtrlGrp];
GVAR(currentDimension) = _dimension;

_cfgCtrlGrp
