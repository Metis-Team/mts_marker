class CfgMarkers {
    #define MARKERFILE(TYPE,MODIFIER,NAME) mts_markers_##TYPE##_##MODIFIER##_##NAME##.paa
    #define MARKER(TYPE,MODIFIER,NAME) \
    class mts_##TYPE##_##MODIFIER##_##NAME##: mts_##TYPE##_frameshape { \
        icon = QPATHTOF(data\TYPE\MODIFIER\MARKERFILE(TYPE,MODIFIER,NAME)); \
    }
    #define NUMMARKER(TYPE,POSITION,NUMBER) \
    class mts_##TYPE##_num_##POSITION##_##NUMBER##: mts_##TYPE##_frameshape { \
        icon = QPATHTOF(data\TYPE\num\POSITION\MARKERFILE(TYPE,POSITION,NUMBER)); \
    }
    #define COMMARKER(MODIFIER,NAME) \
    class mts_com_##MODIFIER##_##NAME##: mts_blu_frameshape { \
        icon = QPATHTOF(data\com\MODIFIER\MARKERFILE(com,MODIFIER,NAME)); \
    }
    #define ALPHANUMMARKERFILE(ANCHOR,POSITION,LETTER) mts_markers_alphanum_##ANCHOR##_##POSITION##_##LETTER##.paa
    #define ALPHANUMMARKER(ANCHOR,POSITION,LETTER) \
    class mts_alphanum_##ANCHOR##_##POSITION##_##LETTER##: mts_blu_frameshape { \
        icon = QPATHTOF(data\alphanum\ANCHOR\POSITION\ALPHANUMMARKERFILE(ANCHOR,POSITION,LETTER)); \
    }
    #define SPECIALCHARMARKERFILE(ANCHOR,POSITION,LETTER) mts_markers_special_##ANCHOR##_##POSITION##_##LETTER##.paa
    #define SPECIALCHARMARKER(ANCHOR,POSITION,LETTER) \
    class mts_special_##ANCHOR##_##POSITION##_##LETTER##: mts_blu_frameshape { \
        icon = QPATHTOF(data\special\ANCHOR\POSITION\SPECIALCHARMARKERFILE(ANCHOR,POSITION,LETTER)); \
    }
    #define DTGMARKERFILE(POSITION,LETTER) mts_markers_dtg_##POSITION##_##LETTER##.paa
    #define DTGMARKER(POSITION,LETTER) \
    class mts_dtg_##POSITION##_##LETTER##: mts_blu_frameshape { \
        icon = QPATHTOF(data\dtg\POSITION\DTGMARKERFILE(POSITION,LETTER)); \
    }

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
    class mts_neu_frameshape: n_unknown {
        author = CSTRING(authors);
        scope = 0;
        icon = QPATHTOF(data\neu\mts_markers_neu_frameshape.paa);
        size = 256;
    };
    class mts_neu_vanilla_frameshape: mts_neu_frameshape {
        icon = QPATHTOF(data\neu\mts_markers_neu_vanilla_frameshape.paa);
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

    class mts_special_textmarker: b_unknown {
        author = CSTRING(authors);
        scope = 0;
        color[] = {0, 0, 0, 1};
        icon = QPATHTOF(data\mts_markers_special_textmarker.paa);
        size = 32;
    };

    #include "CfgMarkers\CfgMarkersBlufor.hpp"
    #include "CfgMarkers\CfgMarkersRedfor.hpp"
    #include "CfgMarkers\CfgMarkersNeutral.hpp"
    #include "CfgMarkers\CfgMarkersUnknown.hpp"
    #include "CfgMarkers\CfgMarkersCommon.hpp"
    #include "CfgMarkers\CfgMarkersCharacters.hpp"
    #include "CfgMarkers\CfgMarkersDateTimeGroup.hpp"
};
