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

#define DIMENSIONS_W (MAX_W - PREVIEW_W - PADDING)
#define DIMENSIONS_H 1

#define DIMENSION_BUTTON_W 8
#define DIMENSION_BUTTON_H 1

#define CONFIG_W (MAX_W - PREVIEW_W - PADDING)
#define CONFIG_H (MAX_H - HEADER_H - DIMENSIONS_H - WIDE_BUTTON_H - 2 * PADDING)

#define FRAME_BUTTON_W 2
#define FRAME_BUTTON_H 2

#define FRAME_BUTTONS_GROUP_W (4 * FRAME_BUTTON_W + 5 * PADDING)
#define FRAME_BUTTONS_GROUP_H (FRAME_BUTTON_H + 2 * PADDING)

#define PREVIEW_GRID_W 9
#define PREVIEW_GRID_H 9

#define PREVIEW_LAYER_W (2.5 * PREVIEW_GRID_W)
#define PREVIEW_LAYER_H (2.5 * PREVIEW_GRID_H)

// Date Time Group Dialog
#define DTG_PADDING (5 * PADDING)
#define DTG_HEADER_H 1

#define DTG_W 30
#define DTG_H 7

#define DTG_TEXT_W 5
#define DTG_TIME_FRAME_W 4
#define DTG_DATE_COMBO_W 7
#define DTG_TIMEZONE_COMBO_W 8
#define DTG_SLIDER_W (3 * DTG_DATE_COMBO_W - DTG_TIME_FRAME_W - DTG_TIMEZONE_COMBO_W)
#define DTG_BUTTON_W ((3 * DTG_DATE_COMBO_W - 2 * PADDING) / 3)
