class RscText;
class RscPicture;
class RscButton;
class RscButtonMenu;
class RscButtonMenuOK;
class RscButtonMenuCancel;
class RscCheckBox;
class RscEdit;
class RscListBox;
class RscButtonSearch;
class RscControlsGroupNoScrollbars;
class RscTitle;
class RscFrame;
class RscXSliderH;
class RscCombo {
    class ComboScrollBar;
};

class GVAR(RscTransparentButton): RscButton {
    colorBackground[] = {0, 0, 0, 0};
    colorBackgroundActive[] = {0, 0, 0, 0};
    colorBackgroundDisabled[] = {0, 0, 0, 0};
    colorText[] = {0, 0, 0, 0};
    period = 0;
};

class GVAR(RscEdit): RscEdit {
    type = 2;
    style = ST_NO_RECT;
    colorBackground[] = {0, 0, 0, 1};
    sizeEx = QUOTE(POS_H(0.8));
    shadow = 0;
};

class GVAR(RscText): RscText {
    sizeEx = QUOTE(POS_H(0.9));
};

class GVAR(RscCheckBoxSound): RscCheckBox {
    soundEnter[] = {"\a3\ui_f\data\Sound\RscButtonMenu\soundEnter", 0.090000004, 1};
    soundPush[] = {"\a3\ui_f\data\Sound\RscButtonMenu\soundPush", 0.090000004, 1};
    soundClick[] = {"\a3\ui_f\data\Sound\RscButtonMenu\soundClick", 0.090000004, 1};
    soundEscape[] = {"\a3\ui_f\data\Sound\RscButtonMenu\soundEscape", 0.090000004, 1};
};

class GVAR(RscCombo): RscCombo {
    colorTextRight[] = {1, 1, 1, 0.5};

    arrowFull = "\a3\3DEN\Data\Controls\ctrlCombo\arrowFull_ca.paa";
    arrowEmpty = "\a3\3DEN\Data\Controls\ctrlCombo\arrowEmpty_ca.paa";

    class ComboScrollBar: ComboScrollBar {
        thumb = "\a3\3DEN\Data\Controls\ctrlDefault\thumb_ca.paa";
        border = "\a3\3DEN\Data\Controls\ctrlDefault\border_ca.paa";
        arrowFull = "\a3\3DEN\Data\Controls\ctrlDefault\arrowFull_ca.paa";
        arrowEmpty = "\a3\3DEN\Data\Controls\ctrlDefault\arrowEmpty_ca.paa";
    };
};

class GVAR(RscPreview): RscControlsGroupNoScrollbars {
    class controls {
        class Background: RscText {
            idc = PREVIEW_BG;
            x = QPOS_W(0);
            y = QPOS_H(0);
            w = QPOS_W(PREVIEW_W);
            h = QPOS_H(PREVIEW_H);
            colorBackground[] = {BG_COLOR};
        };

        class Grid: RscPicture {
            idc = PREVIEW_GRID;
            x = QPOS_W((PREVIEW_W - PREVIEW_GRID_W) / 2);
            y = QPOS_H((PREVIEW_H - PREVIEW_GRID_H) / 2);
            w = QPOS_W(PREVIEW_GRID_W);
            h = QPOS_H(PREVIEW_GRID_H);
            text = QPATHTOF(data\ui\mts_markers_ui_preview_background.paa);
        };

        class Identity: RscPicture {
            idc = PREVIEW_LYR_IDENTITY;
            x = QPOS_W((PREVIEW_W - PREVIEW_LAYER_W) / 2);
            y = QPOS_H((PREVIEW_H - PREVIEW_LAYER_H) / 2);
            w = QPOS_W(PREVIEW_LAYER_W);
            h = QPOS_H(PREVIEW_LAYER_H);
            text = "";
        };
        class HQ: Identity {
            idc = PREVIEW_LYR_HQ;
        };
        class Direction: Identity {
            idc = PREVIEW_LYR_DIRECTION;
        };
        class Mod1: Identity {
            idc = PREVIEW_LYR_MOD_1;
        };
        class Mod2: Identity {
            idc = PREVIEW_LYR_MOD_2;
        };
        class Mod3: Identity {
            idc = PREVIEW_LYR_MOD_3;
        };
        class Mod4: Identity {
            idc = PREVIEW_LYR_MOD_4;
        };
        class Echelon: Identity {
            idc = PREVIEW_LYR_ECHELON;
        };
        class Size: Identity {
            idc = PREVIEW_LYR_SIZE_MOD;
        };
        class OperationalCondition: Identity {
            idc = PREVIEW_LYR_OPERATIONAL_CONDITION;
        };
    };
};


