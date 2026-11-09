@addField(NPCPuppet)
public persistent let cybEnemiesSecondHeartHandled: Bool = false;

@wrapMethod(DamageSystem)
private final func ProcessOneShotProtection(hitEvent: ref<gameHitEvent>) -> Void {
    wrappedMethod(hitEvent);

    let target = hitEvent.target;
    
    let damages: array<Float>;
    damages = hitEvent.attackComputed.GetAttackValues();
    let i = 0;

    
    let statSys: ref<StatsSystem> = GameInstance.GetStatsSystem(GetGameInstance());
    let hasSecondHeart: Float = statSys.GetStatValue(Cast<StatsObjectID>(hitEvent.target.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasSantaMuerte")));

    if (hasSecondHeart > 0.0) {
        if (target.IsNPC()) {
            let health = GameInstance.GetStatPoolsSystem(GetGameInstance()).GetStatPoolValue(Cast<StatsObjectID>(target.GetEntityID()), gamedataStatPoolType.Health);
            let healthPercentage = GameInstance.GetStatPoolsSystem(target.GetGame()).GetStatPoolValue(Cast<StatsObjectID>(target.GetEntityID()), gamedataStatPoolType.Health);

            if healthPercentage < 60.0 && hitEvent.attackComputed.GetTotalAttackValue(gamedataStatPoolType.Health) * 1.4 > health && !hitEvent.projectionPipeline {
                (target as NPCPuppet).HandleCyberEnemiesSecondHeartCheck();
            }
        }

    }

    if (StatusEffectSystem.ObjectHasStatusEffect(target, t"BaseStatusEffect.CESecondHeartInvincible")) {
        while i < ArraySize(damages) {
          damages[i] *= 0.0;
          i += 1;
        };
    }

    if (StatusEffectSystem.ObjectHasStatusEffect(target, t"BaseStatusEffect.CESecondHeartMainEffect")) {
        while i < ArraySize(damages) {
          damages[i] *= 0.1;
          i += 1;
        };
    }

    hitEvent.attackComputed.SetAttackValues(damages);
}

@addMethod(NPCPuppet)
public func HandleCyberEnemiesSecondHeartCheck() -> Bool { 
    let statSys: ref<StatsSystem> = GameInstance.GetStatsSystem(GetGameInstance());
    
    if (this.cybEnemiesSecondHeartHandled) {
        return false;
    }

    this.cybEnemiesSecondHeartHandled = true;

    let hasSecondHeart: Float = statSys.GetStatValue(Cast<StatsObjectID>(this.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasSantaMuerte")));

    if (hasSecondHeart > 0.0) { 
        GameInstance.GetStatPoolsSystem(this.GetGame()).RequestChangingStatPoolValue(Cast<StatsObjectID>(this.GetEntityID()), gamedataStatPoolType.Health, 5, this, false, false);
        StatusEffectHelper.ApplyStatusEffect(this, t"BaseStatusEffect.CESecondHeartInvincible");
        StatusEffectHelper.ApplyStatusEffect(this, t"BaseStatusEffect.CESecondHeartMainEffect");
        StatusEffectHelper.ApplyStatusEffect(this, t"BaseStatusEffect.Knockdown");

        return true;
    } else {
        return false;
    }
}
