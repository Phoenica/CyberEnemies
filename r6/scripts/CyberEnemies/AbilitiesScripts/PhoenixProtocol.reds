@wrapMethod(DamageSystem)
private final func ProcessOneShotProtection(hitEvent: ref<gameHitEvent>) -> Void {
    wrappedMethod(hitEvent);

    let target = hitEvent.target;
    
    let damages: array<Float>;
    damages = hitEvent.attackComputed.GetAttackValues();
    let i = 0;

    
    let statSys: ref<StatsSystem> = GameInstance.GetStatsSystem(GetGameInstance());
    let hasPhoenixProtocol: Float = statSys.GetStatValue(Cast<StatsObjectID>(hitEvent.target.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasPhoenixProtocol")));

    if (hasPhoenixProtocol > 0.0 && !StatusEffectSystem.ObjectHasStatusEffect(target, t"BaseStatusEffect.CEPhoenixProtocolMainEffect")) {
        if (target.IsNPC()) {
            let health = GameInstance.GetStatPoolsSystem(GetGameInstance()).GetStatPoolValue(Cast<StatsObjectID>(target.GetEntityID()), gamedataStatPoolType.Health);
            let healthPercentage = GameInstance.GetStatPoolsSystem(target.GetGame()).GetStatPoolValue(Cast<StatsObjectID>(target.GetEntityID()), gamedataStatPoolType.Health);

            if healthPercentage < 65.0 && hitEvent.attackComputed.GetTotalAttackValue(gamedataStatPoolType.Health) * 1.5 > health {
                (target as NPCPuppet).HandleCyberEnemiesPhoenixProtocolCheck();
            }
        }

    }

    if (StatusEffectSystem.ObjectHasStatusEffect(target, t"BaseStatusEffect.CEPhoenixProtocolInvincible")) {
        while i < ArraySize(damages) {
          damages[i] *= 0.1;
          i += 1;
        };
    }

    if (StatusEffectSystem.ObjectHasStatusEffect(target, t"BaseStatusEffect.CEPhoenixProtocolMainEffect")) {
        while i < ArraySize(damages) {
            let phoenixDamageReduction = Cast<Float>((target as NPCPuppet).phoenixCounter) / 5.0;
            damages[i] *= (0.2 + phoenixDamageReduction);
            i += 1;
        };
    }

    hitEvent.attackComputed.SetAttackValues(damages);
}


@addField(NPCPuppet)
public persistent let phoenixCounter: Int32 = 0;


@addMethod(NPCPuppet)
public func HandleCyberEnemiesPhoenixProtocolCheck() -> Bool { 
    let statSys: ref<StatsSystem> = GameInstance.GetStatsSystem(GetGameInstance());

    let hasPhoenixProtocol: Float = statSys.GetStatValue(Cast<StatsObjectID>(this.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasPhoenixProtocol")));

    if (hasPhoenixProtocol > 0.0) { 

        GameInstance.GetStatPoolsSystem(this.GetGame()).RequestChangingStatPoolValue(Cast<StatsObjectID>(this.GetEntityID()), gamedataStatPoolType.Health, 5, this, false, false);
        StatusEffectHelper.ApplyStatusEffect(this, t"BaseStatusEffect.CEPhoenixProtocolInvincible");
        StatusEffectHelper.ApplyStatusEffect(this, t"BaseStatusEffect.CEPhoenixProtocolMainEffect");
        StatusEffectHelper.ApplyStatusEffect(this, t"BaseStatusEffect.Knockdown");
        StatusEffectHelper.ApplyStatusEffect(this, t"BaseStatusEffect.Stun");
        this.HandleCyberEnemiesMLCheck();
        this.phoenixCounter += 1;

        return true;
    } else {
        return false;
    }
}
