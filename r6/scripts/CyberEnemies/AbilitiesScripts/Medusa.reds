module CyberEnemies.Medusa

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

        let npc = owner as NPCPuppet;

        let targetNpcRarity: gamedataNPCRarity = npc.GetNPCRarity();
        let isMaxtac = Equals(targetNpcRarity, gamedataNPCRarity.MaxTac);

        if (!isMaxtac && NotEquals(npc.GetRecordID(), t"Character.q306_black_ops_fast_ranged")) {
            GameInstance.GetAudioSystem(owner.GetGame()).Play(StringToName("medusa2"), owner.GetEntityID(), n"V");
        }

        let distanceToPlayer = Vector4.Distance(owner.GetWorldPosition(), player.GetWorldPosition());

        let npc = owner as NPCPuppet;
        let playerHasBlindImmunity = GameInstance.GetStatsSystem(player.GetGame()).GetStatValue(Cast<StatsObjectID>(player.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"BlindImmunity"))); 

        if (playerHasBlindImmunity > 0.0) {
            return;
        }

        if (CheckCommonRestrictions(npc, true, false) && IsLookingAtTarget(npc, player, 120) && distanceToPlayer < 10.0) {
            if IsLookingAtTarget(player, npc, 10.0) {
                StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEMedusaBlind1");
                StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEBansheeShortStun");
            } else if IsLookingAtTarget(player, npc, 16.0) {
                StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEMedusaBlind2");
                StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEBansheeShortStun");
            } else if IsLookingAtTarget(player, npc, 22.0) {
                StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEMedusaBlind3");
                StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEBansheeShortStun");
            } else if IsLookingAtTarget(player, npc, 28.0) {
                StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEMedusaBlind4");
                StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEBansheeShortStun");
            } else if IsLookingAtTarget(player, npc, 36.0) {
                StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEMedusaBlind5");
            } else if IsLookingAtTarget(player, npc, 42.0) {
                StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEMedusaBlind6");
            } else if IsLookingAtTarget(player, npc, 50.0) {
                StatusEffectHelper.ApplyStatusEffect(player, t"BaseStatusEffect.CEMedusaBlind7");
            }
        } 
    }
}

