#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main"};
        author = CSTRING(authors);
        url = CSTRING(URL);
        VERSION_CONFIG;
    };
};

class CfgSettings {
    class CBA {
        class Versioning {
            class ADDON {
                main_addon = QUOTE(ADDON);
                class dependencies {
                    CBA[] = {"cba_main", REQUIRED_CBA_VERSION, "true"};
                };
            };
        };
    };
};

#include "CfgEventHandlers.hpp"
#include "Cfg3DEN.hpp"
#include "CfgMarkerColors.hpp"
#include "CfgMarkers.hpp"
#include "ui\mts_markers_dialog.hpp"
