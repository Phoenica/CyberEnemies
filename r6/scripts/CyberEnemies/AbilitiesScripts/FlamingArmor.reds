module CyberEnemies.FlamingArmor

public class FlameEffector extends ModifyAttackEffector {
  private let game: GameInstance;
  private let damageEffectId: TweakDBID;

  protected func Initialize(record: TweakDBID, game: GameInstance, parentRecord: TweakDBID) -> Void {
  }

  protected func ActionOn(owner: ref<GameObject>) -> Void {
    this.ProcessAction(owner);
  }

  protected func RepeatedAction(owner: ref<GameObject>) -> Void {
    this.ProcessAction(owner);
  }

  private final func ProcessAction(owner: ref<GameObject>) -> Void {
    let damage: Float;
    let hitEvent: ref<gameHitEvent> = this.GetHitEvent();
    if !IsDefined(hitEvent) {
      return;
    };

    let source: ref<GameObject> = hitEvent.attackData.source;
    
    if source.IsPlayer() && WeaponObject.IsFists(GameObject.GetActiveWeapon(source).GetItemID()) {
      let randomNumber = RandRange(0, 100);

      if (!StatusEffectSystem.ObjectHasStatusEffect(source, t"BaseStatusEffect.CE_FlameArmorCooldown")) {
          StatusEffectHelper.ApplyStatusEffect(source, t"BaseStatusEffect.CE_FlameArmorActivation");
      }

      if (randomNumber > 35) {
        StatusEffectHelper.ApplyStatusEffect(source, t"BaseStatusEffect.Burning");
      }
    };
  }
}

public class FlameEffector2 extends ModifyAttackEffector {
  private let game: GameInstance;
  private let damageEffectId: TweakDBID;

  protected func Initialize(record: TweakDBID, game: GameInstance, parentRecord: TweakDBID) -> Void {
  }

  protected func ActionOn(owner: ref<GameObject>) -> Void {
    this.ProcessAction(owner);
  }

  protected func RepeatedAction(owner: ref<GameObject>) -> Void {
    this.ProcessAction(owner);
  }

  private final func ProcessAction(owner: ref<GameObject>) -> Void {
    let damage: Float;
    let hitEvent: ref<gameHitEvent> = this.GetHitEvent();
    if !IsDefined(hitEvent) {
      return;
    };

    let target: ref<GameObject> = hitEvent.target;
    if target.IsPlayer() {
      let randomNumber = RandRange(0, 100);
      hitEvent.attackComputed.MultAttackValue(1.2);
      if (randomNumber > 50) {
        StatusEffectHelper.ApplyStatusEffect(target, t"BaseStatusEffect.Burning");

        if (!StatusEffectSystem.ObjectHasStatusEffect(owner, t"BaseStatusEffect.CE_FlameArmorCooldown")) {
            StatusEffectHelper.ApplyStatusEffect(owner, t"BaseStatusEffect.CE_FlameArmorActivation");
        }
      }
    };
  }
}