#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Returns the Date-Time Group from the UI.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      ARRAY - Date-Time information in format [[year, month, day, hours, minutes], timezone].
 *              The date elements are numbers; timeZone is a character.
 *
 *  Example:
 *      call mts_markers_fnc_getDTGUIData
 *
 */

private _dtgDisplay = findDisplay DTG_DISPLAY;

private _dateYearCtrl = _dtgDisplay displayCtrl DTG_YEAR_DROPDOWN;
private _dateMonthCtrl = _dtgDisplay displayCtrl DTG_MONTH_DROPDOWN;
private _dateDayCtrl = _dtgDisplay displayCtrl DTG_DAY_DROPDOWN;
private _timeZoneCtrl = _dtgDisplay displayCtrl DTG_TIMEZONE_DROPDOWN;

private _year = _dateYearCtrl lbValue (lbCurSel _dateYearCtrl);
private _month = _dateMonthCtrl lbValue (lbCurSel _dateMonthCtrl);
private _day = _dateDayCtrl lbValue (lbCurSel _dateDayCtrl);

private _hours = parseNumber (ctrlText (_dtgDisplay displayCtrl DTG_HOURS_EDIT));
private _minutes = parseNumber (ctrlText (_dtgDisplay displayCtrl DTG_MINUTES_EDIT));

private _timeZone = _timeZoneCtrl lbValue (lbCurSel _timeZoneCtrl);

[[_year, _month, _day, _hours, _minutes], _timeZone]
