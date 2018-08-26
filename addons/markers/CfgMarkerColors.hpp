class CfgMarkerColors {
    class Default;
    class mts_blu_color: Default {
        author = CSTRING(authors);
        scope = 0;
        color[] = {0.502, 0.878, 1, 1};
    };
    class mts_red_color: mts_blu_color {
        color[] = {1, 0.502, 0.502, 1};
    };
    class mts_neu_color: mts_blu_color {
        color[] = {0.667, 1, 0.667, 1};
    };
    class mts_unk_color: mts_blu_color {
        color[] = {1, 1, 0.502, 1};
    };
};
