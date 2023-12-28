#define IDENTITY_MARKER_FILE(IDENTITY,MODIFIER,NAME) mts_markers_##IDENTITY##_##MODIFIER##_##NAME##.paa
#define IDENTITY_MARKER(IDENTITY,MODIFIER,NAME) \
class mts_##IDENTITY##_##MODIFIER##_##NAME##: mts_##IDENTITY##_frameshape { \
    icon = QPATHTOF(data\IDENTITY\MODIFIER\MARKER_FILE(IDENTITY,MODIFIER,NAME)); \
}

// Default marker
#define MARKER(MODIFIER,NAME) \
    IDENTITY_MARKER(blu,MODIFIER,NAME); \
    IDENTITY_MARKER(red,MODIFIER,NAME); \
    IDENTITY_MARKER(neu,MODIFIER,NAME); \
    IDENTITY_MARKER(unk,MODIFIER,NAME)

// Common markers
#define COM_MARKER(MODIFIER,NAME) \
class mts_com_##MODIFIER##_##NAME##: mts_blu_frameshape { \
    icon = QPATHTOF(data\com\MODIFIER\IDENTITY_MARKER_FILE(com,MODIFIER,NAME)); \
}

// Character markers
#define ALPHANUM_MARKER_FILE(ANCHOR,POSITION,LETTER) mts_markers_alphanum_##ANCHOR##_##POSITION##_##LETTER##.paa
#define ALPHANUM_MARKER(ANCHOR,POSITION,LETTER) \
class mts_alphanum_##ANCHOR##_##POSITION##_##LETTER##: mts_blu_frameshape { \
    icon = QPATHTOF(data\alphanum\ANCHOR\POSITION\ALPHANUM_MARKER_FILE(ANCHOR,POSITION,LETTER)); \
}
#define SPECIAL_CHAR_MARKER_FILE(ANCHOR,POSITION,LETTER) mts_markers_special_##ANCHOR##_##POSITION##_##LETTER##.paa
#define SPECIAL_CHAR_MARKER(ANCHOR,POSITION,LETTER) \
class mts_special_##ANCHOR##_##POSITION##_##LETTER##: mts_blu_frameshape { \
    icon = QPATHTOF(data\special\ANCHOR\POSITION\SPECIAL_CHAR_MARKER_FILE(ANCHOR,POSITION,LETTER)); \
}

// Date-Time Group markers
#define DTG_MARKER_FILE(POSITION,LETTER) mts_markers_dtg_##POSITION##_##LETTER##.paa
#define DTG_MARKER(POSITION,LETTER) \
class mts_dtg_##POSITION##_##LETTER##: mts_blu_frameshape { \
    icon = QPATHTOF(data\dtg\POSITION\DTG_MARKER_FILE(POSITION,LETTER)); \
}

// Direction of Movement markers
#define IDENTITY_DIR_MARKER_FILE(IDENTITY,DIRECTION) mts_markers_##IDENTITY##_dir_##DIRECTION##.paa
#define IDENTITY_DIR_MARKER(IDENTITY,DIRECTION) \
class mts_##IDENTITY##_dir_##DIRECTION##: mts_##IDENTITY##_frameshape { \
    icon = QPATHTOF(data\IDENTITY\dir\DIR_MARKER_FILE(IDENTITY,DIRECTION)); \
}
#define DIR_MARKER(DIRECTION) \
    IDENTITY_DIR_MARKER(blu,DIRECTION); \
    IDENTITY_DIR_MARKER(red,DIRECTION); \
    IDENTITY_DIR_MARKER(neu,DIRECTION); \
    IDENTITY_DIR_MARKER(unk,DIRECTION)

// Direction of Movement markers for modifications (e.g. HQ)
#define IDENTITY_ALT_DIR_MARKER_FILE(IDENTITY,MOD,DIRECTION) mts_markers_##IDENTITY##_dir_##MOD##_##DIRECTION##.paa
#define IDENTITY_ALT_DIR_MARKER(IDENTITY,MOD,DIRECTION) \
class mts_##IDENTITY##_dir_##MOD##_##DIRECTION##: mts_##IDENTITY##_frameshape { \
    icon = QPATHTOF(data\IDENTITY\dir\MOD\ALT_DIR_MARKER_FILE(IDENTITY,MOD,DIRECTION)); \
}
#define DIR_MOD_MARKER(MOD,DIRECTION) \
    IDENTITY_ALT_DIR_MARKER(blu,MOD,DIRECTION); \
    IDENTITY_ALT_DIR_MARKER(red,MOD,DIRECTION); \
    IDENTITY_ALT_DIR_MARKER(neu,MOD,DIRECTION); \
    IDENTITY_ALT_DIR_MARKER(unk,MOD,DIRECTION)