class GVAR(RscConfiguration): RscControlsGroupNoScrollbars {
    class controls {
        class Background: RscText {
            idc = CONFIG_BG;
            x = QPOS_W(0);
            y = QPOS_H(0);
            w = QPOS_W(CONFIG_W);
            h = QPOS_H(CONFIG_H);
            colorBackground[] = {BG_COLOR};
        };

        class FrameBackground: RscPicture {
            idc = FRAME_BG;
            x = QPOS_W((CONFIG_W - 12) / 2);
            y = QPOS_H(4.1);
            w = QPOS_W(12);
            h = QPOS_H(12);
            text = QPATHTOF(data\ui\mts_markers_ui_frame_background.paa);
        };

        class IdentityText: GVAR(RscText) {
            idc = IDENTITY_TXT;
            x = QPOS_W(0.5);
            y = QPOS_H(0.5);
            w = QPOS_W(4);
            h = QPOS_H(FRAME_BUTTON_H);
            text = CSTRING(ui_general_identityTXT);
        };

        class ButtonGroup: RscControlsGroupNoScrollbars {
            idc = IDENTITY_BUTTON_GROUP;
            x = QPOS_W((CONFIG_W - FRAME_BUTTONS_GROUP_W) / 2);
            y = QPOS_H(0.5);
            w = QPOS_W(FRAME_BUTTONS_GROUP_W);
            h = QPOS_H(FRAME_BUTTONS_GROUP_H);

            class controls {
                class BluButtonFrame: RscPicture {
                    idc = FRIENDLY_BTN_FRAME;
                    x = QPOS_W(PADDING);
                    y = QPOS_H(PADDING);
                    w = QPOS_W(FRAME_BUTTON_W);
                    h = QPOS_H(FRAME_BUTTON_H);
                    style = ST_FRAME;
                    colorText[] = {1,1,1,1};
                };
                class BluButtonIcon: RscPicture {
                    idc = FRIENDLY_BTN_ICON;
                    x = QPOS_W(PADDING);
                    y = QPOS_H(PADDING);
                    w = QPOS_W(FRAME_BUTTON_W);
                    h = QPOS_H(FRAME_BUTTON_H);
                    text = QPATHTOF(data\ui\mts_markers_ui_blu_frameshape.paa);
                };
                class BluButton: GVAR(RscTransparentButton) {
                    idc = FRIENDLY_BTN_CTRL;
                    x = QPOS_W(PADDING);
                    y = QPOS_H(PADDING);
                    w = QPOS_W(FRAME_BUTTON_W);
                    h = QPOS_H(FRAME_BUTTON_H);
                    text = "";
                    tooltip = CSTRING(ui_identity_friend);
                    onButtonClick = QUOTE(['blu'] call FUNC(identityButtonsAction););
                };

                class RedButtonFrame: BluButtonFrame {
                    idc = HOSTILE_BTN_FRAME;
                    x = QPOS_W(FRAME_BUTTON_W + 2 * PADDING);
                };
                class RedButtonIcon: BluButtonIcon {
                    idc = HOSTILE_BTN_ICON;
                    x = QPOS_W(FRAME_BUTTON_W + 2 * PADDING);
                    text = QPATHTOF(data\ui\mts_markers_ui_red_frameshape.paa);
                };
                class RedButton: BluButton {
                    idc = HOSTILE_BTN_CTRL;
                    x = QPOS_W(FRAME_BUTTON_W + 2 * PADDING);
                    tooltip = CSTRING(ui_identity_hostile);
                    onButtonClick = QUOTE(['red'] call FUNC(identityButtonsAction););
                };

                class NeuButtonFrame: BluButtonFrame {
                    idc = NEUTRAL_BTN_FRAME;
                    x = QPOS_W(2 * FRAME_BUTTON_W + 3 * PADDING);
                };
                class NeuButtonIcon: BluButtonIcon {
                    idc = NEUTRAL_BTN_ICON;
                    x = QPOS_W(2 * FRAME_BUTTON_W + 3 * PADDING);
                    text = QPATHTOF(data\ui\mts_markers_ui_neu_frameshape.paa);
                };
                class NeuButton: BluButton {
                    idc = NEUTRAL_BTN_CTRL;
                    x = QPOS_W(2 * FRAME_BUTTON_W + 3 * PADDING);
                    tooltip = CSTRING(ui_identity_neutral);
                    onButtonClick = QUOTE(['neu'] call FUNC(identityButtonsAction););
                };

                class UnkButtonFrame: BluButtonFrame {
                    idc = UNKNOWN_BTN_FRAME;
                    x = QPOS_W(3 * FRAME_BUTTON_W + 4 * PADDING);
                };
                class UnkButtonIcon: BluButtonIcon {
                    idc = UNKNOWN_BTN_ICON;
                    x = QPOS_W(3 * FRAME_BUTTON_W + 4 * PADDING);
                    text = QPATHTOF(data\ui\mts_markers_ui_unk_frameshape.paa);
                };
                class UnkButton: BluButton {
                    idc = UNKNOWN_BTN_CTRL;
                    x = QPOS_W(3 * FRAME_BUTTON_W + 4 * PADDING);
                    tooltip = CSTRING(ui_identity_unknown);
                    onButtonClick = QUOTE(['unk'] call FUNC(identityButtonsAction););
                };
            };
        };

