module CyberEnemies.Banshee

import CyberEnemies.Utils.*

public class ApplyStatusEffector extends Effector {
    protected func ActionOn(owner: ref<GameObject>) -> Void {
        this.ExecuteAction(owner);
    }

    protected func RepeatedAction(owner: ref<GameObject>) -> Void {
        this.ExecuteAction(owner);
    }

    private final func ExecuteAction(owner: ref<GameObject>) -> Void {
        let player = GetPlayer(GetGameInstance());

        let distanceToPlayer = Vector4.Distance(owner.GetWorldPosition(), player.GetWorldPosition());
        let npc = owner as NPCPuppet;

        if (distanceToPlayer < 6.0) {
            StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.Knockdown");
            GameObject.PlaySoundEvent(player, n"ONO_V_LongPain");
            StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEBansheeLongStun");
            StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEBansheeDrillShake3");
            StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEBansheeStaggerEffect");
            StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEBansheeStaggerEffect");
            StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEBansheeStaggerEffect");
        } else if (distanceToPlayer < 8.0) {
            StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEBansheeMediumStun");
            StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEBansheeDrillShake3");
            StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEBansheeStaggerEffect");
            StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEBansheeStaggerEffect");
            StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEBansheeStaggerEffect");
        } else if (distanceToPlayer < 12.0) {
            StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEBansheeShortStun");
            StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEBansheeDrillShake3");
            StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEBansheeStaggerEffect");
            StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEBansheeStaggerEffect");
        } else if (distanceToPlayer < 14.0) {
            StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEBansheeDrillShake2");
            StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEBansheeStaggerEffect");
            StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEBansheeStaggerEffect");
        } else if (distanceToPlayer < 17.0) {
            StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEBansheeDrillShake1");
            StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEBansheeStaggerEffect");
        } else if (distanceToPlayer < 20.0) {
            StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEBansheeDrillShake1");
        }        

        let entities = player.GetEntitiesAroundObject(50.0, TSF_NPC());

        let i = 0;

        while (i < ArraySize(entities)) {
            let otherNPC = entities[i] as NPCPuppet;
            if (NPCPuppet.IsInCombatWithTarget(npc, otherNPC)) {
                let dinstance =  Vector4.Distance(npc.GetWorldPosition(), otherNPC.GetWorldPosition());
                if dinstance < 5.0 {
                    StatusEffectHelper.ApplyStatusEffect(otherNPC, t"BaseStatusEffect.Knockdown");
                    StatusEffectHelper.ApplyStatusEffect(otherNPC, t"BaseStatusEffect.Stun");
                } else if dinstance < 10.0 {
                    StatusEffectHelper.ApplyStatusEffect(otherNPC, t"BaseStatusEffect.Stun");
                }
            }

            i += 1;
        }

    }
}

