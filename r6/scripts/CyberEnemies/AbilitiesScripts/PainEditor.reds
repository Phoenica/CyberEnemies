import CyberEnemies.Configurations.*
import CyberEnemies.Utils.*

@wrapMethod(DamageSystem)
private final func ProcessOneShotProtection(hitEvent: ref<gameHitEvent>) -> Void {
    wrappedMethod(hitEvent);

    let target = hitEvent.target;
    
    let damages: array<Float>;
    damages = hitEvent.attackComputed.GetAttackValues();
    let i = 0;

    if (StatusEffectSystem.ObjectHasStatusEffect(target, t"BaseStatusEffect.CE_PainEditorEffect") && CheckCommonRestrictions((target as NPCPuppet), false, false)) {
        let damageReduction = (new CyberEnemiesSettings()).painEditorDamageReduction;
        while i < ArraySize(damages) {
          damages[i] *= 1.0 - (damageReduction / 100.0);
          i += 1;
        };
    }

    hitEvent.attackComputed.SetAttackValues(damages);
}