        class SuspectCheckbox: GVAR(RscCheckBoxSound) {
            idc = SUSPECT_CHECKBOX;
            x = QPOS_W(CONFIG_W - 7 - 1);
            y = QPOS_H(FRAME_BUTTON_H / 2);
            w = QPOS_W(1);
            h = QPOS_H(1);
        };
        class SuspectText: GVAR(RscText) {
            idc = SUSPECT_TXT;
            x = QPOS_W(CONFIG_W - 7);
            y = QPOS_H(FRAME_BUTTON_H / 2);
            w = QPOS_W(6.5);
            h = QPOS_H(1);
            text = "";
        };

        class EchelonText: GVAR(RscText) {
            idc = ECHELON_TXT;
            x = QPOS_W((CONFIG_W - 10) / 2);
            y = QPOS_H(4);
            w = QPOS_W(10);
            h = QPOS_H(1);
            text = CSTRING(ui_general_echelonTXT);
        };
        class EchelonCombo: GVAR(RscCombo) {
            idc = ECHELON_DROPDOWN;
            x = QPOS_W((CONFIG_W - 10) / 2);
            y = QPOS_H(5);
            w = QPOS_W(10);
            h = QPOS_H(1);
        };

        class DTGText: GVAR(RscText) {
            idc = DTG_TXT;
            x = QPOS_W(0.5);
            y = QPOS_H(4);
            w = QPOS_W(7.5);
            h = QPOS_H(1);
            text = CSTRING(ui_general_dtgTXT);
        };
        class DTGButton: RscButtonMenu {
            idc = DTG_BUTTON;
            x = QPOS_W(0.5);
            y = QPOS_H(5);
            w = QPOS_W(6.5);
            h = QPOS_H(1);
            text = "";
            tooltip = CSTRING(ui_general_dtgBTN_tooltip);
            style = ST_CENTER;
            onButtonClick = QUOTE([ctrlParent (_this select 0)] call FUNC(initializeDTGUI));
            class Attributes
            {
                font = "RobotoCondensed";
                color = "#E5E5E5";
                align = "center";
                shadow = "true";
            };
        };
        class ClearDTGButton: RscButton {
            idc = CLEAR_DTG_BUTTON;
            x = QPOS_W(7);
            y = QPOS_H(5);
            w = QPOS_W(SMALL_BUTTON_W);
            h = QPOS_H(SMALL_BUTTON_H);
            colorBackground[] = {0, 0, 0, 0.3};
            colorFocused[] = {0, 0, 0, 0.7};
            text = "X";
            tooltip = CSTRING(ui_general_clearDtgBTN_tooltip);
            onButtonClick = QUOTE(call FUNC(clearDTG));
        };

        class Mod1Text: EchelonText {
            idc = MOD1_TXT;
            y = QPOS_H(7);
            text = CSTRING(ui_general_mod1TXT);
        };
        class Mod1Combo: EchelonCombo {
            idc = MOD1_DROPDOWN;
            y = QPOS_H(8);
        };

        class IconText: Mod1Text {
            idc = ICON_TXT;
            y = QPOS_H(9);
            text = CSTRING(ui_general_iconTXT);
        };
        class IconCombo: EchelonCombo {
            idc = ICON_DROPDOWN;
            y = QPOS_H(10);
        };

        class Mod2Text: Mod1Text {
            idc = MOD2_TXT;
            y = QPOS_H(11);
            text = CSTRING(ui_general_mod2TXT);
        };
        class Mod2Combo: EchelonCombo {
            idc = MOD2_DROPDOWN;
            y = QPOS_H(12);
        };

        class ReinforcedCheckbox: GVAR(RscCheckBoxSound) {
            idc = REINFORCED_CHECKBOX;
            x = QPOS_W(CONFIG_W - 7 - 1);
            y = QPOS_H(4);
            w = QPOS_W(1);
            h = QPOS_H(1);
        };
        class ReinforcedText: GVAR(RscText) {
            idc = REINFORCED_TXT;
            x = QPOS_W(CONFIG_W - 7);
            y = QPOS_H(4);
            w = QPOS_W(6.5);
            h = QPOS_H(1);
            text = CSTRING(ui_general_reinforcedTXT);
        };
        class ReducedCheckbox: ReinforcedCheckbox {
            idc = REDUCED_CHECKBOX;
            y = QPOS_H(5);
        };
        class ReducedText: ReinforcedText {
            idc = REDUCED_TXT;
            y = QPOS_H(5);
            text = CSTRING(ui_general_reducedTXT);
        };

