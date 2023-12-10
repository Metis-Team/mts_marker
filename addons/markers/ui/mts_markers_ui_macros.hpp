// Style
#define BG_COLOR 0,0,0,0.7

// Sizes
#define MAX_W 40
#define MAX_H 25

#define PADDING 0.1

#define WIDE_BUTTON_W 5
#define WIDE_BUTTON_H 1

#define SMALL_BUTTON_W 1
#define SMALL_BUTTON_H 1

#define HEADER_W MAX_W
#define HEADER_H 1

#define PREVIEW_W (2 * WIDE_BUTTON_W + 2 * PADDING + SMALL_BUTTON_W)
#define PREVIEW_H PREVIEW_W

#define PRESETS_W PREVIEW_W
#define PRESETS_H (MAX_H - HEADER_H - PREVIEW_H - 2 * PADDING)

#define CONFIG_W (MAX_W - PREVIEW_W - PADDING)
#define CONFIG_H (MAX_H - HEADER_H - WIDE_BUTTON_H - 2 * PADDING)

#define FRAME_BUTTON_W 2
#define FRAME_BUTTON_H 2

#define FRAME_BUTTONS_GROUP_W (4 * FRAME_BUTTON_W + 5 * PADDING)
#define FRAME_BUTTONS_GROUP_H FRAME_BUTTON_H

#define PREVIEW_GRID_W 9
#define PREVIEW_GRID_H 9

#define PREVIEW_LAYER_W (2.5 * PREVIEW_GRID_W)
#define PREVIEW_LAYER_H (2.5 * PREVIEW_GRID_H)

// Date Time Group Dialog
#define DTG_PADDING (5 * PADDING)
#define DTG_HEADER_H 1

#define DTG_W 30
#define DTG_H 6

#define DTG_TEXT_W 5
#define DTG_TIME_FRAME_W 4
#define DTG_DATE_COMBO_W 7
#define DTG_TIMEZONE_COMBO_W 8
#define DTG_SLIDER_W (3 * DTG_DATE_COMBO_W - DTG_TIME_FRAME_W - DTG_TIMEZONE_COMBO_W)
#define DTG_BUTTON_W ((3 * DTG_DATE_COMBO_W - 2 * PADDING) / 3)

// IDCs
// Main display
#define MAIN_DISPLAY 5000
#define DTG_DISPLAY 5001

// Control Groups
#define CONFIG_GROUP 50
#define PREVIEW_GROUP 51
#define PRESETS_GROUP 52
#define IDENTITY_BUTTON_GROUP 53

// Backgrounds
#define HEAD_BG 100
#define CONFIG_BG 101
#define FRAME_BG 102
#define PREVIEW_BG 103
#define PRESETS_BG 104
#define DELETE_PRESETS_BG 105

// Text
#define HEAD_TXT 200
#define IDENTITY_TXT 202
#define ICON_TXT 203
#define SUSPECT_TXT 204
#define MOD1_TXT 205
#define MOD2_TXT 206
#define ECHELON_TXT 207
#define REINFORCED_TXT 208
#define REDUCED_TXT 209
#define HIGHER_TXT 210
#define UNIQUE_TXT 211
#define CHANNEL_TXT 212
#define PRESETS_NAME_TXT 213
#define ADDITIONAL_TXT 214
#define ALPHA_TXT 215
#define SCALE_TXT 216
#define HQ_TXT 217
#define DAMAGED_TXT 218
#define DESTROYED_TXT 219
#define DTG_TXT 220
#define DIRECTION_TXT 221

// Identity Buttons
#define FRIENDLY_BTN_FRAME 300
#define FRIENDLY_BTN_ICON 301
#define FRIENDLY_BTN_CTRL 302

#define HOSTILE_BTN_FRAME 310
#define HOSTILE_BTN_ICON 311
#define HOSTILE_BTN_CTRL 312

#define NEUTRAL_BTN_FRAME 320
#define NEUTRAL_BTN_ICON 321
#define NEUTRAL_BTN_CTRL 322

#define UNKNOWN_BTN_FRAME 330
#define UNKNOWN_BTN_ICON 331
#define UNKNOWN_BTN_CTRL 332

// Checkboxes
#define SUSPECT_CHECKBOX 400
#define REINFORCED_CHECKBOX 401
#define REDUCED_CHECKBOX 402
#define HQ_CHECKBOX 403
#define DAMAGED_CHECKBOX 404
#define DESTROYED_CHECKBOX 405

// Dropdowns
#define ICON_DROPDOWN 500
#define MOD1_DROPDOWN 501
#define MOD2_DROPDOWN 502
#define ECHELON_DROPDOWN 503
#define CHANNEL_DROPDOWN 504
#define DIRECTION_DROPDOWN 505

// Edit Boxes
#define HIGHER_EDIT 600
#define UNIQUE_EDIT 601
#define SEARCH_PRESETS_EDIT 602
#define NAME_PRESETS_EDIT 603
#define ADDITIONAL_EDIT 604

// Buttons
#define OK_BUTTON 700
#define CANCEL_BUTTON 701
#define TOGGLE_PRESETS_BUTTON 703
#define SAVE_PRESETS_BUTTON 704
#define LOAD_PRESETS_BUTTON 705
#define SEARCH_PRESETS_BUTTON 706
#define CLEAR_PRESETS_BUTTON 707
#define DELETE_PRESETS_BUTTON 708
#define DTG_BUTTON 709
#define CLEAR_DTG_BUTTON 710

// Preview Layers
#define PREVIEW_LYR_IDENTITY 800
#define PREVIEW_LYR_MOD_1 801
#define PREVIEW_LYR_MOD_2 802
#define PREVIEW_LYR_MOD_3 803
#define PREVIEW_LYR_MOD_4 804
#define PREVIEW_LYR_ECHELON 805
#define PREVIEW_LYR_SIZE_MOD 806
#define PREVIEW_GRID 807
#define PREVIEW_LYR_HQ 808
#define PREVIEW_LYR_OPERATIONAL_CONDITION 809
#define PREVIEW_LYR_DIRECTION 810

// Icons
#define DELETE_PRESETS_ICON 900

// List Boxes
#define PRESETS_LIST 1000

// Slider
#define ALPHA_SLIDER 1100
#define SCALE_SLIDER 1101

// ------------------------------
// ---- Date-Time Group IDCs ----
// ------------------------------
// Control Groups
#define DTG_GROUP 50

// Backgrounds
#define DTG_HEAD_BG 100
#define DTG_BG 101
#define DTG_TIME_FRAME 102

// Text
#define DTG_HEAD_TXT 200
#define DTG_DATE_TXT 201
#define DTG_TIME_TXT 202
#define DTG_TIME_SEPARATOR 203

// Dropdowns
#define DTG_YEAR_DROPDOWN 500
#define DTG_MONTH_DROPDOWN 501
#define DTG_DAY_DROPDOWN 502
#define DTG_TIMEZONE_DROPDOWN 503

// Edit Boxes
#define DTG_HOURS_EDIT 600
#define DTG_MINUTES_EDIT 601

// Buttons
#define DTG_OK_BUTTON 700
#define DTG_CANCEL_BUTTON 701
#define DTG_LOCALTIME_BUTTON 702
#define DTG_SYSTEMTIME_BUTTON 703
#define DTG_SYSTEMUTCTIME_BUTTON 704

// Slider
#define DTG_TIME_SLIDER 1100
