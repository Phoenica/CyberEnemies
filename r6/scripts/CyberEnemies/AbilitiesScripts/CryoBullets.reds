module CyberEnemies.CryoBullets

public class BulletsEffector extends ModifyAttackEffector {
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
    let weaponType = WeaponObject.GetWeaponType(hitEvent.attackData.weapon.GetItemID());
    let stacksIncrement = 4;

    if (Equals(weaponType, gamedataItemType.Wea_AssaultRifle)) {
      stacksIncrement = 5;
    }  
    
    if (Equals(weaponType, gamedataItemType.Wea_HeavyMachineGun) || Equals(weaponType, gamedataItemType.Wea_LightMachineGun)) {
      stacksIncrement = 7;
    }

    if (Equals(weaponType, gamedataItemType.Wea_Handgun) || Equals(weaponType, gamedataItemType.Wea_Revolver)) {
      stacksIncrement = 3;
    }

    if (Equals(weaponType, gamedataItemType.Wea_SubmachineGun)) {
      stacksIncrement = 4;
    }

    if (Equals(weaponType, gamedataItemType.Wea_Shotgun) || Equals(weaponType, gamedataItemType.Wea_ShotgunDual)) {
      stacksIncrement = 3;
    }

    if (Equals(weaponType, gamedataItemType.Wea_PrecisionRifle) || Equals(weaponType, gamedataItemType.Wea_SniperRifle)) {
      stacksIncrement = 25;
    }

    if (!StatusEffectSystem.ObjectHasStatusEffectOfType(target, gamedataStatusEffectType.Burning)) {
        let i = 0;

        while (i < stacksIncrement) {
          StatusEffectHelper.ApplyStatusEffect(target, t"BaseStatusEffect.CEChilled");
          i += 1;
        }
    }
  }
}