        class AdditionalInfoText: GVAR(RscText) {
            idc = ADDITIONAL_TXT;
            x = QPOS_W(CONFIG_W - 7.5 - 0.5);
            y = QPOS_H(9);
            w = QPOS_W(7.5);
            h = QPOS_H(1);
            text = CSTRING(ui_general_additionalTXT);
        };
        class AdditionalInfoEdit: GVAR(RscEdit) {
            idc = ADDITIONAL_EDIT;
            x = QPOS_W(CONFIG_W - 7.5 - 0.5);
            y = QPOS_H(10);
            w = QPOS_W(7.5);
            h = QPOS_H(1);
        };
        class UniqueDesignationText: AdditionalInfoText {
            idc = UNIQUE_TXT;
            x = QPOS_W(0.5);
            y = QPOS_H(11);
            text = CSTRING(ui_general_uniqueTXT);
        };
        class UniqueDesignationEdit: AdditionalInfoEdit {
            idc = UNIQUE_EDIT;
            x = QPOS_W(0.5);
            y = QPOS_H(12);
            maxChars = UNIQUE_DESIGNATION_MAX_CHARS;
        };
        class HigherFormationText: AdditionalInfoText {
            idc = HIGHER_TXT;
            x = QPOS_W(CONFIG_W - 7.5 - 0.5);
            y = QPOS_H(11);
            text = CSTRING(ui_general_higherTXT);
        };
        class HigherFormationEdit: AdditionalInfoEdit {
            idc = HIGHER_EDIT;
            x = QPOS_W(CONFIG_W - 7.5 - 0.5);
            y = QPOS_H(12);
            maxChars = HIGHER_FORMATION_MAX_CHARS;
        };

        class HQText: GVAR(RscText) {
            idc = HQ_TXT;
            x = QPOS_W(0.5);
            y = QPOS_H(15);
            w = QPOS_W(6.5);
            h = QPOS_H(1);
            text = CSTRING(ui_general_headquatersTXT);
            style = ST_RIGHT;
        };
        class HQCheckbox: GVAR(RscCheckBoxSound) {
            idc = HQ_CHECKBOX;
            x = QPOS_W(0.5 + 6.5);
            y = QPOS_H(15);
            w = QPOS_W(1);
            h = QPOS_H(1);
        };

        class DamagedCheckbox: GVAR(RscCheckBoxSound) {
            idc = DAMAGED_CHECKBOX;
            x = QPOS_W((CONFIG_W - 10) / 2);
            y = QPOS_H(14);
            w = QPOS_W(1);
            h = QPOS_H(1);
        };
        class DamagedText: GVAR(RscText) {
            idc = DAMAGED_TXT;
            x = QPOS_W((CONFIG_W - 10) / 2 + 1);
            y = QPOS_H(14);
            w = QPOS_W(9);
            h = QPOS_H(1);
            text = CSTRING(ui_general_damagedTXT);
        };
        class DestroyedCheckbox: DamagedCheckbox {
            idc = DESTROYED_CHECKBOX;
            y = QPOS_H(15);
        };
        class DestroyedText: DamagedText {
            idc = DESTROYED_TXT;
            y = QPOS_H(15);
            text = CSTRING(ui_general_destroyedTXT);
        };

        class DirectionText: GVAR(RscText) {
            idc = DIRECTION_TXT;
            x = QPOS_W((CONFIG_W - 10) / 2);
            y = QPOS_H(17);
            w = QPOS_W(10);
            h = QPOS_H(1);
            text = CSTRING(ui_general_directionTXT);
        };
        class DirectionCombo: GVAR(RscCombo) {
            idc = DIRECTION_DROPDOWN;
            x = QPOS_W((CONFIG_W - 10) / 2);
            y = QPOS_H(18);
            w = QPOS_W(10);
            h = QPOS_H(1);
        };

        class AlphaText: GVAR(RscText) {
            idc = ALPHA_TXT;
            x = QPOS_W(0.5);
            y = QPOS_H(CONFIG_H - 2 - 0.5);
            w = QPOS_W(8.8);
            h = QPOS_H(1);
            text = CSTRING(ui_general_alphaTXT);
        };
        class AlphaSlider: RscXSliderH {
            idc = ALPHA_SLIDER;
            x = QPOS_W(0.5);
            y = QPOS_H(CONFIG_H - 1 - 0.5);
            w = QPOS_W(8.8);
            h = QPOS_H(1);
            tooltip = CSTRING(ui_general_resetSlider_tooltip);
            sliderPosition = MARKER_ALPHA;
            sliderRange[] = {MIN_ALPHA, MAX_ALPHA};
        };

