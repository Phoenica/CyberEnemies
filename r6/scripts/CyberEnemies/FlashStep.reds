module CyberEnemies.FlashStepIntegration

import CyberEnemies.Utils.*

@if(ModuleExists("MuchBetterAI.SandevistanIntegration"))
import MuchBetterAI.SandevistanIntegration.MBAI_ControlsEnemySandevistan

@if(ModuleExists("MuchBetterAI.SandevistanIntegration"))
public static func CE_DelegatesFlashStep(npc: ref<NPCPuppet>) -> Bool {
    return MBAI_ControlsEnemySandevistan(npc);
}

@if(!ModuleExists("MuchBetterAI.SandevistanIntegration"))
public static func CE_DelegatesFlashStep(npc: ref<NPCPuppet>) -> Bool {
    return false;
}

public static func CE_PrepareFlashStep(npc: ref<NPCPuppet>, player: ref<PlayerPuppet>) -> ref<AITeleportCommand> {
    if !IsDefined(npc) || !IsDefined(player) {
        return null;
    }
    let game = npc.GetGame();
    let stats = GameInstance.GetStatsSystem(game);
    let id = Cast<StatsObjectID>(npc.GetEntityID());
    let hasFlashStep = stats.GetStatValue(id, IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasFlashStep")));
    if hasFlashStep <= 0.0 || stats.GetStatValue(id, gamedataStatType.HasSandevistan) <= 0.0
        || VehicleComponent.IsMountedToVehicle(game, player)
        || !CheckCommonRestrictions(npc, true, false)
        || StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CE_FlashStepCD")
        || !NPCPuppet.IsInCombatWithTarget(npc, player) {
        return null;
    }
    let distance = Vector4.Distance(npc.GetWorldPosition(), player.GetWorldPosition());
    let bb = player.GetPlayerStateMachineBlackboard();
    if !IsDefined(bb) || !bb.GetBool(GetAllBlackboardDefs().PlayerStateMachine.IsOnGround)
        || distance <= 4.0 || distance >= 25.0 || !IsLookingAtTarget(npc, player, 45) {
        return null;
    }
    let direction = player.GetWorldForward();
    let position = player.GetWorldPosition();
    let toPlayer = position - npc.GetWorldPosition();
    direction.X = toPlayer.X < 0.0 ? -AbsF(direction.X) : AbsF(direction.X);
    direction.Y = toPlayer.Y < 0.0 ? -AbsF(direction.Y) : AbsF(direction.Y);
    if !SpatialQueriesHelper.HasSpaceInFront(player, direction, 0.1, 0.5, 0.5, 2.0) {
        return null;
    }
    position.X += direction.X;
    position.Y += direction.Y;
    let command = new AITeleportCommand();
    command.position = position;
    command.rotation = AngleNormalize180(Quaternion.ToEulerAngles(npc.GetWorldOrientation()).Yaw + 180.0);
    return command;
}

public static func CE_CommitFlashStep(npc: ref<NPCPuppet>) -> Void {
    StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_FlashStepCD");
    GameInstance.GetAudioSystem(npc.GetGame()).Play(StringToName("ce_sonido"), npc.GetEntityID(), n"V");
}
