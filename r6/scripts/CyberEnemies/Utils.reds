module CyberEnemies.Utils


public static func IsLookingAtTarget(looker: ref<GameObject>, target: ref<GameObject>, maxAngle: Float) -> Bool {
    let lookerPos: Vector4 = looker.GetWorldPosition();
    let targetPos: Vector4 = target.GetWorldPosition();

    // Direction from player to target
    let dirToTarget: Vector4 = Vector4.Normalize(targetPos - lookerPos);

    // Player look direction (could use camera or body orientation)
    let lookDir: Vector4 = Vector4.Normalize(looker.GetWorldForward());

    // Compute dot product
    let dotValue: Float = Vector4.Dot(lookDir, dirToTarget);

    // Compare with cosine of allowed angle
    let angleCos: Float = CosF(Deg2Rad(maxAngle));
// GetLookAtObject -todo use this!?
    return IsLookingAtTarget(looker, target) || dotValue >= angleCos;
}

// todo - replace IsLookingAtTarget usages with this one whenever makes sense

public static func IsLookingAtTarget(looker: ref<GameObject>, target: ref<GameObject>) -> Bool {
    let theGame = GetGameInstance(); // YES, you just lost it

    let lookedAtObect: ref<GameObject> = GameInstance.GetTargetingSystem(theGame).GetLookAtObject(looker, true, true);

    if !IsDefined(lookedAtObect) {
      return false;
    };

    return target.GetEntityID() == lookedAtObect.GetEntityID();
}

public static func CheckCommonRestrictions(npc: ref<NPCPuppet>, blockedByCC: Bool, allowSleep: Bool) -> Bool {
    if (VehicleComponent.IsMountedToVehicle(npc.GetGame(), npc) && blockedByCC) {
        return false;
    }

    if (npc.IsDead()) {
        return false;
    }

    if (npc.IsIncapacitated() && !allowSleep) {
        return false;
    }

    if (StatusEffectSystem.ObjectHasStatusEffectOfType(npc, gamedataStatusEffectType.EMP)) {
        return false;
    }

    if (StatusEffectSystem.ObjectHasStatusEffectOfType(npc, gamedataStatusEffectType.Grapple) && blockedByCC) {
        return false;
    }

    if (StatusEffectSystem.ObjectHasStatusEffectOfType(npc, gamedataStatusEffectType.Stunned) && blockedByCC) {
        return false;
    }

    if (StatusEffectSystem.ObjectHasStatusEffectOfType(npc, gamedataStatusEffectType.Knockdown) && blockedByCC) {
        return false;
    }

    if (StatusEffectSystem.ObjectHasStatusEffectWithTag(npc, n"CyberwareMalfunction")) {
        return false;
    }

    if npc.IsVendor(){
        return false;
    }

    let player = GetPlayer(GetGameInstance());

    if GameInstance.GetBlackboardSystem(GetGameInstance()).GetLocalInstanced(player.GetEntityID(), GetAllBlackboardDefs().PlayerStateMachine).GetInt(GetAllBlackboardDefs().PlayerStateMachine.SceneTier) >1{
        return false;
    };


    return true;
}

public final static func HasSpaceAbove(const position: Vector4, groundClearance: Float, areaWidth: Float, areaLength: Float, maxHeight: Float) -> Bool {
    let boxDimensions: Vector4;
    let boxOrientation: EulerAngles = new EulerAngles();
    let fitTestOverlap: TraceResult;
    let overlapSuccessStatic: Bool;
    let overlapSuccessVehicle: Bool;
    let spatialQueriesSystem: ref<SpatialQueriesSystem> = GameInstance.GetSpatialQueriesSystem(GetGameInstance());

    // Box half-extents
    boxDimensions.X = areaWidth * 0.50;
    boxDimensions.Y = areaLength * 0.50;
    boxDimensions.Z = (maxHeight - groundClearance) * 0.50;

    // Query position: center of the vertical column
    let queryPosition: Vector4 = position;
    queryPosition.Z += groundClearance + boxDimensions.Z; // start from 2 meters above

    // Check collisions with Static objects
    overlapSuccessStatic = spatialQueriesSystem.Overlap(boxDimensions, queryPosition, boxOrientation, n"Static", fitTestOverlap);
    // Check collisions with Vehicles
    overlapSuccessVehicle = spatialQueriesSystem.Overlap(boxDimensions, queryPosition, boxOrientation, n"Vehicle", fitTestOverlap);

    // Space is clear if there are no overlaps
    return !overlapSuccessStatic && !overlapSuccessVehicle;
}