class CfgMarkers {
    class b_unknown;
    class o_unknown;
    class n_unknown;

    class mts_blu_frameshape: b_unknown {
        author = CSTRING(authors);
        scope = 0;
        icon = QPATHTOF(data\blu\mts_markers_blu_frameshape.paa);
        size = 256;
    };
    class mts_blu_vanilla_frameshape: mts_blu_frameshape {
        icon = QPATHTOF(data\blu\mts_markers_blu_vanilla_frameshape.paa);
    };
    class mts_bludash_frameshape: mts_blu_frameshape {
        icon = QPATHTOF(data\blu\mts_markers_bludash_frameshape.paa);
    };
    class mts_bludash_vanilla_frameshape: mts_bludash_frameshape {
        icon = QPATHTOF(data\blu\mts_markers_bludash_vanilla_frameshape.paa);
    };
    class mts_blu_hq: mts_blu_frameshape {
        icon = QPATHTOF(data\blu\mts_markers_blu_hq.paa);
    };
    class mts_red_frameshape: o_unknown {
        author = CSTRING(authors);
        scope = 0;
        icon = QPATHTOF(data\red\mts_markers_red_frameshape.paa);
        size = 256;
    };
    class mts_red_vanilla_frameshape: mts_red_frameshape {
        icon = QPATHTOF(data\red\mts_markers_red_vanilla_frameshape.paa);
    };
    class mts_reddash_frameshape: mts_red_frameshape {
        icon = QPATHTOF(data\red\mts_markers_reddash_frameshape.paa);
    };
    class mts_reddash_vanilla_frameshape: mts_reddash_frameshape {
        icon = QPATHTOF(data\red\mts_markers_reddash_vanilla_frameshape.paa);
    };
    class mts_red_hq: mts_red_frameshape {
        icon = QPATHTOF(data\red\mts_markers_red_hq.paa);
    };
    class mts_neu_frameshape: n_unknown {
        author = CSTRING(authors);
        scope = 0;
        icon = QPATHTOF(data\neu\mts_markers_neu_frameshape.paa);
        size = 256;
    };
    class mts_neu_vanilla_frameshape: mts_neu_frameshape {
        icon = QPATHTOF(data\neu\mts_markers_neu_vanilla_frameshape.paa);
    };
    class mts_neu_hq: mts_neu_frameshape {
        icon = QPATHTOF(data\neu\mts_markers_neu_hq.paa);
    };
    class mts_unk_frameshape: n_unknown {
        author = CSTRING(authors);
        scope = 0;
        icon = QPATHTOF(data\unk\mts_markers_unk_frameshape.paa);
        size = 256;
    };
    class mts_unk_vanilla_frameshape: mts_unk_frameshape {
        icon = QPATHTOF(data\unk\mts_markers_unk_vanilla_frameshape.paa);
    };
    class mts_unkdash_frameshape: mts_unk_frameshape {
        icon = QPATHTOF(data\unk\mts_markers_unkdash_frameshape.paa);
    };
    class mts_unkdash_vanilla_frameshape: mts_unkdash_frameshape {
        icon = QPATHTOF(data\unk\mts_markers_unkdash_vanilla_frameshape.paa);
    };
    class mts_unk_hq: mts_unk_frameshape {
        icon = QPATHTOF(data\unk\mts_markers_unk_hq.paa);
    };

    class mts_special_textmarker: b_unknown {
        author = CSTRING(authors);
        scope = 0;
        color[] = {0, 0, 0, 1};
        icon = QPATHTOF(data\mts_markers_special_textmarker.paa);
        size = 32;
    };

    #include "CfgMarkers\CfgMarkersIconsModifier.hpp"
    #include "CfgMarkers\CfgMarkersCommon.hpp"
    #include "CfgMarkers\CfgMarkersCharacters.hpp"
    #include "CfgMarkers\CfgMarkersDateTimeGroup.hpp"
    #include "CfgMarkers\CfgMarkersDirections.hpp"
};
