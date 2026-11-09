module CyberEnemies.PowerPunch


public class PowerPunchEffector extends ModifyAttackEffector {
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
    let hitEvent: ref<gameHitEvent> = this.GetHitEvent();
    if !IsDefined(hitEvent) {
      return;
    };

    let target: ref<GameObject> = hitEvent.target;
    if target.IsPlayer() {
        let player = target as PlayerPuppet;
        
        if hitEvent.attackData.HasFlag(hitFlag.WasDeflected) || StatusEffectSystem.ObjectHasStatusEffectOfType(player, gamedataStatusEffectType.Knockdown) || StatusEffectSystem.ObjectHasStatusEffectOfType(player, gamedataStatusEffectType.Stunned) {
            return;
        }

        if (hitEvent.attackData.HasFlag(hitFlag.WasBlocked)) {
            StatusEffectHelper.ApplyStatusEffect(target, t"BaseStatusEffect.CE_PowerPunch_Stun");
        } else {
            let randomNumber = RandRange(0, 100);

            if (randomNumber > 80) {
                StatusEffectHelper.ApplyStatusEffect(target, t"BaseStatusEffect.CE_PowerPunch_Knockdown");
            } else {
                StatusEffectHelper.ApplyStatusEffect(target, t"BaseStatusEffect.CE_PowerPunch_StunLong");
                player.SendCameraShakeDataToGraph(hitEvent,50.0);
            }

            
        }
    }
  }
}

public class PowerPunchKurtEffector extends ModifyAttackEffector {
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
    let hitEvent: ref<gameHitEvent> = this.GetHitEvent();
    if !IsDefined(hitEvent) {
      return;
    };


    let target: ref<GameObject> = hitEvent.target;
    if target.IsPlayer() {
        let player = target as PlayerPuppet;

        if StatusEffectSystem.ObjectHasStatusEffect(player, t"BaseStatusEffect.KurtTakedown_01_Effect") || StatusEffectSystem.ObjectHasStatusEffect(player, t"BaseStatusEffect.KurtTakedown_02_Effect") {
            return;
        }
        
        if hitEvent.attackData.HasFlag(hitFlag.WasDeflected) || StatusEffectSystem.ObjectHasStatusEffectOfType(player, gamedataStatusEffectType.Knockdown) || StatusEffectSystem.ObjectHasStatusEffectOfType(player, gamedataStatusEffectType.Stunned) {
            return;
        }

        if (hitEvent.attackData.HasFlag(hitFlag.WasBlocked)) {
            StatusEffectHelper.ApplyStatusEffect(target, t"BaseStatusEffect.CE_PowerPunch_Stun");
        } else {
            StatusEffectHelper.ApplyStatusEffect(target, t"BaseStatusEffect.PlayerBleeding");
        }
    }
  }
}


