@wrapMethod(DamageSystem)
private final func ProcessOneShotProtection(hitEvent: ref<gameHitEvent>) -> Void {
    wrappedMethod(hitEvent);

    let target = hitEvent.target;
    
    let damages: array<Float>;
    damages = hitEvent.attackComputed.GetAttackValues();
    let i = 0;

    if (target.IsNPC() && StatusEffectSystem.ObjectHasStatusEffect(target, t"BaseStatusEffect.CE_Voodoo")) {
        while i < ArraySize(damages) {
          damages[i] *= 0.4;
          i += 1;
        };
    }


    hitEvent.attackComputed.SetAttackValues(damages);
}
           