        class ScaleText: GVAR(RscText) {
            idc = SCALE_TXT;
            x = QPOS_W((CONFIG_W - 8.8) / 2);
            y = QPOS_H(CONFIG_H - 2 - 0.5);
            w = QPOS_W(8.8);
            h = QPOS_H(1);
            text = CSTRING(ui_general_scaleTXT);
        };
        class ScaleSlider: RscXSliderH {
            idc = SCALE_SLIDER;
            x = QPOS_W((CONFIG_W - 8.8) / 2);
            y = QPOS_H(CONFIG_H - 1 - 0.5);
            w = QPOS_W(8.8);
            h = QPOS_H(1);
            tooltip = CSTRING(ui_general_resetSlider_tooltip);
            sliderPosition = MARKER_SCALE;
            sliderRange[] = {MIN_SCALE, MAX_SCALE};
        };

        class ChannelText: GVAR(RscText) {
            idc = CHANNEL_TXT;
            x = QPOS_W(CONFIG_W - 8.8 - 0.5);
            y = QPOS_H(CONFIG_H - 2 - 0.5);
            w = QPOS_W(8.8);
            h = QPOS_H(1);
            text = CSTRING(ui_general_channelTXT);
        };
        class ChannelCombo: GVAR(RscCombo) {
            idc = CHANNEL_DROPDOWN;
            x = QPOS_W(CONFIG_W - 8.8 - 0.5);
            y = QPOS_H(CONFIG_H - 1 - 0.5);
            w = QPOS_W(8.8);
            h = QPOS_H(1);
        };
    };
};

class GVAR(RscPresets): RscControlsGroupNoScrollbars {
    class controls {
        class Background: RscText {
            idc = PRESETS_BG;
            x = QPOS_W(0);
            y = QPOS_H(0);
            w = QPOS_W(PRESETS_W);
            h = QPOS_H(PRESETS_H - (SMALL_BUTTON_H + PADDING));
            colorBackground[] = {BG_COLOR};
        };
        class DeleteButtonBackground: RscText {
            idc = DELETE_PRESETS_BG;
            x = QPOS_W(PRESETS_W - SMALL_BUTTON_W);
            y = QPOS_H(PRESETS_H - SMALL_BUTTON_W);
            w = QPOS_W(SMALL_BUTTON_W);
            h = QPOS_H(SMALL_BUTTON_H);
            colorBackground[] = {BG_COLOR};
        };

        class SearchEdit: GVAR(RscEdit) {
            idc = SEARCH_PRESETS_EDIT;
            x = QPOS_W(0);
            y = QPOS_H(0);
            w = QPOS_W(PRESETS_W - SMALL_BUTTON_W);
            h = QPOS_H(SMALL_BUTTON_H);
        };
        class SearchButton: RscButtonSearch {
            idc = SEARCH_PRESETS_BUTTON;
            x = QPOS_W(PRESETS_W - SMALL_BUTTON_W);
            y = QPOS_H(0);
            w = QPOS_W(SMALL_BUTTON_W);
            h = QPOS_H(SMALL_BUTTON_H);
            colorBackground[] = {0, 0, 0, 0.3};
            colorFocused[] = {0, 0, 0, 0.7};
            onButtonClick = QUOTE(call FUNC(updatePresetsList););
        };

        class PresetsList: RscListBox {
            idc = PRESETS_LIST;
            x = QPOS_W(0);
            y = QPOS_H(SMALL_BUTTON_H);
            w = QPOS_W(PRESETS_W);
            h = QPOS_H(PRESETS_H - (4 * SMALL_BUTTON_H + PADDING));
        };

        class NameText: RscText {
            idc = PRESETS_NAME_TXT;
            x = QPOS_W(0);
            y = QPOS_H(PRESETS_H - (3 * SMALL_BUTTON_H + PADDING));
            w = QPOS_W(PRESETS_W);
            h = QPOS_H(SMALL_BUTTON_H);
            font = "PuristaLight";
            sizeEx = QUOTE(POS_H(0.8));
            colorBackground[] = {0, 0, 0, 0.3};
            text = CSTRING(ui_general_presetsNameTXT);
        };
        class NameEdit: GVAR(RscEdit) {
            idc = NAME_PRESETS_EDIT;
            x = QPOS_W(0);
            y = QPOS_H(PRESETS_H - (2 * SMALL_BUTTON_H + PADDING));
            w = QPOS_W(PRESETS_W - SMALL_BUTTON_W);
            h = QPOS_H(SMALL_BUTTON_H);
        };
        class ClearNameButton: RscButton {
            idc = CLEAR_PRESETS_BUTTON;
            x = QPOS_W(PRESETS_W - SMALL_BUTTON_W);
            y = QPOS_H(PRESETS_H - (2 * SMALL_BUTTON_H + PADDING));
            w = QPOS_W(SMALL_BUTTON_W);
            h = QPOS_H(SMALL_BUTTON_H);
            colorBackground[] = {0, 0, 0, 0.3};
            colorFocused[] = {0, 0, 0, 0.7};
            text = "X";
            tooltip = CSTRING(ui_general_namePresetsBTN_tooltip);
            onButtonClick = QUOTE(((ctrlParent (_this select 0)) displayCtrl NAME_PRESETS_EDIT) ctrlSetText '';);
        };

