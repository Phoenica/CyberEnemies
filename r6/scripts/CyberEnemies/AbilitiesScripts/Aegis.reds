module CyberEnemies.Aegis

import CyberEnemies.Utils.*

public class ApplyStatusEffector extends ModifyAttackEffector {
  protected func ActionOn(owner: ref<GameObject>) -> Void {
    this.ProcessAction(owner);
  }

  protected func RepeatedAction(owner: ref<GameObject>) -> Void {
    this.ProcessAction(owner);
  }

  private final func ProcessAction(owner: ref<GameObject>) -> Void {    
    if (CheckCommonRestrictions((owner as NPCPuppet), true, false) && !StatusEffectSystem.ObjectHasStatusEffect(owner, t"BaseStatusEffect.CE_AegiesCooldown")) {
      StatusEffectHelper.ApplyStatusEffect((owner as NPCPuppet), t"BaseStatusEffect.CE_AegiesCooldown");    
      StatusEffectHelper.ApplyStatusEffect((owner as NPCPuppet), t"BaseStatusEffect.CE_AegiesActive"); 
    }
  }
}



public class DefendEffector extends ModifyAttackEffector {
  protected func ActionOn(owner: ref<GameObject>) -> Void {
    this.ProcessAction(owner);
  }

  protected func RepeatedAction(owner: ref<GameObject>) -> Void {
    this.ProcessAction(owner);
  }

  private final func ProcessAction(owner: ref<GameObject>) -> Void {
    let damage: Float;
    let hitEvent: ref<gameHitEvent> = this.GetHitEvent();
    if !IsDefined(hitEvent) || !CheckCommonRestrictions((owner as NPCPuppet), false, false) {
      return;
    };
    let weapon = hitEvent.attackData.GetWeapon();
    damage = hitEvent.attackComputed.GetTotalAttackValue(gamedataStatPoolType.Health);
    let statSys: ref<StatsSystem> = GameInstance.GetStatsSystem(GetGameInstance());

    let smokeStacks: Float = statSys.GetStatValue(Cast<StatsObjectID>(owner.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_AegisCDCounter")));

    if damage <= 0.00 || (Equals(TweakDBInterface.GetWeaponItemRecord(ItemID.GetTDBID(weapon.GetItemID())).Evolution().Type(), gamedataWeaponEvolution.Smart) && weapon.IsTargetLocked() && CheckCommonRestrictions((owner as NPCPuppet), false, false)){
      return;
    };
    
    if (smokeStacks >= 40.0) {
      StatusEffectHelper.RemoveStatusEffect(owner, t"BaseStatusEffect.CE_AegiesActive");   
      return;
    }
    
    hitEvent.attackComputed.MultAttackValue(0.00);
    StatusEffectHelper.ApplyStatusEffect((owner as NPCPuppet), t"BaseStatusEffect.CE_AegisSmoke");  

    GameObject.PlaySound(owner, n"w_cyb_nanotech_plates_deflecting");
  }
}
