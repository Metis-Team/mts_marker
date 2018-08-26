class Cfg3DEN {
    class Attributes {
        class Default;
        class GVAR(CategoryHider): Default {
            onLoad = "(ctrlParentControlsGroup ctrlParentControlsGroup (_this select 0)) ctrlShow false";
        };
    };

    class Mission {
        class Scenario {
            class AttributeCategories {
                class GVAR(category) {
                    collapsed = 1;
                    displayName = "";

                    class Attributes {
                        class GVAR(3denData) {
                            property = QGVAR(3denData);
                            value = 0;
                            control = QGVAR(CategoryHider);
                            displayName = "";
                            tooltip = "";
                            defaultValue = "[]";
                            expression = "";
                            wikiType = "[[Array]]";
                        };
                    };
                };
            };
        };
    };
};