        class SaveButton: RscButtonMenu {
            idc = SAVE_PRESETS_BUTTON;
            x = QPOS_W(0);
            y = QPOS_H(PRESETS_H - WIDE_BUTTON_H);
            w = QPOS_W(WIDE_BUTTON_W);
            h = QPOS_H(WIDE_BUTTON_H);
            text = CSTRING(ui_general_savePresetsBTN);
            onButtonClick = QUOTE(call FUNC(savePreset););
        };

        class LoadButton: RscButtonMenu {
            idc = LOAD_PRESETS_BUTTON;
            x = QPOS_W(WIDE_BUTTON_W + PADDING);
            y = QPOS_H(PRESETS_H - WIDE_BUTTON_H);
            w = QPOS_W(WIDE_BUTTON_W);
            h = QPOS_H(WIDE_BUTTON_H);
            text = CSTRING(ui_general_loadPresetsBTN);
            onButtonClick = QUOTE(call FUNC(loadPreset););
        };

        class DeleteButtonIcon: RscPicture {
            idc = DELETE_PRESETS_ICON;
            x = QPOS_W(PRESETS_W - SMALL_BUTTON_W);
            y = QPOS_H(PRESETS_H - SMALL_BUTTON_H);
            w = QPOS_W(SMALL_BUTTON_W);
            h = QPOS_H(SMALL_BUTTON_H);
            text = "A3\3den\Data\Displays\Display3DEN\PanelLeft\entityList_delete_ca.paa";
        };
        class DeleteButton: GVAR(RscTransparentButton) {
            idc = DELETE_PRESETS_BUTTON;
            x = QPOS_W(PRESETS_W - SMALL_BUTTON_W);
            y = QPOS_H(PRESETS_H - SMALL_BUTTON_H);
            w = QPOS_W(SMALL_BUTTON_W);
            h = QPOS_H(SMALL_BUTTON_H);
            tooltip = CSTRING(ui_general_deletePresetsBTN_tooltip);
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl DELETE_PRESETS_BG) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl DELETE_PRESETS_BG) ctrlSetBackgroundColor [BG_COLOR]);
            onButtonClick = QUOTE(call FUNC(deletePreset););
        };
    };
};

class GVAR(Dialog) {
    idd = MAIN_DISPLAY;
    movingEnable = 0;

    class controls {
        class HeaderBackground: RscText {
            idc = HEAD_BG;
            x = QPOS_X(0);
            y = QPOS_Y(0);
            w = QPOS_W(HEADER_W);
            h = QPOS_H(HEADER_H);
            colorBackground[] = {
                "profileNamespace getVariable ['GUI_BCG_RGB_R',0.77]",
                "profileNamespace getVariable ['GUI_BCG_RGB_G',0.51]",
                "profileNamespace getVariable ['GUI_BCG_RGB_B',0.08]",
                "profileNamespace getVariable ['GUI_BCG_RGB_A',0.8]"
            };
        };
        class HeaderTitle: RscTitle {
            idc = HEAD_TXT;
            x = QPOS_X(0);
            y = QPOS_Y(0);
            w = QPOS_W(HEADER_W);
            h = QPOS_H(HEADER_H);
            text = CSTRING(ui_general_headTXT);
        };

        class Preview: GVAR(RscPreview) {
            idc = PREVIEW_GROUP;
            x = QPOS_X(CONFIG_W + PADDING);
            y = QPOS_Y(HEADER_H + PADDING);
            w = QPOS_W(PREVIEW_W);
            h = QPOS_H(PREVIEW_H);
        };

        class Presets: GVAR(RscPresets) {
            idc = PRESETS_GROUP;
            x = QPOS_X(CONFIG_W + PADDING);
            y = QPOS_Y(HEADER_H + PREVIEW_H + 2 * PADDING);
            w = QPOS_W(PRESETS_W);
            h = QPOS_H(PRESETS_H);
        };

        class Configuration: GVAR(RscConfiguration) {
            idc = CONFIG_GROUP;
            x = QPOS_X(0);
            y = QPOS_Y(HEADER_H + PADDING);
            w = QPOS_W(CONFIG_W);
            h = QPOS_H(CONFIG_H);
        };

