// COMPONENT should be defined in the script_component.hpp and included BEFORE this hpp

#define MAINPREFIX z
#define PREFIX mts

#include "script_version.hpp"

#define VERSION MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD

#define MTS_TAG MTS

// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 1.84

#ifdef COMPONENT_BEAUTIFIED
    #define COMPONENT_NAME QUOTE(mts - COMPONENT_BEAUTIFIED)
#else
    #define COMPONENT_NAME QUOTE(mts - COMPONENT)
#endif
