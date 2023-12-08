#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Updates the Date-Time Group days dropdown to only include valid days.
 *      Triggered when selecting a month in the dropdown.
 *
 *  Parameter(s):
 *      0: CONTROL - Month dropdown.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      _this call mts_markers_fnc_onDTGMonthSelChanged
 *
 */

params ["_dateMonthCtrl"];

private _dtgDisplay = ctrlParent _dateMonthCtrl;
private _dateYearCtrl = _dtgDisplay displayCtrl DTG_YEAR_DROPDOWN;
private _dateDayCtrl = _dtgDisplay displayCtrl DTG_DAY_DROPDOWN;

private _year = _dateYearCtrl lbValue (lbCurSel _dateYearCtrl);
private _month = _dateMonthCtrl lbValue (lbCurSel _dateMonthCtrl);

private _daysInMonth = [_year, _month] call BIS_fnc_monthDays;

// Save selected day
private _curSelDay = lbCurSel _dateDayCtrl;

// Fill dropdown with valid days
lbClear _dateDayCtrl;
for "_day" from 1 to _daysInMonth do {
    private _index = _dateDayCtrl lbAdd (str _day);
    _dateDayCtrl lbSetValue [_index, _day];
};

// Select the previous selected day again if available
_dateDayCtrl lbSetCurSel (_curSelDay min (lbSize _dateDayCtrl - 1))