        class CancelButton: RscButtonMenuCancel {
            idc = CANCEL_BUTTON;
            x = QPOS_X(0);
            y = QPOS_Y(HEADER_H + CONFIG_H + 2 * PADDING);
            w = QPOS_W(WIDE_BUTTON_W);
            h = QPOS_H(WIDE_BUTTON_H);
            onButtonClick = QUOTE((ctrlParent (_this select 0)) closeDisplay 2;);
        };

        class OkButton: RscButtonMenuOK {
            idc = OK_BUTTON;
            x = QPOS_X(CONFIG_W - WIDE_BUTTON_W);
            y = QPOS_Y(HEADER_H + CONFIG_H + 2 * PADDING);
            w = QPOS_W(WIDE_BUTTON_W);
            h = QPOS_H(WIDE_BUTTON_H);
            default = 1;
            onButtonClick = QUOTE([true] call FUNC(transmitUIData););
        };
    };
};

// -----------------------------------------------------------------------------------
// --------------------------------- Date-Time Group ---------------------------------
// -----------------------------------------------------------------------------------
class GVAR(DTG): RscControlsGroupNoScrollbars {
    class controls {
        class Background: RscText {
            idc = DTG_BG;
            x = QPOS_W(0);
            y = QPOS_H(0);
            w = QPOS_W(DTG_W);
            h = QPOS_H(DTG_H);
            colorBackground[] = {BG_COLOR};
        };

        class DateText: GVAR(RscText) {
            idc = DTG_DATE_TXT;
            x = QPOS_W(0);
            y = QPOS_H(1);
            w = QPOS_W(DTG_TEXT_W);
            h = QPOS_H(1);
            style = ST_RIGHT;
            text = "$STR_3DEN_Environment_Attribute_Date_Displayname";
        };
        class YearCombo: GVAR(RscCombo) {
            idc = DTG_YEAR_DROPDOWN;
            x = QPOS_W(DTG_TEXT_W);
            y = QPOS_H(1);
            w = QPOS_W(DTG_DATE_COMBO_W);
            h = QPOS_H(1);
        };
        class MonthCombo: YearCombo {
            idc = DTG_MONTH_DROPDOWN;
            x = QPOS_W(DTG_TEXT_W + DTG_DATE_COMBO_W);
        };
        class DayCombo: YearCombo {
            idc = DTG_DAY_DROPDOWN;
            x = QPOS_W(DTG_TEXT_W + 2 * DTG_DATE_COMBO_W);
        };

        class TimeText: GVAR(RscText) {
            idc = DTG_TIME_TXT;
            x = QPOS_W(0);
            y = QPOS_H(2 + DTG_PADDING);
            w = QPOS_W(DTG_TEXT_W);
            h = QPOS_H(1);
            style = ST_RIGHT;
            text = "$STR_3DEN_Environment_Attribute_Daytime_Displayname";
        };
        class TimeSlider: RscXSliderH {
            idc = DTG_TIME_SLIDER;
            x = QPOS_W(DTG_TEXT_W);
            y = QPOS_H(2 + DTG_PADDING);
            w = QPOS_W(DTG_SLIDER_W);
            h = QPOS_H(1);
        };
        class Frame: RscFrame {
            idc = DTG_TIME_FRAME;
            x = QPOS_W(DTG_TEXT_W + DTG_SLIDER_W);
            y = QPOS_H(2 + DTG_PADDING);
            w = QPOS_W(DTG_TIME_FRAME_W);
            h = QPOS_H(1);
        };
        class Separator: RscText {
            idc = DTG_TIME_SEPARATOR;
            x = QPOS_W(DTG_TEXT_W + DTG_SLIDER_W);
            y = QPOS_H(2 + DTG_PADDING);
            w = QPOS_W(DTG_TIME_FRAME_W);
            h = QPOS_H(1);
            style = ST_CENTER;
            text = ":";
            font = "EtelkaMonospaceProBold";
            sizeEx = QPOS_H(1);
            colorBackground[] = {0, 0, 0, 0.2};
        };
        class Hours: RscEdit {
            idc = DTG_HOURS_EDIT;
            x = QPOS_W(DTG_TEXT_W + DTG_SLIDER_W);
            y = QPOS_H(2 + DTG_PADDING);
            w = QPOS_W(DTG_TIME_FRAME_W / 2);
            h = QPOS_H(1);
            style = QUOTE(ST_CENTER + ST_NO_RECT);
            tooltip = "$STR_3DEN_Attributes_SliderTime_Hour_tooltip";
            font = "EtelkaMonospaceProBold";
            sizeEx = QPOS_H(0.9);
            maxChars = 2;
        };
        class Minutes: Hours {
            idc = DTG_MINUTES_EDIT;
            tooltip = "$STR_3DEN_Attributes_SliderTime_Minute_tooltip";
            x = QPOS_W(DTG_TEXT_W + DTG_SLIDER_W + 2);
        };
        class TimezoneCombo: GVAR(RscCombo) {
            idc = DTG_TIMEZONE_DROPDOWN;
            x = QPOS_W(DTG_TEXT_W + DTG_SLIDER_W + DTG_TIME_FRAME_W);
            y = QPOS_H(2 + DTG_PADDING);
            w = QPOS_W(DTG_TIMEZONE_COMBO_W);
            h = QPOS_H(1);
        };

