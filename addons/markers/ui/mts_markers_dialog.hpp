class RscText;
class IGUIBack;
class RscPicture;
class RscButton;
class RscCheckBox;
class RscCombo;
class RscEdit;
class RscListBox;
class RscButtonSearch;

class GVAR(dialog) {
    idd = MAIN_DISPLAY;
    movingEnable = 0;

    class controlsBackground {
        class headBack: IGUIBack {
            idc = HEAD_BG;
            colorBackground[] = {0.9098, 0.7922, 0.1059, 1};
            x = "SafeZoneX + (672.50 / 1920) * SafeZoneW"; //388 //672.5-388=284.5 //dx=284.5
            y = "SafeZoneY + (381 / 1080) * SafeZoneH"; //255 //381-255=126 //dy=126
            w = "(547 / 1920) * SafeZoneW";
            h = "(25 / 1080) * SafeZoneH";
        };
        class headTXT: RscText {
            idc = HEAD_TXT;
            sizeEx = 0.05;
            font = "PuristaMedium";
            text = CSTRING(ui_general_headTXT);
            x = "SafeZoneX + (674.50 / 1920) * SafeZoneW"; //390
            y = "SafeZoneY + (377.5 / 1080) * SafeZoneH"; //251.5
            w = "(254 / 1920) * SafeZoneW";
            h = "(31 / 1080) * SafeZoneH";
        };
        class leftBack: IGUIBack {
            idc = LEFT_BG;
            colorBackground[] = {0, 0, 0, 0.7};
            x = "SafeZoneX + (672.50 / 1920) * SafeZoneW"; //388
            y = "SafeZoneY + (409 / 1080) * SafeZoneH"; //283
            w = "(370 / 1920) * SafeZoneW";
            h = "(290 / 1080) * SafeZoneH";
        };
        class rightBack: IGUIBack {
            idc = RIGHT_BG;
            colorBackground[] = {0, 0, 0, 0.7};
            x = "SafeZoneX + (1045.50 / 1920) * SafeZoneW"; //761
            y = "SafeZoneY + (409 / 1080) * SafeZoneH"; //283
            w = "(202 / 1920) * SafeZoneW";
            h = "(267 / 1080) * SafeZoneH";
        };
        class previewTXT: RscText {
            idc = PREVIEW_TXT;
            sizeEx = 0.055;
            font = "PuristaMedium";
            text = CSTRING(ui_general_previewTXT);
            style = 0+2;
            x = "SafeZoneX + (1054.50 / 1920) * SafeZoneW"; //770
            y = "SafeZoneY + (416 / 1080) * SafeZoneH"; //290
            w = "(180 / 1920) * SafeZoneW"; //90
            h = "(30 / 1080) * SafeZoneH"; //21
        };
        class identityTXT: RscText {
            idc = IDENTITY_TXT;
            font = "PuristaLight";
            sizeEx = 0.035;
            text = CSTRING(ui_general_identityTXT);
            x = "SafeZoneX + (674.50 / 1920) * SafeZoneW"; //390
            y = "SafeZoneY + (428 / 1080) * SafeZoneH"; //302
            w = "(90 / 1920) * SafeZoneW";
            h = "(18 / 1080) * SafeZoneH";
        };
        class iconTXT: RscText {
            idc = ICON_TXT;
            font = "PuristaLight";
            sizeEx = 0.035;
            text = CSTRING(ui_general_iconTXT);
            x = "SafeZoneX + (674.50 / 1920) * SafeZoneW"; //390
            y = "SafeZoneY + (493 / 1080) * SafeZoneH"; //367
            w = "(135 / 1920) * SafeZoneW";
            h = "(18 / 1080) * SafeZoneH";
        };
        class cbTXT: RscText {
            idc = CHECKBOX_TXT;
            font = "PuristaLight";
            sizeEx = 0.035;
            text = "";
            x = "SafeZoneX + (797.50 / 1920) * SafeZoneW"; //513
            y = "SafeZoneY + (466 / 1080) * SafeZoneH"; //340
            w = "(200 / 1920) * SafeZoneW";
            h = "(18 / 1080) * SafeZoneH";
        };
        class mod1TXT: RscText {
            idc = MOD1_TXT;
            font = "PuristaLight";
            sizeEx = 0.035;
            text = CSTRING(ui_general_mod1TXT);
            x = "SafeZoneX + (674.50 / 1920) * SafeZoneW"; //390
            y = "SafeZoneY + (518 / 1080) * SafeZoneH"; //392
            w = "(135 / 1920) * SafeZoneW";
            h = "(18 / 1080) * SafeZoneH";
        };
        class mod2TXT: RscText {
            idc = MOD2_TXT;
            font = "PuristaLight";
            sizeEx = 0.035;
            text = CSTRING(ui_general_mod2TXT);
            x = "SafeZoneX + (674.50 / 1920) * SafeZoneW"; //390
            y = "SafeZoneY + (543 / 1080) * SafeZoneH"; //417
            w = "(135 / 1920) * SafeZoneW";
            h = "(18 / 1080) * SafeZoneH";
        };
        class echelonTXT: RscText {
            idc = ECHELON_TXT;
            font = "PuristaLight";
            sizeEx = 0.035;
            text = CSTRING(ui_general_echelonTXT);
            x = "SafeZoneX + (674.50 / 1920) * SafeZoneW"; //390
            y = "SafeZoneY + (568 / 1080) * SafeZoneH"; //442
            w = "(135 / 1920) * SafeZoneW";
            h = "(18 / 1080) * SafeZoneH";
        };
        class reinforcedTXT: RscText {
            idc = REINFORCED_TXT;
            font = "PuristaLight";
            sizeEx = 0.035;
            text = CSTRING(ui_general_reinforcedTXT);
            x = "SafeZoneX + (674.50 / 1920) * SafeZoneW"; //390
            y = "SafeZoneY + (593 / 1080) * SafeZoneH"; //467
            w = "(100 / 1920) * SafeZoneW";
            h = "(18 / 1080) * SafeZoneH";
        };
        class reducedTXT: RscText {
            idc = REDUCED_TXT;
            font = "PuristaLight";
            sizeEx = 0.035;
            text = CSTRING(ui_general_reducedTXT);
            x = "SafeZoneX + (829.50 / 1920) * SafeZoneW"; //545
            y = "SafeZoneY + (593 / 1080) * SafeZoneH"; //467
            w = "(100/ 1920) * SafeZoneW";
            h = "(18 / 1080) * SafeZoneH";
        };
        class higherTXT: RscText {
            idc = HIGHER_TXT;
            font = "PuristaLight";
            sizeEx = 0.035;
            text = CSTRING(ui_general_higherTXT);
            x = "SafeZoneX + (674.50 / 1920) * SafeZoneW"; //390
            y = "SafeZoneY + (618 / 1080) * SafeZoneH"; //492
            w = "(150 / 1920) * SafeZoneW";
            h = "(18 / 1080) * SafeZoneH";
        };
        class uniqueTXT: RscText {
            idc = UNIQUE_TXT;
            font = "PuristaLight";
            sizeEx = 0.035;
            text = CSTRING(ui_general_uniqueTXT);
            x = "SafeZoneX + (674.50 / 1920) * SafeZoneW"; //390
            y = "SafeZoneY + (643 / 1080) * SafeZoneH"; //517
            w = "(150 / 1920) * SafeZoneW";
            h = "(18 / 1080) * SafeZoneH";
        };
        class channelTXT: RscText {
            idc = CHANNEL_TXT;
            font = "PuristaLight";
            sizeEx = 0.035;
            text = CSTRING(ui_general_channelTXT);
            x = "SafeZoneX + (674.50 / 1920) * SafeZoneW"; //390
            y = "SafeZoneY + (673 / 1080) * SafeZoneH"; //547
            w = "(135 / 1920) * SafeZoneW";
            h = "(18 / 1080) * SafeZoneH";
        };
        class previewBackground: RscPicture {
            idc = PREVIEW_BG;
            x = "SafeZoneX + (1066.50 / 1920) * SafeZoneW"; //782
            y = "SafeZoneY + (456 / 1080) * SafeZoneH"; //330
            w = "(160 / 1920) * SafeZoneW"; //160
            h = "(160 / 1080) * SafeZoneH"; //160
            text = QPATHTOF(data\ui\mts_markers_ui_preview_background.paa);
        };
        class previewLayerIdentity: RscPicture {
            idc = PREVIEW_LYR_IDENTITY;
            x = "SafeZoneX + (1066.50 / 1920) * SafeZoneW"; //782
            y = "SafeZoneY + (456 / 1080) * SafeZoneH"; //330
            w = "(160 / 1920) * SafeZoneW";
            h = "(160 / 1080) * SafeZoneH";
            text = "";
        };
        class previewLayerMod1: RscPicture {
            idc = PREVIEW_LYR_MOD_1;
            x = "SafeZoneX + (1066.50 / 1920) * SafeZoneW"; //782
            y = "SafeZoneY + (456 / 1080) * SafeZoneH"; //330
            w = "(160 / 1920) * SafeZoneW";
            h = "(160 / 1080) * SafeZoneH";
            text = "";
        };
        class previewLayerMod2: RscPicture {
            idc = PREVIEW_LYR_MOD_2;
            x = "SafeZoneX + (1066.50 / 1920) * SafeZoneW"; //782
            y = "SafeZoneY + (456 / 1080) * SafeZoneH"; //330
            w = "(160 / 1920) * SafeZoneW";
            h = "(160 / 1080) * SafeZoneH";
            text = "";
        };
        class previewLayerMod3: RscPicture {
            idc = PREVIEW_LYR_MOD_3;
            x = "SafeZoneX + (1066.50 / 1920) * SafeZoneW"; //782
            y = "SafeZoneY + (456 / 1080) * SafeZoneH"; //330
            w = "(160 / 1920) * SafeZoneW";
            h = "(160 / 1080) * SafeZoneH";
            text = "";
        };
        class previewLayerMod4: RscPicture {
            idc = PREVIEW_LYR_MOD_4;
            x = "SafeZoneX + (1066.50 / 1920) * SafeZoneW"; //782
            y = "SafeZoneY + (456 / 1080) * SafeZoneH"; //330
            w = "(160 / 1920) * SafeZoneW";
            h = "(160 / 1080) * SafeZoneH";
            text = "";
        };
        class previewLayerEchelon: RscPicture {
            idc = PREVIEW_LYR_ECHELON;
            x = "SafeZoneX + (1066.50 / 1920) * SafeZoneW"; //782
            y = "SafeZoneY + (456 / 1080) * SafeZoneH"; //330
            w = "(160 / 1920) * SafeZoneW";
            h = "(160 / 1080) * SafeZoneH";
            text = "";
        };
        class previewLayerSizeMod: RscPicture {
            idc = PREVIEW_LYR_SIZE_MOD;
            x = "SafeZoneX + (1066.50 / 1920) * SafeZoneW"; //782
            y = "SafeZoneY + (456 / 1080) * SafeZoneH"; //330
            w = "(160 / 1920) * SafeZoneW";
            h = "(160 / 1080) * SafeZoneH";
            text = "";
        };
        class presetsHeadBack: IGUIBack {
            idc = PRESETS_HEAD_BG;
            colorBackground[] = {0.9098, 0.7922, 0.1059, 1};
            x = "SafeZoneX + (1250.5 / 1920) * SafeZoneW";
            y = "SafeZoneY + (381 / 1080) * SafeZoneH";
            w = "(224 / 1920) * SafeZoneW";
            h = "(25 / 1080) * SafeZoneH";
        };
        class presetsBack: IGUIBack {
            idc = PRESETS_BG;
            colorBackground[] = {0, 0, 0, 0.6};
            x = "SafeZoneX + (1250.5 / 1920) * SafeZoneW";
            y = "SafeZoneY + (409 / 1080) * SafeZoneH";
            w = "(224 / 1920) * SafeZoneW";
            h = "(267 / 1080) * SafeZoneH";
        };
        class presetsNameTXT: RscText {
            idc = PRESETS_NAME_TXT;
            font = "PuristaLight";
            sizeEx = 0.035;
            text = CSTRING(ui_general_presetsNameTXT);
            colorBackground[] = {0, 0, 0, 0.3};
            x = "SafeZoneX + (1250.5 / 1920) * SafeZoneW";
            y = "SafeZoneY + (636 / 1080) * SafeZoneH";
            w = "(224 / 1920) * SafeZoneW";
            h = "(20 / 1080) * SafeZoneH";
        };
        class deletePresetsBG: IGUIBack {
            idc = DELETE_PRESETS_BG;
            colorBackground[] = {0, 0, 0, 0.7};
            x = "SafeZoneX + (1454.5 / 1920) * SafeZoneW";
            y = "SafeZoneY + (679 / 1080) * SafeZoneH";
            w = "(20 / 1920) * SafeZoneW";
            h = "(20 / 1080) * SafeZoneH";
        };
    };

