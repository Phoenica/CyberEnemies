@wrapMethod(PlayerPuppet)
protected cb func OnStatusEffectApplied(evt: ref<ApplyStatusEffectEvent>) -> Bool {
    if Equals(evt.staticData.GetID(), t"BaseStatusEffect.KurtTakedown_01_Effect") {
        StatusEffectHelper.ApplyStatusEffect(this, t"BaseStatusEffect.KurtSlow");  
    }

    if Equals(evt.staticData.GetID(), t"BaseStatusEffect.KurtTakedown_02_Effect") {
        StatusEffectHelper.ApplyStatusEffect(this, t"BaseStatusEffect.KurtDisarm");  
    }

    return wrappedMethod(evt);
}