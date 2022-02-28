class Extended_PreStart_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_SCRIPT(XEH_preStart));
    };
};

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_SCRIPT(XEH_preInit));
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_SCRIPT(XEH_postInit));
    };
};

//add cba keybind events to mission briefing display
class Extended_DisplayLoad_EventHandlers {
    class RscDiary {
        GVAR(briefingDisplayOpened) = QUOTE(call FUNC(onBriefingDisplayOpened));
    };
};
