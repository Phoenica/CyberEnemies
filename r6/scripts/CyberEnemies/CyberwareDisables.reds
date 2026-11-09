@wrapMethod(NPCPuppet)
protected cb func OnStatusEffectApplied(evt: ref<ApplyStatusEffectEvent>) -> Bool {
    if (Equals(this.GetRecordID(), t"Character.sts_wat_nid_01_cyberpsycho") && Equals("AIQuickHackStatusEffect.HackBurning", TDBID.ToStringDEBUG((evt.staticData.GetID())))) {
        StatusEffectHelper.ApplyStatusEffect(this, t"BaseStatusEffect.PernamentCyberwareDisable");  
    }

    return wrappedMethod(evt);
}