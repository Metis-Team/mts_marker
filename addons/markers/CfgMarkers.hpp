class CfgMarkers {
    #define MARKERFILE(TYPE,MODIFIER,NAME) mts_markers_##TYPE##_##MODIFIER##_##NAME##.paa
    #define MARKER(TYPE,MODIFIER,NAME) \
    class mts_##TYPE##_##MODIFIER##_##NAME##: mts_##TYPE##_frameshape { \
        icon = PATHTOF(data\TYPE\MODIFIER\MARKERFILE(TYPE,MODIFIER,NAME)); \
    }
    #define NUMMARKER(TYPE,POSITION,NUMBER) \
    class mts_##TYPE##_num_##POSITION##_##NUMBER##: mts_##TYPE##_frameshape { \
        icon = PATHTOF(data\TYPE\num\POSITION\MARKERFILE(TYPE,POSITION,NUMBER)); \
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
    class mts_bludash_frameshape: mts_blu_frameshape {
        icon = QPATHTOF(data\blu\mts_markers_bludash_frameshape.paa);
    };
    class mts_red_frameshape: o_unknown {
        author = CSTRING(authors);
        scope = 0;
        icon = QPATHTOF(data\red\mts_markers_red_frameshape.paa);
        size = 256;
    };
    class mts_reddash_frameshape: mts_red_frameshape {
        icon = QPATHTOF(data\red\mts_markers_reddash_frameshape.paa);
    };
    class mts_neu_frameshape: n_unknown {
        author = CSTRING(authors);
        scope = 0;
        icon = QPATHTOF(data\neu\mts_markers_neu_frameshape.paa);
        size = 256;
    };
    class mts_unk_frameshape: n_unknown {
        author = CSTRING(authors);
        scope = 0;
        icon = QPATHTOF(data\unk\mts_markers_unk_frameshape.paa);
        size = 256;
    };
    class mts_unkdash_frameshape: mts_unk_frameshape {
        icon = QPATHTOF(data\unk\mts_markers_unkdash_frameshape.paa);
    };

    class mts_special_textmarker: b_unknown {
        author = CSTRING(authors);
        scope = 0;
        color[] = {0, 0, 0, 1};
        icon = QPATHTOF(data\mts_markers_special_textmarker.paa);
        size = 32;
    };

    #include "CfgMarkersBlufor.hpp"
    #include "CfgMarkersRedfor.hpp"
    #include "CfgMarkersNeutral.hpp"
    #include "CfgMarkersUnknown.hpp"
};