    class controls {
        class bluBTNframe: RscPicture {
            idc = FRIENDLY_BTN_FRAME;
            x = "SafeZoneX + (774.50 / 1920) * SafeZoneW"; //490
            y = "SafeZoneY + (416 / 1080) * SafeZoneH"; //290
            w = "(45 / 1920) * SafeZoneW";
            h = "(45 / 1080) * SafeZoneH";
            style = 64;
            colorText[] = {1,1,1,1};
        };
        class bluBTNback: RscPicture {
            text = QPATHTOF(data\ui\mts_markers_ui_blu_frameshape.paa);
            idc = FRIENDLY_BTN_BACK;
            x = "SafeZoneX + (774.50 / 1920) * SafeZoneW"; //490
            y = "SafeZoneY + (416 / 1080) * SafeZoneH"; //290
            w = "(45 / 1920) * SafeZoneW";
            h = "(45 / 1080) * SafeZoneH";
        };
        class bluBTNctrl: RscButton {
            text = "";
            idc = FRIENDLY_BTN_CTRL;
            x = "SafeZoneX + (774.50 / 1920) * SafeZoneW"; //490
            y = "SafeZoneY + (416 / 1080) * SafeZoneH"; //290
            w = "(45 / 1920) * SafeZoneW";
            h = "(45 / 1080) * SafeZoneH";
            colorBackground[] = {0,0,0,0};
            colorBackgroundActive[] = {0,0,0,0};
            colorBackgroundDisabled[] = {0,0,0,0};
            colorText[] = {0,0,0,0};
            period = 0;
            tooltip = CSTRING(ui_identity_friend);
            action = QUOTE(['blu'] call FUNC(identityButtonsAction););
        };
        class redBTNframe: RscPicture {
            idc = HOSTILE_BTN_FRAME;
            x = "SafeZoneX + (824.50 / 1920) * SafeZoneW"; //540
            y = "SafeZoneY + (416 / 1080) * SafeZoneH"; //290
            w = "(45 / 1920) * SafeZoneW";
            h = "(45 / 1080) * SafeZoneH";
            style = 64;
            colorText[] = {1,1,1,1};
        };
        class redBTNback: RscPicture {
            text = QPATHTOF(data\ui\mts_markers_ui_red_frameshape.paa);
            idc = HOSTILE_BTN_BACK;
            x = "SafeZoneX + (824.50 / 1920) * SafeZoneW"; //540
            y = "SafeZoneY + (416 / 1080) * SafeZoneH"; //290
            w = "(45 / 1920) * SafeZoneW";
            h = "(45 / 1080) * SafeZoneH";
        };
        class redBTNctrl: RscButton {
            text = "";
            idc = HOSTILE_BTN_CTRL;
            x = "SafeZoneX + (824.50 / 1920) * SafeZoneW"; //540
            y = "SafeZoneY + (416 / 1080) * SafeZoneH"; //290
            w = "(45 / 1920) * SafeZoneW";
            h = "(45 / 1080) * SafeZoneH";
            colorBackground[] = {0,0,0,0};
            colorBackgroundActive[] = {0,0,0,0};
            colorBackgroundDisabled[] = {0,0,0,0};
            colorText[] = {0,0,0,0};
            period = 0;
            tooltip = CSTRING(ui_identity_hostile);
            action = QUOTE(['red'] call FUNC(identityButtonsAction););
        };
        class neuBTNframe: RscPicture {
            idc = NEUTRAL_BTN_FRAME;
            x = "SafeZoneX + (874.50 / 1920) * SafeZoneW"; //590
            y = "SafeZoneY + (416 / 1080) * SafeZoneH"; //290
            w = "(45 / 1920) * SafeZoneW";
            h = "(45 / 1080) * SafeZoneH";
            style = 64;
            colorText[] = {1,1,1,1};
        };
        class neuBTNback: RscPicture {
            text = QPATHTOF(data\ui\mts_markers_ui_neu_frameshape.paa);
            idc = NEUTRAL_BTN_BACK;
            x = "SafeZoneX + (874.50 / 1920) * SafeZoneW"; //590
            y = "SafeZoneY + (416 / 1080) * SafeZoneH"; //290
            w = "(45 / 1920) * SafeZoneW";
            h = "(45 / 1080) * SafeZoneH";
        };
        class neuBTNctrl: RscButton {
            text = "";
            idc = NEUTRAL_BTN_CTRL;
            x = "SafeZoneX + (874.50 / 1920) * SafeZoneW"; //590
            y = "SafeZoneY + (416 / 1080) * SafeZoneH"; //290
            w = "(45 / 1920) * SafeZoneW";
            h = "(45 / 1080) * SafeZoneH";
            colorBackground[] = {0,0,0,0};
            colorBackgroundActive[] = {0,0,0,0};
            colorBackgroundDisabled[] = {0,0,0,0};
            colorText[] = {0,0,0,0};
            period = 0;
            tooltip = CSTRING(ui_identity_neutral);
            action = QUOTE(['neu'] call FUNC(identityButtonsAction););
        };
        class unkBTNframe: RscPicture {
            idc = UNKNOWN_BTN_FRAME;
            x = "SafeZoneX + (924.50 / 1920) * SafeZoneW"; //640
            y = "SafeZoneY + (416 / 1080) * SafeZoneH"; //290
            w = "(45 / 1920) * SafeZoneW";
            h = "(45 / 1080) * SafeZoneH";
            style = 64;
            colorText[] = {1,1,1,1};
        };
        class unkBTNback: RscPicture {
            text = QPATHTOF(data\ui\mts_markers_ui_unk_frameshape.paa);
            idc = UNKNOWN_BTN_BACK;
            x = "SafeZoneX + (924.50 / 1920) * SafeZoneW"; //640
            y = "SafeZoneY + (416 / 1080) * SafeZoneH"; //290
            w = "(45 / 1920) * SafeZoneW";
            h = "(45 / 1080) * SafeZoneH";
        };
        class unkBTNctrl: RscButton {
            text = "";
            idc = UNKNOWN_BTN_CTRL;
            x = "SafeZoneX + (924.50 / 1920) * SafeZoneW"; //640
            y = "SafeZoneY + (416 / 1080) * SafeZoneH"; //290
            w = "(45 / 1920) * SafeZoneW";
            h = "(45 / 1080) * SafeZoneH";
            colorBackground[] = {0,0,0,0};
            colorBackgroundActive[] = {0,0,0,0};
            colorBackgroundDisabled[] = {0,0,0,0};
            colorText[] = {0,0,0,0};
            period = 0;
            tooltip = CSTRING(ui_identity_unknown);
            action = QUOTE(['unk'] call FUNC(identityButtonsAction););
        };
        class modCB: RscCheckBox {
            idc = MOD_CHECKBOX;
            x = "SafeZoneX + (768.50 / 1920) * SafeZoneW"; //484
            y = "SafeZoneY + (461 / 1080) * SafeZoneH"; //335
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class iconDD: RscCombo {
            idc = ICON_DROPDOWN;
            x = "SafeZoneX + (814.50 / 1920) * SafeZoneW"; //530
            y = "SafeZoneY + (491 / 1080) * SafeZoneH"; //365
            w = "(195 / 1920) * SafeZoneW";
            h = "(21 / 1080) * SafeZoneH";
        };
        class mod1DD: RscCombo {
            idc = MOD1_DROPDOWN;
            x = "SafeZoneX + (814.50 / 1920) * SafeZoneW"; //530
            y = "SafeZoneY + (516 / 1080) * SafeZoneH"; //390
            w = "(195 / 1920) * SafeZoneW";
            h = "(21 / 1080) * SafeZoneH";
        };
        class mod2DD: RscCombo {
            idc = MOD2_DROPDOWN;
            x = "SafeZoneX + (814.50 / 1920) * SafeZoneW"; //530
            y = "SafeZoneY + (541 / 1080) * SafeZoneH"; //415
            w = "(195 / 1920) * SafeZoneW";
            h = "(21 / 1080) * SafeZoneH";
        };
        class echelonDD: RscCombo {
            idc = ECHELON_DROPDOWN;
            x = "SafeZoneX + (814.50 / 1920) * SafeZoneW"; //530
            y = "SafeZoneY + (566 / 1080) * SafeZoneH"; //440
            w = "(195 / 1920) * SafeZoneW";
            h = "(21 / 1080) * SafeZoneH";
        };
        class reinforcedCB: RscCheckBox {
            idc = REINFORCED_CHECKBOX;
            x = "SafeZoneX + (779.50 / 1920) * SafeZoneW"; //495
            y = "SafeZoneY + (587 / 1080) * SafeZoneH"; //461
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class reducedCB: RscCheckBox {
            idc = REDUCED_CHECKBOX;
            x = "SafeZoneX + (929.50 / 1920) * SafeZoneW"; //645
            y = "SafeZoneY + (587 / 1080) * SafeZoneH"; //461
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class higherEF: RscEdit {
            idc = HIGHER_EDIT;
            type = 2;
            style = 0+512;
            x = "SafeZoneX + (834.50 / 1920) * SafeZoneW"; //550
            y = "SafeZoneY + (618 / 1080) * SafeZoneH"; //492
            w = "(175 / 1920) * SafeZoneW";
            h = "(20 / 1080) * SafeZoneH";
            colorBackground[] = {0,0,0,1};
            sizeEx = 0.035;
            shadow = 0;
        };
        class uniqueEF: RscEdit {
            idc = UNIQUE_EDIT;
            type = 2;
            style = 0+512;
            x = "SafeZoneX + (834.50 / 1920) * SafeZoneW"; //550
            y = "SafeZoneY + (643 / 1080) * SafeZoneH"; //517
            w = "(175 / 1920) * SafeZoneW";
            h = "(20 / 1080) * SafeZoneH";
            colorBackground[] = {0,0,0,1};
            sizeEx = 0.035;
            shadow = 0;
            maxChars = 3;
        };
        class channelDD: RscCombo {
            idc = CHANNEL_DROPDOWN;
            x = "SafeZoneX + (814.50 / 1920) * SafeZoneW"; //530
            y = "SafeZoneY + (671 / 1080) * SafeZoneH"; //545
            w = "(195 / 1920) * SafeZoneW";
            h = "(20 / 1080) * SafeZoneH";
        };
        class okBTN: RscButton {
            idc = OK_BUTTON;
            font = "PuristaMedium";
            text = CSTRING(ui_general_okBTN);
            x = "SafeZoneX + (1045.50 / 1920) * SafeZoneW"; //761
            y = "SafeZoneY + (679 / 1080) * SafeZoneH"; //553
            w = "(100 / 1920) * SafeZoneW";
            h = "(20 / 1080) * SafeZoneH";
            colorBackground[] = {0,0,0,0.7};
            colorFocused[] = {0,0,0,0.7};
            style = 0+2;
            default = true;
            action = QUOTE([true] call FUNC(transmitUIData););
        };
        class cancelBTN: RscButton {
            idc = CANCEL_BUTTON;
            font = "PuristaMedium";
            text = CSTRING(ui_general_cancelBTN);
            x = "SafeZoneX + (1148.50 / 1920) * SafeZoneW"; //864
            y = "SafeZoneY + (679 / 1080) * SafeZoneH"; //553
            w = "(99 / 1920) * SafeZoneW";
            h = "(20 / 1080) * SafeZoneH";
            colorBackground[] = {0,0,0,0.7};
            colorFocused[] = {0,0,0,0.7};
            style = 0+2;
            action = QUOTE((findDisplay MAIN_DISPLAY) closeDisplay 2;);
        };
        class togglePresetsBTN: RscButton {
            idc = TOGGLE_PRESETS_BUTTON;
            font = "PuristaMedium";
            text = "<<";
            tooltip = CSTRING(ui_general_togglePresetsBTN_tooltip);
            x = "SafeZoneX + (1222.5 / 1920) * SafeZoneW";
            y = "SafeZoneY + (381 / 1080) * SafeZoneH";
            w = "(25 / 1920) * SafeZoneW";
            h = "(25 / 1080) * SafeZoneH";
            colorBackground[] = {0.9098, 0.7922, 0.1059, 1}; //0, 0, 0, 0.7
            colorFocused[] = {0.9098, 0.7922, 0.1059, 1}; //0, 0, 0, 0.7
            style = 0+2;
            action = QUOTE([!ctrlShown ((findDisplay MAIN_DISPLAY) displayCtrl PRESETS_BG)] call FUNC(showPresetsUI););
        };
        class savePresetsBTN: RscButton {
            idc = SAVE_PRESETS_BUTTON;
            font = "PuristaMedium";
            text = CSTRING(ui_general_savePresetsBTN);
            x = "SafeZoneX + (1250.5 / 1920) * SafeZoneW";
            y = "SafeZoneY + (679 / 1080) * SafeZoneH";
            w = "(99 / 1920) * SafeZoneW";
            h = "(20 / 1080) * SafeZoneH";
            colorBackground[] = {0, 0, 0, 0.7};
            colorFocused[] = {0, 0, 0, 0.7};
            style = 0+2;
            action = QUOTE(call FUNC(savePreset););
        };
        class loadPresetsBTN: RscButton {
            idc = LOAD_PRESETS_BUTTON;
            font = "PuristaMedium";
            text = CSTRING(ui_general_loadPresetsBTN);
            x = "SafeZoneX + (1352.5 / 1920) * SafeZoneW";
            y = "SafeZoneY + (679 / 1080) * SafeZoneH";
            w = "(99 / 1920) * SafeZoneW";
            h = "(20 / 1080) * SafeZoneH";
            colorBackground[] = {0, 0, 0, 0.7};
            colorFocused[] = {0, 0, 0, 0.7};
            style = 0+2;
            action = QUOTE(call FUNC(loadPreset););
        };
        class deletePresetsPic: RscPicture {
            idc = DELETE_PRESETS_PIC;
            text = "A3\3den\Data\Displays\Display3DEN\PanelLeft\entityList_delete_ca.paa";
            x = "SafeZoneX + (1454.5 / 1920) * SafeZoneW";
            y = "SafeZoneY + (679 / 1080) * SafeZoneH";
            w = "(20 / 1920) * SafeZoneW";
            h = "(20 / 1080) * SafeZoneH";
        };
        class deletePresetsBTN: RscButton {
            idc = DELETE_PRESETS_BUTTON;
            tooltip = CSTRING(ui_general_deletePresetsBTN_tooltip);
            x = "SafeZoneX + (1454.5 / 1920) * SafeZoneW";
            y = "SafeZoneY + (679 / 1080) * SafeZoneH";
            w = "(20 / 1920) * SafeZoneW";
            h = "(20 / 1080) * SafeZoneH";
            colorBackground[] = {0, 0, 0, 0};
            colorBackgroundActive[] = {0, 0, 0, 0};
            colorBackgroundDisabled[] = {0, 0, 0, 0};
            colorText[] = {0, 0, 0, 0};
            period = 0;
            style = 0+2;
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl DELETE_PRESETS_BG) ctrlSetBackgroundColor [ARR_4(0, 0, 0, 1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl DELETE_PRESETS_BG) ctrlSetBackgroundColor [ARR_4(0, 0, 0, 0.7)]);
            action = QUOTE(call FUNC(deletePreset););
        };
        class searchPresetsBTN: RscButtonSearch {
            idc = SEARCH_PRESETS_BUTTON;
            x = "SafeZoneX + (1454.5 / 1920) * SafeZoneW";
            y = "SafeZoneY + (409 / 1080) * SafeZoneH";
            w = "(20 / 1920) * SafeZoneW";
            h = "(20 / 1080) * SafeZoneH";
            colorBackground[] = {0, 0, 0, 0};
            colorFocused[] = {0, 0, 0, 0};
            action = QUOTE(call FUNC(updatePresetsList););
        };
        class searchPresetsEF: RscEdit {
            idc = SEARCH_PRESETS_EDIT;
            type = 2;
            style = 0+512;
            x = "SafeZoneX + (1250.5 / 1920) * SafeZoneW";
            y = "SafeZoneY + (409 / 1080) * SafeZoneH";
            w = "(204 / 1920) * SafeZoneW";
            h = "(20 / 1080) * SafeZoneH";
            colorBackground[] = {0, 0, 0, 1};
            sizeEx = 0.035;
            shadow = 0;
        };
        class namePresetsEF: RscEdit {
            idc = NAME_PRESETS_EDIT;
            type = 2;
            style = 0+512;
            x = "SafeZoneX + (1250.5 / 1920) * SafeZoneW";
            y = "SafeZoneY + (656 / 1080) * SafeZoneH";
            w = "(204 / 1920) * SafeZoneW";
            h = "(20 / 1080) * SafeZoneH";
            colorBackground[] = {0, 0, 0, 1};
            sizeEx = 0.035;
            shadow = 0;
        };
        class namePresetsBTN: RscButton {
            idc = NAME_PRESETS_BUTTON;
            font = "PuristaMedium";
            text = "X";
            tooltip = CSTRING(ui_general_namePresetsBTN_tooltip);
            x = "SafeZoneX + (1454.5 / 1920) * SafeZoneW";
            y = "SafeZoneY + (656 / 1080) * SafeZoneH";
            w = "(20 / 1920) * SafeZoneW";
            h = "(20 / 1080) * SafeZoneH";
            colorBackground[] = {0, 0, 0, 0.7};
            colorFocused[] = {0, 0, 0, 0.7};
            action = QUOTE(((findDisplay MAIN_DISPLAY) displayCtrl NAME_PRESETS_EDIT) ctrlSetText '';);
        };
        class presetsList: RscListBox {
            idc = PRESETS_LIST;
            x = "SafeZoneX + (1250.5 / 1920) * SafeZoneW";
            y = "SafeZoneY + (429 / 1080) * SafeZoneH";
            w = "(224 / 1920) * SafeZoneW";
            h = "(207 / 1080) * SafeZoneH";
        };
    };
};
