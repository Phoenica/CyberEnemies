@addField(NPCPuppet)
public persistent let cybEnemiesMLHandled: Bool = false;

@addMethod(NPCPuppet)
private func HandleCyberEnemiesMLCheck() {
    let statSys: ref<StatsSystem> = GameInstance.GetStatsSystem(GetGameInstance());
    
    if (this.cybEnemiesMLHandled) {
        return;
    }

    this.cybEnemiesMLHandled = true;

    let hasML: Float = statSys.GetStatValue(Cast<StatsObjectID>(this.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasMachineLearning")));

    if (hasML > 0.0) {    
        let entities = GetPlayer(GetGameInstance()).GetEntitiesAroundObject(50.0, TSF_NPC());

        let i = 0;
        while (i < ArraySize(entities)) {
            let otherEnt = entities[i];
            let entHasLM: Float = statSys.GetStatValue(Cast<StatsObjectID>(otherEnt.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasMachineLearning")));

            if (entHasLM > 0.0) {
                let options: array<CName> = [];

                if (statSys.GetStatValue(Cast<StatsObjectID>(otherEnt.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"HasKerenzikov"))) == 0.0) {
                    ArrayPush(options, n"Kers");
                }

                if (statSys.GetStatValue(Cast<StatsObjectID>(otherEnt.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"HasSandevistanTier3"))) == 0.0) {
                    if (statSys.GetStatValue(Cast<StatsObjectID>(otherEnt.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"HasSandevistanTier2"))) == 0.0) {
                        if (statSys.GetStatValue(Cast<StatsObjectID>(otherEnt.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"HasSandevistanTier1"))) == 0.0) {
                            ArrayPush(options, n"Sandi1");
                        } else {
                            ArrayPush(options, n"Sandi2");
                        }
                    } else {
                        ArrayPush(options, n"Sandi3");
                    }
                }

                if (statSys.GetStatValue(Cast<StatsObjectID>(otherEnt.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"IMSABonusAccuracy"))) != 1.0) {
                    ArrayPush(options, n"ACC");
                }

                if (!StatusEffectSystem.ObjectHasStatusEffect(otherEnt as GameObject, t"BaseStatusEffect.CEMachineLearningDisrupt")) {
                    ArrayPush(options, n"Disrupt");
                }

                if (ArraySize(options) > 0) {
                    let randomSkill = options[RandRange(0, ArraySize(options) - 1)];


                    if (Equals(randomSkill, n"QHRes1")) {
                        StatusEffectHelper.ApplyStatusEffect(otherEnt as GameObject, t"BaseStatusEffect.CEHackResistance"); // todo - not working 
                    }

                    if (Equals(randomSkill, n"Disrupt")) {
                        StatusEffectHelper.ApplyStatusEffect(otherEnt as GameObject, t"BaseStatusEffect.CEMachineLearningDisrupt");
                    }

                    if (Equals(randomSkill, n"Sandi3")) {
                        StatusEffectHelper.RemoveStatusEffect(otherEnt as GameObject, t"BaseStatusEffect.CEMachineLearningSandevistan2");    
                        StatusEffectHelper.ApplyStatusEffect(otherEnt as GameObject, t"BaseStatusEffect.CEMachineLearningSandevistan3");
                    }

                    if (Equals(randomSkill, n"Sandi2")) {
                        StatusEffectHelper.RemoveStatusEffect(otherEnt as GameObject, t"BaseStatusEffect.CEMachineLearningSandevistan1");    
                        StatusEffectHelper.ApplyStatusEffect(otherEnt as GameObject, t"BaseStatusEffect.CEMachineLearningSandevistan2");
                    }

                    if (Equals(randomSkill, n"Sandi1")) {
                        StatusEffectHelper.ApplyStatusEffect(otherEnt as GameObject, t"BaseStatusEffect.CEMachineLearningSandevistan1");
                    }

                    if (Equals(randomSkill, n"ACC")) {
                        StatusEffectHelper.ApplyStatusEffect(otherEnt as GameObject, t"BaseStatusEffect.CEMachineLearningACC");
                    }

                    if (Equals(randomSkill, n"Kers")) {
                        StatusEffectHelper.ApplyStatusEffect(otherEnt as GameObject, t"BaseStatusEffect.CEMachineLearningKerenzikov");
                    }
                }
            }

            i += 1;
        }

    }
}

@wrapMethod(NPCPuppet)
protected cb func OnDeath(evt: ref<gameDeathEvent>) -> Bool {
    this.HandleCyberEnemiesMLCheck();

    return wrappedMethod(evt);
}


@wrapMethod(NPCPuppet)
protected cb func OnStatusEffectApplied(evt: ref<ApplyStatusEffectEvent>) -> Bool {
    let gmplTags: array<CName> = evt.staticData.GameplayTags();
    
    let defeat = ArrayContains(gmplTags, n"Defeated");
    
    if (defeat) {
        this.HandleCyberEnemiesMLCheck();
    }

    return wrappedMethod(evt);
}
