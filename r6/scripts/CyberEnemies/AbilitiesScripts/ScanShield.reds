
// @wrapMethod(ScannerAbilitiesGameController)
// protected cb func OnAbilitiesChanged(value: Variant) -> Bool {
//     let abilitiesData: array<wref<GameplayAbility_Record>> = FromVariant<ref<ScannerAbilities>>(value).GetAbilities();
//     let hasScanShield = false;
//     let statSystem = GameInstance.GetStatsSystem(GetGameInstance());
//     let i = 0;

//     while i < ArraySize(abilitiesData) {
        
//         if(Equals(abilitiesData[i].GetID(), t"Ability.CEScanShield")){
//             hasScanShield = true;
//         }
//         i += 1;
//     }
//     let rootWidget: wref<inkVerticalPanel> = ((this.GetRootWidget() as inkVerticalPanel).GetParentWidget() as inkVerticalPanel);

//     if (hasScanShield && statSystem.GetStatValue(Cast<StatsObjectID>(GetPlayer(GetGameInstance()).GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasGoodKiroshi"))) == 0.0) {
//         rootWidget.SetVisible(false);
//     } else {
//         rootWidget.SetVisible(true);
//     }



//     return wrappedMethod(value);
// }

@if(ModuleExists("LifePathBonuses"))
@wrapMethod(ScannervehicleGameController)
private final func UpdateGlobalVisibility() -> Void {
    let value = this.m_chunkBlackboard.GetVariant(this.m_chunkBlackboardDef.ScannerAbilities);
    let abilitiesData: array<wref<GameplayAbility_Record>> = FromVariant<ref<ScannerAbilities>>(value).GetAbilities();
    let hasScanShield = false;
    let hasScavScanShield = false;
    let hasHoloScanShield = false;
    let statSystem = GameInstance.GetStatsSystem(GetGameInstance());
    let i = 0;
    while i < ArraySize(abilitiesData) {
        if(Equals(abilitiesData[i].GetID(), t"Ability.CEScavScanShield")){
            hasScavScanShield = true;
        }
        
        if(Equals(abilitiesData[i].GetID(), t"Ability.CEScanShield")){
            hasScanShield = true;
        }
        if(Equals(abilitiesData[i].GetID(), t"Ability.CEScanShieldHologram")){
            hasHoloScanShield = true;
        }
        i += 1;
    }
    if (hasScanShield && statSystem.GetStatValue(Cast<StatsObjectID>(GetPlayer(GetGameInstance()).GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasGoodKiroshi"))) == 0.0 ||
        (hasScavScanShield && statSystem.GetStatValue(Cast<StatsObjectID>(GetPlayer(GetGameInstance()).GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasMehKiroshi"))) == 0.0) || 
        hasHoloScanShield) {
        this.GetRootWidget().SetVisible(false);
    } else {
        wrappedMethod();
    }
}

@wrapMethod(ScannerNPCHeaderGameController)
private final func UpdateGlobalVisibility() -> Void {
    let value = this.m_chunkBlackboard.GetVariant(this.m_chunkBlackboardDef.ScannerAbilities);
    let abilitiesData: array<wref<GameplayAbility_Record>> = FromVariant<ref<ScannerAbilities>>(value).GetAbilities();
    let hasScanShield = false;
    let hasScavScanShield = false;
    let hasHoloScanShield = false;
    let statSystem = GameInstance.GetStatsSystem(GetGameInstance());
    let i = 0;

    while i < ArraySize(abilitiesData) {
        
        if(Equals(abilitiesData[i].GetID(), t"Ability.CEScavScanShield")){
            hasScavScanShield = true;
        }

        if(Equals(abilitiesData[i].GetID(), t"Ability.CEScanShield")){
            hasScanShield = true;
        }

        if(Equals(abilitiesData[i].GetID(), t"Ability.CEScanShieldHologram")){
            hasHoloScanShield = true;
        }
        
        i += 1;
    }

    if ((hasScanShield && statSystem.GetStatValue(Cast<StatsObjectID>(GetPlayer(GetGameInstance()).GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasGoodKiroshi"))) == 0.0) ||
        (hasScavScanShield && statSystem.GetStatValue(Cast<StatsObjectID>(GetPlayer(GetGameInstance()).GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasMehKiroshi"))) == 0.0) || 
        hasHoloScanShield
    ) {
        this.GetRootWidget().SetVisible(true);
        if (hasScavScanShield) {
            inkTextRef.SetText(this.m_nameText, GetLocalizedTextByKey(n"cyberEnemies_effectName_unscanable_scav"));
        } else {
            inkTextRef.SetText(this.m_nameText, GetLocalizedTextByKey(n"cyberEnemies_effectName_unscanable"));
        }
        inkWidgetRef.SetVisible(this.m_archetypeIcon, false);
    } else {
        wrappedMethod();
    }
}

@wrapMethod(ScannerNPCBodyGameController)
private final func UpdateGlobalVisibility() -> Void {
    let value = this.m_chunkBlackboard.GetVariant(this.m_chunkBlackboardDef.ScannerAbilities);
    let abilitiesData: array<wref<GameplayAbility_Record>> = FromVariant<ref<ScannerAbilities>>(value).GetAbilities();
    let hasScanShield = false;
    let hasScavScanShield = false;
    let hasHoloScanShield = false;
    let statSystem = GameInstance.GetStatsSystem(GetGameInstance());
    let i = 0;

    while i < ArraySize(abilitiesData) {
        if(Equals(abilitiesData[i].GetID(), t"Ability.CEScavScanShield")){
            hasScavScanShield = true;
        }

        if(Equals(abilitiesData[i].GetID(), t"Ability.CEScanShield")){
            hasScanShield = true;
        }

        if(Equals(abilitiesData[i].GetID(), t"Ability.CEScanShieldHologram")){
            hasHoloScanShield = true;
        }
        i += 1;
    }

    if (hasScanShield && statSystem.GetStatValue(Cast<StatsObjectID>(GetPlayer(GetGameInstance()).GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasGoodKiroshi"))) == 0.0 ||
        (hasScavScanShield && statSystem.GetStatValue(Cast<StatsObjectID>(GetPlayer(GetGameInstance()).GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasMehKiroshi"))) == 0.0) || 
        hasHoloScanShield) {
        this.GetRootWidget().SetVisible(false);
    } else {
        wrappedMethod();
    }
}

@wrapMethod(ScannerBountySystemGameController)
private final func UpdateGlobalVisibility() -> Void {
    let value = this.m_chunkBlackboard.GetVariant(this.m_chunkBlackboardDef.ScannerAbilities);
    let abilitiesData: array<wref<GameplayAbility_Record>> = FromVariant<ref<ScannerAbilities>>(value).GetAbilities();
    let hasScanShield = false;
    let hasScavScanShield = false;
    let hasHoloScanShield = false;
    let statSystem = GameInstance.GetStatsSystem(GetGameInstance());
    let i = 0;

    while i < ArraySize(abilitiesData) {
        if(Equals(abilitiesData[i].GetID(), t"Ability.CEScavScanShield")){
            hasScavScanShield = true;
        }

        if(Equals(abilitiesData[i].GetID(), t"Ability.CEScanShield")){
            hasScanShield = true;
        }

        if(Equals(abilitiesData[i].GetID(), t"Ability.CEScanShieldHologram")){
            hasHoloScanShield = true;
        }
        i += 1;
    }

    if (hasScanShield && statSystem.GetStatValue(Cast<StatsObjectID>(GetPlayer(GetGameInstance()).GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasGoodKiroshi"))) == 0.0 ||
        (hasScavScanShield && statSystem.GetStatValue(Cast<StatsObjectID>(GetPlayer(GetGameInstance()).GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasMehKiroshi"))) == 0.0) || 
        hasHoloScanShield) {
        this.GetRootWidget().SetVisible(false);
    } else {
        wrappedMethod();
    }
}

@wrapMethod(ScannerVulnerabilitiesGameController)
private final func UpdateGlobalVisibility() -> Void {
    let value = this.m_chunkBlackboard.GetVariant(this.m_chunkBlackboardDef.ScannerAbilities);
    let abilitiesData: array<wref<GameplayAbility_Record>> = FromVariant<ref<ScannerAbilities>>(value).GetAbilities();
    let hasScanShield = false;
    let hasScavScanShield = false;
    let hasHoloScanShield = false;
    let statSystem = GameInstance.GetStatsSystem(GetGameInstance());
    let i = 0;

    while i < ArraySize(abilitiesData) {
        if(Equals(abilitiesData[i].GetID(), t"Ability.CEScavScanShield")){
            hasScavScanShield = true;
        }
        
        if(Equals(abilitiesData[i].GetID(), t"Ability.CEScanShield")){
            hasScanShield = true;
        }
        
        if(Equals(abilitiesData[i].GetID(), t"Ability.CEScanShieldHologram")){
            hasHoloScanShield = true;
        }
        i += 1;
    }

    if (hasScanShield && statSystem.GetStatValue(Cast<StatsObjectID>(GetPlayer(GetGameInstance()).GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasGoodKiroshi"))) == 0.0 ||
        (hasScavScanShield && statSystem.GetStatValue(Cast<StatsObjectID>(GetPlayer(GetGameInstance()).GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasMehKiroshi"))) == 0.0) || 
        hasHoloScanShield) {
        this.GetRootWidget().SetVisible(false);
    } else {
        wrappedMethod();
    }
}

@wrapMethod(ScannerResistancesGameController)
private final func UpdateGlobalVisibility() -> Void {
    let value = this.m_chunkBlackboard.GetVariant(this.m_chunkBlackboardDef.ScannerAbilities);
    let abilitiesData: array<wref<GameplayAbility_Record>> = FromVariant<ref<ScannerAbilities>>(value).GetAbilities();
    let hasScanShield = false;
    let hasScavScanShield = false;
    let hasHoloScanShield = false;
    let statSystem = GameInstance.GetStatsSystem(GetGameInstance());
    let i = 0;

    while i < ArraySize(abilitiesData) {
        if(Equals(abilitiesData[i].GetID(), t"Ability.CEScavScanShield")){
            hasScavScanShield = true;
        }
        
        if(Equals(abilitiesData[i].GetID(), t"Ability.CEScanShield")){
            hasScanShield = true;
        }

        if(Equals(abilitiesData[i].GetID(), t"Ability.CEScanShieldHologram")){
            hasHoloScanShield = true;
        }
        i += 1;
    }

    if (hasScanShield && statSystem.GetStatValue(Cast<StatsObjectID>(GetPlayer(GetGameInstance()).GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasGoodKiroshi"))) == 0.0 ||
        (hasScavScanShield && statSystem.GetStatValue(Cast<StatsObjectID>(GetPlayer(GetGameInstance()).GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasMehKiroshi"))) == 0.0) || 
        hasHoloScanShield) {
        this.GetRootWidget().SetVisible(false);
    } else {
        wrappedMethod();
    }
}


@wrapMethod(ScannerDescriptionGameController)
private final func UpdateGlobalVisibility() -> Void {
    let value = this.m_chunkBlackboard.GetVariant(this.m_chunkBlackboardDef.ScannerAbilities);
    let abilitiesData: array<wref<GameplayAbility_Record>> = FromVariant<ref<ScannerAbilities>>(value).GetAbilities();
    let hasScanShield = false;
    let hasScavScanShield = false;
    let hasHoloScanShield = false;
    let statSystem = GameInstance.GetStatsSystem(GetGameInstance());
    let i = 0;

    while i < ArraySize(abilitiesData) {
        if(Equals(abilitiesData[i].GetID(), t"Ability.CEScavScanShield")){
            hasScavScanShield = true;
        }
        
        if(Equals(abilitiesData[i].GetID(), t"Ability.CEScanShield")){
            hasScanShield = true;
        }

        if(Equals(abilitiesData[i].GetID(), t"Ability.CEScanShieldHologram")){
            hasHoloScanShield = true;
        }
        i += 1;
    }

    if (hasScanShield && statSystem.GetStatValue(Cast<StatsObjectID>(GetPlayer(GetGameInstance()).GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasGoodKiroshi"))) == 0.0 ||
        (hasScavScanShield && statSystem.GetStatValue(Cast<StatsObjectID>(GetPlayer(GetGameInstance()).GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasMehKiroshi"))) == 0.0) || 
        hasHoloScanShield) {
        this.GetRootWidget().SetVisible(false);
    } else {
        wrappedMethod();
    }
}

@wrapMethod(ScannerAbilitiesGameController)
private final func UpdateGlobalVisibility() -> Void {
    let value = this.m_chunkBlackboard.GetVariant(this.m_chunkBlackboardDef.ScannerAbilities);
    let abilitiesData: array<wref<GameplayAbility_Record>> = FromVariant<ref<ScannerAbilities>>(value).GetAbilities();
    let hasScanShield = false;
    let hasScavScanShield = false;
    let hasHoloScanShield = false;
    let statSystem = GameInstance.GetStatsSystem(GetGameInstance());
    let i = 0;

    while i < ArraySize(abilitiesData) {
        if(Equals(abilitiesData[i].GetID(), t"Ability.CEScavScanShield")){
            hasScavScanShield = true;
        }
        
        if(Equals(abilitiesData[i].GetID(), t"Ability.CEScanShield")){
            hasScanShield = true;
        }

        if(Equals(abilitiesData[i].GetID(), t"Ability.CEScanShieldHologram")){
            hasHoloScanShield = true;
        }
        i += 1;
    }

    if (hasScanShield && statSystem.GetStatValue(Cast<StatsObjectID>(GetPlayer(GetGameInstance()).GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasGoodKiroshi"))) == 0.0 ||
        (hasScavScanShield && statSystem.GetStatValue(Cast<StatsObjectID>(GetPlayer(GetGameInstance()).GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasMehKiroshi"))) == 0.0) || 
        hasHoloScanShield) {
        this.GetRootWidget().SetVisible(false);

    } else {
        wrappedMethod();
    }
}