        class SetLocalTimeButton: RscButtonMenu {
            idc = DTG_LOCALTIME_BUTTON;
            x = QPOS_W(DTG_TEXT_W);
            y = QPOS_H(3 + 2 * DTG_PADDING);
            w = QPOS_W(DTG_BUTTON_W);
            h = QPOS_H(1);
            text = CSTRING(ui_dtg_localTime);
            tooltip = CSTRING(ui_dtg_setLocalTime_tooltip);
            onButtonClick = QUOTE([date] call FUNC(setDTGUIData););
        };
        class SetSystemTimeButton: SetLocalTimeButton {
            idc = DTG_SYSTEMTIME_BUTTON;
            x = QPOS_W(DTG_TEXT_W + DTG_BUTTON_W + PADDING);
            text = CSTRING(ui_dtg_systemTime);
            tooltip = CSTRING(ui_dtg_setSystemTime_tooltip);
            onButtonClick = QUOTE(call FUNC(setDTGUIToSystemTime););
        };
        class SetSystemUTCTimeButtonButton: SetLocalTimeButton {
            idc = DTG_SYSTEMUTCTIME_BUTTON;
            x = QPOS_W(DTG_TEXT_W + 2 * (DTG_BUTTON_W + PADDING));
            text = CSTRING(ui_dtg_systemUTCTime);
            tooltip = CSTRING(ui_dtg_setSystemUTCTime_tooltip);
            onButtonClick = QUOTE([ARR_2(systemTimeUTC,'Z')] call FUNC(setDTGUIData););
        };
    };
};

class GVAR(DTGDialog) {
    idd = DTG_DISPLAY;

    class controls {
        class HeaderBackground: RscText {
            idc = DTG_HEAD_BG;
            x = QPOS_X((MAX_W - DTG_W) / 2);
            y = QPOS_Y((MAX_H - DTG_H) / 2);
            w = QPOS_W(DTG_W);
            h = QPOS_H(DTG_HEADER_H);
            colorBackground[] = {
                "profileNamespace getVariable ['GUI_BCG_RGB_R',0.77]",
                "profileNamespace getVariable ['GUI_BCG_RGB_G',0.51]",
                "profileNamespace getVariable ['GUI_BCG_RGB_B',0.08]",
                "profileNamespace getVariable ['GUI_BCG_RGB_A',0.8]"
            };
        };
        class HeaderTitle: RscTitle {
            idc = DTG_HEAD_TXT;
            x = QPOS_X((MAX_W - DTG_W) / 2);
            y = QPOS_Y((MAX_H - DTG_H) / 2);
            w = QPOS_W(DTG_W);
            h = QPOS_H(DTG_HEADER_H);
            text = CSTRING(ui_dtg);
        };

        class DTG: GVAR(DTG) {
            idc = DTG_GROUP;
            x = QPOS_X((MAX_W - DTG_W) / 2);
            y = QPOS_Y((MAX_H - DTG_H) / 2 + DTG_HEADER_H + PADDING);
            w = QPOS_W(DTG_W);
            h = QPOS_H(DTG_H);
        };

        class CancelButton: RscButtonMenuCancel {
            idc = DTG_CANCEL_BUTTON;
            x = QPOS_X((MAX_W - DTG_W) / 2);
            y = QPOS_Y((MAX_H - DTG_H) / 2 + DTG_HEADER_H + DTG_H + 2 * PADDING);
            w = QPOS_W(WIDE_BUTTON_W);
            h = QPOS_H(WIDE_BUTTON_H);
            onButtonClick = QUOTE((ctrlParent (_this select 0)) closeDisplay 2;);
        };

        class OkButton: RscButtonMenuOK {
            idc = DTG_OK_BUTTON;
            x = QPOS_X((MAX_W - DTG_W) / 2 + DTG_W - WIDE_BUTTON_W);
            y = QPOS_Y((MAX_H - DTG_H) / 2 + DTG_HEADER_H + DTG_H + 2 * PADDING);
            w = QPOS_W(WIDE_BUTTON_W);
            h = QPOS_H(WIDE_BUTTON_H);
            default = 1;
            onButtonClick = QUOTE([[] call FUNC(getDTGUIData)] call FUNC(saveAndDisplayDTG); (ctrlParent (_this select 0)) closeDisplay 1;);
        };
    };
};
