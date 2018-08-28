class Extended_PreStart_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preStart));
    };
};

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};

//add cba keybind events to mission briefing display
class Extended_DisplayLoad_EventHandlers {
    class RscDiary {
        GVAR(briefingDisplayOpened) = QUOTE(\
            params ['_display'];\
            CHECK(!((ctrlIDD _display) isEqualTo MAP_BRIEFING_DISPLAY));\
            _display call (uiNamespace getVariable 'cba_events_fnc_initDisplayCurator');\
        );
    };
};
