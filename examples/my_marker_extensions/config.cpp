class CfgPatches {
    class MyMtsMarkerExtensionMod {
        name = "My Metis Marker Extension Mod";
        units[] = {};
        weapons[] = {};
        requiredVersion = 2.10;
        requiredAddons[] = {"mts_markers"};
        author = "";
        authors[] = {"Timi007"};
        version = 1.0;
        versionStr = "1.0";
        versionAr[] = {1,0};
    };
};

class mts_markers_extensions {
    class MyMtsMarkerExtensionMod {
        // Standalone marker
        class sar { // Unique marker name
            type = "icon"; // Available types: icon, mod1, mod2, echelon
            displayName = "Search and Rescue"; // Name to display in UT dropdown
            icon = "MyMtsMarkerExtensionMod\data\ui\myext_mod_sar.paa"; // Path to UI icon for dropdown entry
            markerClassFormat = "myext_%1_mod_sar"; // Marker classes of all sides found in CfgMarkers. %1 is side, i.e. blu, red, neu, unk.
        };

        // Composite marker
        class reconnaissance_rotary_wing { // Unique marker name
            type = "icon"; // Available types: icon, mod1, mod2, echelon
            components[] = {"reconnaissance", "rotary_wing"}; // Markers with which to construct this marker.
            displayName = "Rotary Wing Reconnaissance"; // Name to display in UT dropdown
            icon = "MyMtsMarkerExtensionMod\data\ui\my_new_reconnaissance_rotary_wing_ui_marker.paa"; // Path to UI icon for dropdown entry
        };
    };
};

class CfgMarkers {
    class mts_blu_frameshape;
    class myext_blu_mod_sar: mts_blu_frameshape {
        author = "Timi007";
        icon = "MyMtsMarkerExtensionMod\data\blu\my_new_blu_sar_marker.paa";
    };

    class mts_red_frameshape;
    class myext_red_mod_sar: mts_red_frameshape {
        author = "Timi007";
        icon = "MyMtsMarkerExtensionMod\data\red\my_new_red_sar_marker.paa";
    };

    class mts_neu_frameshape;
    class myext_neu_mod_sar: mts_neu_frameshape {
        author = "Timi007";
        icon = "MyMtsMarkerExtensionMod\data\neu\my_new_neu_sar_marker.paa";
    };

    class mts_unk_frameshape;
    class myext_unk_mod_sar: mts_unk_frameshape {
        author = "Timi007";
        icon = "MyMtsMarkerExtensionMod\data\unk\my_new_unk_sar_marker.paa";
    };
};
