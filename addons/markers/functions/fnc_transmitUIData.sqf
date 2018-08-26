#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Gets the selected data from the UI and transfers it to fnc_createMarker.sqf.
 *      Or if boolean is false then it transfers the data to fnc_setMarkerPreview.sqf.
 *
 *  Parameter(s):
 *      0: BOOLEAN - Is for marker creation or for preview (true for creation).
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [true] call mts_markers_fnc_transmitUIData
 *
 */

params [["_isForMarkerCreation", true, [true]]];

private _mainDisplay = findDisplay MAIN_DISPLAY;

//get frameshape
private _frameshape = (_mainDisplay displayctrl FRIENDLY_BTN_FRAME) getVariable [QGVAR(currentIdentitySelected), ""];
CHECKRET(_frameshape isEqualTo "", ERROR("No frameshape"));

//check if frameshape is dashed
private _suspectedCbValue = cbChecked (_mainDisplay displayCtrl MOD_CHECKBOX);
if (_suspectedCbValue) then {
    _frameshape = format ["%1dash", _frameshape];
};

private _iconCtrl = _mainDisplay displayCtrl ICON_DROPDOWN;
private _mod1Ctrl = _mainDisplay displayCtrl MOD1_DROPDOWN;
private _mod2Ctrl = _mainDisplay displayCtrl MOD2_DROPDOWN;

//get values
private _lbIconValue = _iconCtrl lbValue (lbCurSel _iconCtrl);
private _lbMod1Value = _mod1Ctrl lbValue (lbCurSel _mod1Ctrl);
private _lbMod2Value = _mod2Ctrl lbValue (lbCurSel _mod2Ctrl);

//get all modifer
private _modifier = [_lbIconValue, _lbMod1Value, _lbMod2Value];

//get group size
private _grpsize = lbCurSel (_mainDisplay displayCtrl ECHELON_DROPDOWN);

//get echelon modifier values
private _reinforced = cbChecked (_mainDisplay displayCtrl REINFORCED_CHECKBOX);
private _reduced = cbChecked (_mainDisplay displayCtrl REDUCED_CHECKBOX);

//chose where the data will be transmited
scopeName "main";
if (_isForMarkerCreation) then {
    private ["_broadcastChannel"];

    //get the text that will be to the right of the marker
    private _textright = ctrlText (_mainDisplay displayCtrl HIGHER_EDIT);

    //get the left text and check if it is valid
    private _textleft = (toUpper (ctrlText (_mainDisplay displayCtrl UNIQUE_EDIT))) splitString "";
    private _textleftCharacters = count _textleft;
    if (_textleftCharacters > 3) then {
        //don't allow more than 3 characters
        hint LLSTRING(ui_hint_character_limit);
        breakOut "main";
    };
    private _validCharacters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","0","1","2","3","4","5","6","7","8","9"];
    {
        if !(_x in _validCharacters) then {
            //only allow valid characters that are in the array
            hint LLSTRING(ui_hint_character_invalid);
            breakOut "main";
        };
    } count _textleft;

    private _okBtnCtrl = _mainDisplay displayctrl OK_BUTTON;
    private _pos = _okBtnCtrl getVariable [QGVAR(createMarkerMousePosition), [0,0]];

    call {
        if (is3DEN) exitWith {
            _broadcastChannel = 0;
        };
        if !(isMultiplayer) exitWith {
            _broadcastChannel = currentChannel;
        };
        private _channelCtrl = _mainDisplay displayCtrl CHANNEL_DROPDOWN;
        _broadcastChannel = _channelCtrl lbValue (lbCurSel _channelCtrl);
    };
    setCurrentChannel _broadcastChannel;

    //check if marker is being editing, if so delete old marker and create new one
    private _editMarkerNamePrefix = _okBtnCtrl getVariable [QGVAR(editMarkerNamePrefix), ""];
    if !(_editMarkerNamePrefix isEqualTo "") then {
        [_editMarkerNamePrefix] call FUNC(deleteMarker);
    };

    [_pos, _broadcastChannel, !is3DEN, _frameshape, _modifier, [_grpsize, _reinforced, _reduced], _textleft, _textright, MARKER_SCALE] call FUNC(createMarker);
    _mainDisplay closeDisplay 1;
} else {
    [_frameshape, _modifier, [_grpsize, _reinforced, _reduced]] call FUNC(setMarkerPreview);
};
