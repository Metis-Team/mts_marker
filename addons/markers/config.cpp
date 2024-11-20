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
#include "ui\dialog.hpp"

class GVAR(dimensions) {
    class land_unit { // Unique dimension id. This is used in the API to identify the dimension of the marker. This name must be stable.
        name = CSTRING(ui_dimensions_landUnit); // Name of the dimension (i.e. UI button)
        priority = 0; // Priorty determines the button order in the UI. Lowest -> Left

        // Implement hooks
        uiCreate = QUOTE(_this call FUNC(createConfigurationUI));
        uiGetData = QUOTE(_this call FUNC(getUIData));
        uiSetData = QUOTE(_this call FUNC(setUIData));
        uiGetPreviewImages = QUOTE(_this call FUNC(getPreviewImages));
        uiValidateData = QUOTE(_this call FUNC(validateUIData));

        createMarker = QUOTE(_this call FUNC(createLandUnitMarker));
    };
};
