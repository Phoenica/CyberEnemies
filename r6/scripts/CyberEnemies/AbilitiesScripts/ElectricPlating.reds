module CyberEnemies.ElectricPlating

public class ElectricPlatingEffector extends ModifyAttackEffector {
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
    if source.IsPlayer() {
      let randomNumber = RandRange(0, 100);

      if (randomNumber > 60) {
        GameObject.PlaySoundEvent(source, n"ONO_V_LongPain");
        StatusEffectHelper.ApplyStatusEffect(source, t"BaseStatusEffect.Electrocuted");
        StatusEffectHelper.ApplyStatusEffect(source, t"BaseStatusEffect.EMP");
        (source as PlayerPuppet).SendCameraShakeDataToGraph(hitEvent,50.0);
      }
    };
  }
}

public class ElectricPlatingEffector2 extends ModifyAttackEffector {
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
      // should give player stacking debuf, and cause electric explosion when stacks reach too high, knocking player down
      if (randomNumber > 60) {
        GameObject.PlaySoundEvent(target, n"ONO_V_LongPain");
        StatusEffectHelper.ApplyStatusEffect(target, t"BaseStatusEffect.EMP");
        StatusEffectHelper.ApplyStatusEffect(target, t"BaseStatusEffect.Electrocuted");
        (target as PlayerPuppet).SendCameraShakeDataToGraph(hitEvent,50.0);
      }
    };
  }
}