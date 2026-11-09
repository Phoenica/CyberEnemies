module CyberEnemies.TickSystem

import CyberEnemies.RadarFucker.*
import Codeware.UI.*
import CyberEnemies.Utils.*
import CyberEnemies.ExtraEnemies.*
import CyberEnemies.Radar.*

import CyberEnemies.Configurations.*


@addField(NPCPuppet)
public let ce_droneSpawner: wref<NPCPuppet>;

@addField(NPCPuppet)
public let spawnedDroneCounter: Int32;

@addField(NPCPuppet)
public let ce_isSpawnedDrone: Bool;



public class TickSystem extends ScriptableSystem {
    private let delaySystem: ref<DelaySystem>;
    private let callbackSystem: ref<CallbackSystem>;
    private let player: wref<PlayerPuppet>;
    private let statsSystem: ref<StatsSystem>;
    public let m_entitySystem: wref<DynamicEntitySystem>;
    private let targetingSystem: wref<TargetingSystem>;
    private let settings: ref<CyberEnemiesSettings>;
    private let lastTurretSpawner: wref<NPCPuppet>;
    private let lastDroneSpawner: wref<NPCPuppet>;
    private let lastExtraSpawner: wref<NPCPuppet>;
    private let repairSoundCounter: Int32 = 0;
    private let FxSystem: ref<FxSystem>;
    private let preGorgonFOV: Float;
    private let gorgonCounter: Int32 = 0;

    private let odaDefeated: Bool = false;
    private let gorgonNpc: ref<NPCPuppet>;
    private let gorgonEffectRouletter: Int32 = 0;

    private let radarNPCs: array<ref<NPCPuppet>>;

    private let neurotoxinAlert1: Bool = false;
    private let neurotoxinAlert2: Bool = false;

    // Spawner Flags
    private persistent let tomAyerSpawner: Bool;

    // End of Spawner Flags
    public func GetLastDroneSpawner() -> wref<NPCPuppet> {
        return this.lastDroneSpawner;
    }

    
    public func GetLastExtraSpawner() -> wref<NPCPuppet> {
        return this.lastExtraSpawner;
    }


    public static func GetInstance(gameInstance: GameInstance) -> ref<TickSystem> {
        let system: ref<TickSystem> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"CyberEnemies.TickSystem.TickSystem") as TickSystem;
        return system;
    }

    private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void {
        let player: wref<PlayerPuppet> = GetPlayer(GetGameInstance());


        if player.IsReplacer() {
            return;
        };
        
        if IsDefined(player) { 
            this.player = player;
            this.statsSystem = GameInstance.GetStatsSystem(this.player.GetGame());
            this.delaySystem = GameInstance.GetDelaySystem(this.player.GetGame());
            this.m_entitySystem = GameInstance.GetDynamicEntitySystem();
            this.callbackSystem = GameInstance.GetCallbackSystem();
            this.FxSystem = GameInstance.GetFxSystem(this.player.GetGame());
            this.targetingSystem = GameInstance.GetTargetingSystem(this.player.GetGame());
            this.settings = new CyberEnemiesSettings();
            
            this.radarNPCs = [];
            this.callbackSystem.RegisterCallback(n"Entity/Attached", this, n"OnTurretAttached")
                .AddTarget(DynamicEntityTarget.Tag(n"CyberEnemies.Turret"));


                // let raRef: ResourceAsyncRef = new ResourceAsyncRef();
                // ResourceAsyncRef.SetPath(raRef, r"base\\fx\\quest\\sq027\\sq027_car_wreckages_fire.effect");
                // let fxRes: FxResource;
                // fxRes.effect = raRef;
                // let position: WorldPosition;
                // WorldPosition.SetVector4(position, this.player.GetWorldPosition());
                // let transform: WorldTransform;
                // WorldTransform.SetWorldPosition(transform, position);
                // WorldTransform.SetOrientationFromDir(transform, player.GetWorldForward());
                // this.FxSystem.SpawnEffect(fxRes, transform, true);

            this.SetUpNextCallback();
        }
    }

    private func SetUpNextCallback() {
        this.delaySystem.DelayCallback(CyberEnemiesTickSystemCallback.Create(this), 1, true);
    }

    private cb func OnTurretAttached(event: ref<EntityLifecycleEvent>) {
        let entity: ref<SecurityTurret>;
        entity = event.GetEntity() as SecurityTurret;
        let callerSquadMembers: array<wref<Entity>>;


        if (IsDefined(this.lastTurretSpawner)) {
            FixAttitude(this.lastTurretSpawner, entity);
        }
        SecurityTurret.ChangeAttitudeToHostile(entity, this.player);
    }

    public func HandleGorgonCallback() {
        if (
            IsDefined(this.gorgonNpc) && 
            this.player.IsPuppetInCombat() &&
            !this.gorgonNpc.IsIncapacitated() &&
            !StatusEffectSystem.ObjectHasStatusEffectOfType(this.player, gamedataStatusEffectType.Knockdown) &&
            IsLookingAtTarget(this.player, this.gorgonNpc, 120) &&
            ((IsLookingAtTarget(this.gorgonNpc, this.player, 120) && this.gorgonNpc.GetSourceShootComponent().CanSeeSecondaryPointOfTarget(this.player)) || IsLookingAtTarget(this.gorgonNpc, this.player)) &&
            Vector4.Distance(this.gorgonNpc.GetWorldPosition(), this.player.GetWorldPosition()) < 60.0 &&
            CheckCommonRestrictions(this.gorgonNpc, true, false)
            ) {
                
                let localAimRequest: AimRequest;

                localAimRequest.lookAtTarget = this.gorgonNpc.GetWorldPosition() + new Vector4(0.00, 0.00, 1.0, 0.00);
                localAimRequest.duration = 0.10;
                localAimRequest.easeIn = false;
                localAimRequest.easeOut = false;
                localAimRequest.precision = 0.01;
                localAimRequest.adjustPitch = true;
                localAimRequest.adjustYaw = true;
                localAimRequest.checkRange = false;
                localAimRequest.endOnCameraInputApplied = true;
                localAimRequest.endOnTargetReached = false;
                localAimRequest.processAsInput = true;
                this.targetingSystem.BreakAimSnap(this.player);
                this.targetingSystem.LookAt(this.player, localAimRequest);
                this.delaySystem.DelayCallback(GorgonCallback.Create(this), 0.1, true);
        } else {
            StatusEffectHelper.RemoveStatusEffect(this.gorgonNpc, t"BaseStatusEffect.CE_GorgonNPCEffect");   
            StatusEffectHelper.RemoveStatusEffect(this.player, t"BaseStatusEffect.CE_GorgonPlayerEffect1");   
            StatusEffectHelper.RemoveStatusEffect(this.player, t"BaseStatusEffect.CE_GorgonPlayerEffect2");   
            StatusEffectHelper.RemoveStatusEffect(this.player, t"BaseStatusEffect.CE_GorgonPlayerEffect3");   
            this.gorgonCounter = 0;
            let playerCamera = this.player.GetFPPCameraComponent();
            playerCamera.SetFOV(this.preGorgonFOV);

            this.player.RemoveGameplayRestriction(this.player.GetPlayerStateMachineBlackboard(), t"GameplayRestriction.NoScanning");
        }
    }

    public func HandleCallback() {
        let entities = this.player.GetEntitiesAroundObject(120.0, TSF_NPC());

        // if (!IsDefined(this.AVACSwidget)) {
        //     // LogChannel(n"DEBUG", "1");
        //     this.SetUpAVACSTooltip();
        // } else {
        //     // LogChannel(n"DEBUG", "2");
        // }
        
        this.HandlePoisonTankAbility(entities);
        this.HandleCryoBulletsAbility();
        this.HandleRadarFuckerAbility(entities);
        this.HandleJuiceInjector(entities);
        this.HandleThreatDetector(entities);
        this.HasTurretSpawner(entities);
        this.HandleSecondHeart(entities);
        this.HandlePhoenixProtocol(entities); // todo - require armor mod
        this.HandleMedusaAbility(entities);
        this.HandleBansheeAbility(entities);
        this.HandleVoodooAbility(entities);
        this.HandleFlashStepAbility(entities);
        this.HandleGorgonAbility(entities);
        this.HandleRadarAbility(entities);
        this.HandleElectricPlatingAbility(entities);
        this.HandleFlameArmorAbility(entities);
        this.HandleDroneSpawner(entities);
        this.HandleSpawnedRobots(entities);
        this.HandleBomb(entities);
        this.HandleBloodPump(entities);
        // this.HandleExtraEnemiesLogic(entities);
        this.HandlePainEditor(entities);
        this.HandleChimeraSpawner(entities);
        this.HandleMaggie(entities);
        this.HandleOdaHoloSpawns(entities);
        this.HandlePlayerECM(entities);
        this.HandleOdaDespawn(this.m_entitySystem.GetTagged(n"CEHoloPuppet"));
        
        this.HandleDespawningLogic(this.m_entitySystem.GetTagged(n"CEModPuppet"));

        this.SetUpNextCallback();
    }

    private func HandlePlayerECM(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;
        let ecmLevel = this.statsSystem.GetStatValue(Cast<StatsObjectID>(this.player.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_PlayerECM"))); 

        if (this.PlayerECMRestrictions(this.player) || ecmLevel < 2.0) {
            return;
        }

        while (i < size) {
            let npc = entities[i] as NPCPuppet;

            let distanceToPlayer = Vector4.Distance(npc.GetWorldPosition(), this.player.GetWorldPosition());
            let npcAttitude = npc.GetAttitudeAgent();
            let playerAttitude = this.player.GetAttitudeAgent();
            let affiliation = TweakDBInterface.GetCharacterRecord(npc.GetRecordID()).Affiliation().Type();

            if (distanceToPlayer <= 5.0 &&
                NotEquals(npcAttitude.GetAttitudeTowards(playerAttitude), EAIAttitude.AIA_Friendly) &&
                !npc.IsCrowd() && 
                !Equals(affiliation, gamedataAffiliation.NCPD)
                ) {
                if (ecmLevel == 2.0) {
                    StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_CommsNoise1");  
                }

                if (ecmLevel == 3.0) {
                    StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_CommsNoise2");  
                }
                
                if (ecmLevel == 4.0) {
                    StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_CommsNoise3");  
                }
            }

            i += 1;
        }
    }

    public func PlayerECMRestrictions(player: ref<PlayerPuppet>) -> Bool {
        if (VehicleComponent.IsMountedToVehicle(player.GetGame(), player)) {
            return true;
        }

        if (StatusEffectSystem.ObjectHasStatusEffectOfType(player, gamedataStatusEffectType.EMP)) {
            return true;
        }

        if (StatusEffectSystem.ObjectHasStatusEffectWithTag(player, n"CyberwareMalfunction")) {
            return true;
        }

        if GameInstance.GetBlackboardSystem(GetGameInstance()).GetLocalInstanced(player.GetEntityID(), GetAllBlackboardDefs().PlayerStateMachine).GetInt(GetAllBlackboardDefs().PlayerStateMachine.SceneTier) >1{
            return true;
        };

        if (NotEquals(this.player.m_securityAreaTypeE3HACK, ESecurityAreaType.SAFE)) {
            return true;
        }

        return false;
    }

    private func HandleMaggie(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;

        while (i < size) {
            let npc = entities[i] as NPCPuppet;

            if (Equals(npc.GetRecordID(), t"Character.cbj_ep1_002_cyberjunkie") && NPCPuppet.IsInCombatWithTarget(npc, this.player) && (StatusEffectSystem.ObjectHasStatusEffect(this.player, t"BaseStatusEffect.CE_Poisoned") || StatusEffectSystem.ObjectHasStatusEffect(this.player, t"BaseStatusEffect.Poisoned"))) {
                StatusEffectHelper.ApplyStatusEffect(this.player, t"BaseStatusEffect.NeuroToxin");  
                StatusEffectHelper.ApplyStatusEffect(this.player, t"BaseStatusEffect.NeuroToxin");  
                StatusEffectHelper.ApplyStatusEffect(this.player, t"BaseStatusEffect.NeuroToxin");  
                StatusEffectHelper.ApplyStatusEffect(this.player, t"BaseStatusEffect.NeuroToxin");  
                StatusEffectHelper.ApplyStatusEffect(this.player, t"BaseStatusEffect.NeuroToxin");  
                StatusEffectHelper.ApplyStatusEffect(this.player, t"BaseStatusEffect.NeuroToxin");  
                StatusEffectHelper.ApplyStatusEffect(this.player, t"BaseStatusEffect.NeuroToxin");  
                StatusEffectHelper.ApplyStatusEffect(this.player, t"BaseStatusEffect.NeuroToxin");  
                StatusEffectHelper.ApplyStatusEffect(this.player, t"BaseStatusEffect.NeuroToxin");  
            }

            i += 1;
        }

        let neurotoxinCounter = this.statsSystem.GetStatValue(Cast<StatsObjectID>(this.player.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_NeurotoxinCounter"))); 

        if (neurotoxinCounter >= 25.0 && !this.neurotoxinAlert1) {
            this.neurotoxinAlert1 = true;

            let warningMsg: SimpleScreenMessage;
            warningMsg.isShown = true;

            warningMsg.duration = 5;

            warningMsg.message = GetLocalizedTextByKey(n"cyberEnemies_ability_neuroToxinWarn1");
            
            GameInstance.GetBlackboardSystem(this.player.GetGame()).Get(GetAllBlackboardDefs().UI_Notifications).SetVariant(GetAllBlackboardDefs().UI_Notifications.WarningMessage, ToVariant(warningMsg), true);
        }

        if (neurotoxinCounter >= 75.0 && !this.neurotoxinAlert2) {
            this.neurotoxinAlert2 = true;

            let warningMsg: SimpleScreenMessage;
            warningMsg.isShown = true;

            warningMsg.duration = 5;

            warningMsg.message = GetLocalizedTextByKey(n"cyberEnemies_ability_neuroToxinWarn2");
            
            GameInstance.GetBlackboardSystem(this.player.GetGame()).Get(GetAllBlackboardDefs().UI_Notifications).SetVariant(GetAllBlackboardDefs().UI_Notifications.WarningMessage, ToVariant(warningMsg), true);
        }

          if (neurotoxinCounter >= 100.0) {
            StatusEffectHelper.ApplyStatusEffect(this.player, t"BaseStatusEffect.ForceKill");  
          }
    }

    private func HandleOdaHoloSpawns(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;

        while (i < size) {
            let npc = entities[i] as NPCPuppet;
            let defeated = NPCPuppet.IsDefeated(npc) || npc.IsDead();
            
            if (Equals(npc.GetRecordID(), t"Character.Cyberninja_Oda") && !this.odaDefeated && defeated) {
                this.odaDefeated = true;
            }

            if (Equals(npc.GetRecordID(), t"Character.Cyberninja_Oda") && StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CloakedOda") && !StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CE_OdaHologramCD")) {
                StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_OdaHologramCD");  

                let hologramSpec = new DynamicEntitySpec();
                hologramSpec.recordID = t"Character.CE_OdaHologram";
                hologramSpec.orientation = npc.GetWorldOrientation();
                hologramSpec.persistState = true;
                hologramSpec.persistSpawn = false;
                hologramSpec.spawnInView = false;
                hologramSpec.tags = [n"CEHoloPuppet"];

                let vec1 = new Vector4(-540.4133, 737.4636, 153.0191, 1);
                let vec2 = new Vector4(-546.31555, 751.743, 153.04985,1);
                let vec3 = new Vector4(-562.37665, 750.0903, 153.01813, 1);
                let vec4 = new Vector4(-552.4647, 757.7027, 150.03734, 1);
                let vec5 = new Vector4(-543.6721, 743.35236, 146.99515, 1);
                let vec6 = new Vector4(-557.0148, 725.5698,146.99515, 1);

                hologramSpec.position = vec1;
                this.m_entitySystem.CreateEntity(hologramSpec);
                hologramSpec.position = vec2;
                this.m_entitySystem.CreateEntity(hologramSpec);
                hologramSpec.position = vec3;
                this.m_entitySystem.CreateEntity(hologramSpec);
                hologramSpec.position = vec4;
                this.m_entitySystem.CreateEntity(hologramSpec);
                hologramSpec.position = vec5;
                this.m_entitySystem.CreateEntity(hologramSpec);
                hologramSpec.position = vec6;
                this.m_entitySystem.CreateEntity(hologramSpec);
            }

            if (Equals(npc.GetRecordID(), t"Character.CE_OdaHologram")) {
                TargetTrackingExtension.InjectThreat(npc, this.player);   
            }

            i += 1;
        }
    }

    private func HandleOdaDespawn(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;

        while (i < size) {
            let npc = entities[i] as NPCPuppet;
            let distanceToPlayer = Vector4.Distance(npc.GetWorldPosition(), this.player.GetWorldPosition());
            let defeated = NPCPuppet.IsDefeated(npc) || npc.IsDead();

            if (Equals(npc.GetRecordID(), t"Character.CE_OdaHologram") && (defeated || distanceToPlayer < 4.0 || this.odaDefeated)) {
                if (StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CE_OdaHologramDead")) {
                    this.m_entitySystem.DeleteEntity(npc.GetEntityID());
                } else {
                    if (!defeated) {
                        StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.ForceKill");  
                    }

                    StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_OdaHologramDead");  
                    let attack: ref<Attack_GameEffect>;
                    let attackRecord = t"Attacks.OdaSmokeBomb2";
                    
                    
                    let flag: SHitFlag;
                    flag.flag =  IntEnum<hitFlag>(Cast<Int32>(EnumValueFromString("hitFlag", "Explosion")));
                    flag.source = n"Attack";
                    let hitFlags: array<SHitFlag> = [flag];
                    let sourcePosition = npc.GetWorldPosition();

                    attack = RPGManager.PrepareGameEffectAttack(npc.GetGame(), npc, npc, attackRecord, sourcePosition, hitFlags, npc);
                    attack.StartAttack();
                }
            } 

            i += 1;
        }
    }

    // private func HandleExtraEnemiesLogic(entities: array<ref<Entity>>) {
    //     let size = ArraySize(entities);
    //     let i = 0;

    //     while (i < size) {
    //         if (!this.tomAyerSpawner) {
    //             if (Equals((entities[i] as NPCPuppet).GetRecordID(), t"Character.ma_wat_nid_02_outpost_miniboss")) {
    //                 this.lastExtraSpawner = entities[i] as NPCPuppet;
    //                 SpawnNPC(t"Character.nid_maelstrom_android_android2_pulsar_ma", new Vector4(-1837.55, 2568.7, 25.98, 1.0), this.m_entitySystem);
    //                 SpawnNPC(t"Character.nid_maelstrom_android_android2_pulsar_ma", new Vector4(-1808.46, 2562.75, 25.98, 1.0), this.m_entitySystem);
    //                 SpawnNPC(t"Character.maelstrom_techie_grenadier2_lexington_ma", new Vector4(-1801.04, 2521.8, 26.02, 1.0), this.m_entitySystem);
    //                 this.tomAyerSpawner = true;
    //             }
    //         }

    //         i += 1;
    //     }



    // }

    private func HandlePainEditor(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;

        while (i < size) {
            let npc = entities[i] as NPCPuppet;
            let hasPainEditor = this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasPainEditor"))); 

            let healthPercentage = GameInstance.GetStatPoolsSystem(npc.GetGame()).GetStatPoolValue(Cast<StatsObjectID>(npc.GetEntityID()), gamedataStatPoolType.Health);
            
            if (hasPainEditor > 0.0 && healthPercentage < 50.0 && !StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CE_PainEditorCooldown") && CheckCommonRestrictions(npc, true, false)) {
                StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_PainEditorCooldown");  
                StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_PainEditorEffect");  
            }

            i += 1 ;
        }
    }

    private func HandleBloodPump(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;

        while (i < size) {
            let npc = entities[i] as NPCPuppet;
            let hasBloodPump = this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_BloodPump"))); 

            let healthPercentage = GameInstance.GetStatPoolsSystem(npc.GetGame()).GetStatPoolValue(Cast<StatsObjectID>(npc.GetEntityID()), gamedataStatPoolType.Health);
            
            if (hasBloodPump > 0.0 && healthPercentage < 30.0 && !StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CE_BloodPumpCooldown") && CheckCommonRestrictions(npc, false, false)) {
                StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_BloodPumpEffect");  
                StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_BloodPumpCooldown");  
                
                let baseInstantHeal = this.settings.bloodPumpInstantHeal;

                if (StatusEffectSystem.ObjectHasStatusEffectOfType(npc, gamedataStatusEffectType.Poisoned)) {
                    GameInstance.GetStatPoolsSystem(npc.GetGame()).RequestChangingStatPoolValue(Cast<StatsObjectID>(npc.GetEntityID()), gamedataStatPoolType.Health, baseInstantHeal / 5.0, npc, false, true); // todo - check all of them the values dont make no sense
                } else {
                    GameInstance.GetStatPoolsSystem(npc.GetGame()).RequestChangingStatPoolValue(Cast<StatsObjectID>(npc.GetEntityID()), gamedataStatPoolType.Health, baseInstantHeal, npc, false, true);
                }
            }

            if (StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CE_BloodPumpEffect")) {
                let baseDoTHeal = this.settings.bloodPumpDoTHeal / 10.0;

                if (StatusEffectSystem.ObjectHasStatusEffectOfType(npc, gamedataStatusEffectType.Poisoned)) {
                    GameInstance.GetStatPoolsSystem(npc.GetGame()).RequestChangingStatPoolValue(Cast<StatsObjectID>(npc.GetEntityID()), gamedataStatPoolType.Health, baseDoTHeal / 5.0, npc, false, true);
                } else {
                    GameInstance.GetStatPoolsSystem(npc.GetGame()).RequestChangingStatPoolValue(Cast<StatsObjectID>(npc.GetEntityID()), gamedataStatPoolType.Health, baseDoTHeal, npc, false, true);
                }
            }

            i += 1 ;
        }
    }

    private func HandleBomb(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;

        while (i < size) {
            let npc = entities[i] as NPCPuppet;

            let isABomb = this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_IsABomb"))); 

            let distanceToPlayer = Vector4.Distance(npc.GetWorldPosition(), this.player.GetWorldPosition());

            if (isABomb > 0.0 && distanceToPlayer < 4.0) {
                StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.ForceKill");  
            }

            i +=1 ;
        }
    }

    private func HandleSpawnedRobots(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;
        while (i < size) {
            let npc = entities[i] as NPCPuppet;
            if (NPCManager.HasTag(npc.GetRecordID(), n"CEModRoboScanner") && Equals(npc.GetHighLevelStateFromBlackboard(), gamedataNPCHighLevelState.Relaxed)) {
                NPCPuppet.ChangeHighLevelState(npc, gamedataNPCHighLevelState.Alerted);
            }

            if (NPCManager.HasTag(npc.GetRecordID(), n"CEModRoboShooter") && NPCPuppet.IsInCombatWithTarget(npc.ce_droneSpawner, this.player)) {
                TargetTrackingExtension.InjectThreat(npc, this.player);   
            }

            if (NPCManager.HasTag(npc.GetRecordID(), n"CEModRoboBomb") && NPCPuppet.IsInCombatWithTarget(npc.ce_droneSpawner, this.player) && !StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CE_BombFollowCooldown")) {
                TargetTrackingExtension.InjectThreat(npc, this.player);   

                let aiCommandEvent: ref<AICommandEvent>;
                aiCommandEvent = new AICommandEvent();
                let followCommand: ref<AIFollowTargetCommand> = new AIFollowTargetCommand();
                followCommand.desiredDistance = 0.0;
                followCommand.lookAtTarget = this.player;
                followCommand.matchSpeed = false;
                followCommand.movementType = moveMovementType.Sprint;
                followCommand.stopWhenDestinationReached = false;
                followCommand.target = this.player;
                followCommand.teleport = false;

                aiCommandEvent.command = followCommand;
                npc.QueueEvent(aiCommandEvent);

                StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_BombFollowCooldown");    
            }
            i += 1;
        }

    }

    private func HandleRadarAbility(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;
        let radarNPCs: array<ref<NPCPuppet>> = [];
        let awacsRange = false;

        while (i < ArraySize(this.radarNPCs)) {
            this.radarNPCs[i].ce_playerTriggeredRadar = false;

            i += 1;
        }

        i = 0;

        while (i < size) {
            let npc = entities[i] as NPCPuppet;

            let hasRadar = this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasRadar"))); 
            let hasAWACS = this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasAWACS"))); 
            let ecmLevel = this.statsSystem.GetStatValue(Cast<StatsObjectID>(this.player.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_PlayerECM"))); 
            
            if (hasAWACS > 0.0 && CheckCommonRestrictions(npc, true, false)) {
                let j = 0;
                let affiliation = TweakDBInterface.GetCharacterRecord(npc.GetRecordID()).Affiliation().Type();
                while (j < ArraySize(entities)) {
                    if (Equals(affiliation, TweakDBInterface.GetCharacterRecord((entities[j] as NPCPuppet).GetRecordID()).Affiliation().Type())) {
                        StatusEffectHelper.ApplyStatusEffect((entities[j] as NPCPuppet), t"BaseStatusEffect.CEAWACSBuff");    
                    }

                    j += 1;
                }
            }

            // todo - check if player is hostile 
            if (hasRadar > 0.0) {
                let distanceToPlayer = Vector4.Distance(npc.GetWorldPosition(), this.player.GetWorldPosition());
                let radarRange = hasAWACS > 0.0 ? this.settings.awacsRange : this.settings.radarRange;

                if Equals(npc.GetRecordID(), t"Character.q112_arasaka_sniper_01_officer") || Equals(npc.GetRecordID(), t"Character.q112_arasaka_sniper_02") || Equals(npc.GetRecordID(), t"Character.q112_arasaka_sniper_03")|| Equals(npc.GetRecordID(), t"Character.sts_wat_kab_04_ryoko")  {
                    radarRange *= 0.8;
                }

                if ( Equals(npc.GetRecordID(), t"Character.q306_black_ops_netrunner")) {
                    radarRange *= 0.5;
                }

                let state = npc.GetHighLevelStateFromBlackboard();
                if (distanceToPlayer <= radarRange && CheckCommonRestrictions(npc, true, false) && NotEquals(this.player.m_securityAreaTypeE3HACK, ESecurityAreaType.SAFE)) {
                    if (Equals(npc.GetAttitudeTowards(this.player), EAIAttitude.AIA_Hostile) || 
                        (Equals(npc.GetAttitudeTowards(this.player), EAIAttitude.AIA_Neutral) && (Equals(state, gamedataNPCHighLevelState.Alerted) || Equals(state, gamedataNPCHighLevelState.Fear))) ||
                        (Equals(this.player.GetCurrentSecurityZoneType(this.player), gameCityAreaType.RestrictedZone) || Equals(this.player.GetCurrentSecurityZoneType(this.player), gameCityAreaType.DangerousZone))
                        ) {
                        npc.ce_playerTriggeredRadar = true;
                        if (hasAWACS > 0.0) {
                            StatusEffectHelper.ApplyStatusEffect(this.player, t"BaseStatusEffect.CEAWACSDebuff");    
                        }
                        if (npc.ce_radarCounter == 0.0 && (!this.player.IsPuppetInCombat() || hasAWACS > 0.0) ) {
                            npc.CE_AddRadarHighlight(); //todo better highlight / unhighlight logic 
                        }

                        if (this.player.IsPuppetInCombat() && hasAWACS > 0.0 && npc.ce_radarCounter < 8.0) {
                            npc.ce_radarCounter = 8.0;
                        }

                        if (StatusEffectSystem.ObjectHasStatusEffectWithTag(this.player, n"ActiveCamo") || ecmLevel != 0.0) {
                            let randomNumber = RandRange(0, 10);
                            if (ecmLevel != 0.0 && randomNumber == 5 && Equals(npc.GetHighLevelStateFromBlackboard(), gamedataNPCHighLevelState.Relaxed)) {
                                NPCPuppet.ChangeHighLevelState(npc, gamedataNPCHighLevelState.Alerted);
                            }
                            // npc.ce_radarCounter = npc.ce_radarCounter + 0.5; - todo - check if it doesn't break anything
                        } else {
                            npc.ce_radarCounter = npc.ce_radarCounter + 1.0;
                        }

                        ArrayPush(radarNPCs, npc);
                    }
                }
            }

            i += 1;
        }

        i = 0;

        while (i < ArraySize(this.radarNPCs)) {
            if (!this.radarNPCs[i].ce_playerTriggeredRadar) {
                this.radarNPCs[i].ce_radarCounter = 0;
                this.radarNPCs[i].CE_RemoveRadarHighlight();
            }

            i += 1;
        }
        
        if (ArraySize(radarNPCs) > 0 && ArraySize(this.radarNPCs) == 0 && !this.player.IsPuppetInCombat()) {
            let warningMsg: SimpleScreenMessage;
            warningMsg.isShown = true;

            warningMsg.duration = 5;
            if (awacsRange) {
                warningMsg.message = GetLocalizedTextByKey(n"cyberEnemies_radar2");
            } else {
                warningMsg.message = GetLocalizedTextByKey(n"cyberEnemies_radar1");
            }
            
            GameInstance.GetBlackboardSystem(this.player.GetGame()).Get(GetAllBlackboardDefs().UI_Notifications).SetVariant(GetAllBlackboardDefs().UI_Notifications.WarningMessage, ToVariant(warningMsg), true);
        }

        i = 0;

        this.radarNPCs = radarNPCs;

        if (ArraySize(this.radarNPCs) > 0) {
            let maxProgress = -1.0;

            while (i < ArraySize(this.radarNPCs)) {
                let hasAWACS = this.statsSystem.GetStatValue(Cast<StatsObjectID>(this.radarNPCs[i].GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasAWACS"))); 

                if (!NPCPuppet.IsInCombatWithTarget(this.radarNPCs[i], this.player)) {
                    if (this.radarNPCs[i].ce_radarCounter > maxProgress && this.radarNPCs[i].ce_radarCounter <= 8.0) {
                        maxProgress = this.radarNPCs[i].ce_radarCounter;
                        awacsRange = hasAWACS > 0.0; 
                    }

                    if (this.radarNPCs[i].ce_radarCounter >= 8.0) {
                        TargetTrackingExtension.InjectThreat(this.radarNPCs[i], this.player);   
                        if (this.radarNPCs[i].ce_isSpawnedDrone) {
                            TargetTrackingExtension.InjectThreat(this.radarNPCs[i].ce_droneSpawner, this.player);   
                        }
                
                    }
                } else {
                    if (hasAWACS > 0.0) {
                        if (StatusEffectSystem.ObjectHasStatusEffect(this.player, t"BaseStatusEffect.CEAWACSTag")) {
                            StatusEffectHelper.ApplyStatusEffect(this.player, t"BaseStatusEffect.CEAWACSTag");
                        } else {
                            
                            maxProgress = this.radarNPCs[i].ce_radarCounter;
                            awacsRange = true; 
                            if (this.radarNPCs[i].ce_radarCounter >= 16.0) {
                                if (!StatusEffectSystem.ObjectHasStatusEffect(this.player, t"BaseStatusEffect.CEAWACSTag")) {
                                    let warningMsg: SimpleScreenMessage;
                                    warningMsg.isShown = true;

                                    warningMsg.duration = 5;
                                    warningMsg.message = GetLocalizedTextByKey(n"cyberEnemies_radar6");
                                    
                                    GameInstance.GetBlackboardSystem(this.player.GetGame()).Get(GetAllBlackboardDefs().UI_Notifications).SetVariant(GetAllBlackboardDefs().UI_Notifications.WarningMessage, ToVariant(warningMsg), true);
                                }
                                StatusEffectHelper.ApplyStatusEffect(this.player, t"BaseStatusEffect.CEAWACSTag");
                            }
                        }
                    }
                }
                i += 1;
            }

            if (maxProgress >= 0.0) {
                if (awacsRange && maxProgress > 8.0) {
                    if (StatusEffectSystem.ObjectHasStatusEffect(this.player, t"BaseStatusEffect.CEAWACSTag")) {
                        CE_UpdateRadarWidget(true, 0.0, 2);
                    } else {
                        CE_UpdateRadarWidget(true, 1.0 - MinF((maxProgress -8.0)/8.0, 1.0), 1);
                    }
                } else {
                    CE_UpdateRadarWidget(true, 1.0 - MinF(maxProgress/8.0, 1.0), 0);
                }
                
            } else {
                CE_UpdateRadarWidget(false, 0, 0);
            }
        } else {
            CE_UpdateRadarWidget(false, 0, 0);
        }    
    }

    // todo - disable when player is driving
    private func HandleGorgonAbility(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;

        while (i < size) {
            let npc = entities[i] as NPCPuppet;

            let hasGorgon = this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasGorgon"))); 

            if (hasGorgon > 0.0) {
                let playerCamera = this.player.GetFPPCameraComponent();
                // activation
                if (StatusEffectSystem.ObjectHasStatusEffect(this.player, t"BaseStatusEffect.CE_GorgonPlayerEffect1")) {
                    this.gorgonCounter += 1;

                    if (this.gorgonCounter == 2) {
                        StatusEffectHelper.ApplyStatusEffect(this.player, t"BaseStatusEffect.CE_GorgonPlayerEffect2");
                        playerCamera.SetFOV(this.preGorgonFOV * 1.4);
                    }

                    if (this.gorgonCounter == 5) {
                        StatusEffectHelper.ApplyStatusEffect(this.player, t"BaseStatusEffect.CE_GorgonPlayerEffect3");
                        playerCamera.SetFOV(this.preGorgonFOV * 1.6);
                    }

                    if (this.gorgonCounter >= 2) {
                        GameInstance.GetStatPoolsSystem(this.player.GetGame()).RequestChangingStatPoolValue(Cast<StatsObjectID>(this.player.GetEntityID()), gamedataStatPoolType.Memory, -0.5, this.player, false, false);
                        GameInstance.GetStatPoolsSystem(this.player.GetGame()).RequestChangingStatPoolValue(Cast<StatsObjectID>(this.player.GetEntityID()), gamedataStatPoolType.Stamina, -10.0, this.player, false, false);
                    }
                }

                let maxTacGorgon = Equals(npc.GetRecordID(), t"Character.q305_maxtac_miniboss_fshotgun_mb") && NPCPuppet.IsInCombatWithTarget(npc, this.player);

                if (maxTacGorgon && !StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.GorgonGrabCD0")) {
                    StatusEffectHelper.ApplyStatusEffect(this.player, t"BaseStatusEffect.GorgonGrabCD1");
                    StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.GorgonGrabCD0");
                }

                let canMaxTacForceLook = maxTacGorgon && !StatusEffectSystem.ObjectHasStatusEffect(this.player, t"BaseStatusEffect.GorgonGrabCD1") && !StatusEffectSystem.ObjectHasStatusEffect(this.player, t"BaseStatusEffect.GorgonGrabCD2");

                if (IsLookingAtTarget(npc, this.player, 30) && NPCPuppet.IsInCombatWithTarget(npc, this.player) && CheckCommonRestrictions(npc, true, false)) {
                    if (!StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CE_GorgonNPCEffect") && !StatusEffectSystem.ObjectHasStatusEffect(this.player, t"BaseStatusEffect.CE_GorgonPlayerEffect1")) {
                        if ((IsLookingAtTarget(this.player, npc) || canMaxTacForceLook)) {
                            if (!IsLookingAtTarget(this.player, npc)) {
                                StatusEffectHelper.ApplyStatusEffect(this.player, t"BaseStatusEffect.GorgonGrabCD2");
                            }

                            StatusEffectHelper.ApplyStatusEffect(this.player, t"BaseStatusEffect.CE_GorgonPlayerEffect1");
                            StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_GorgonNPCEffect");
                            this.gorgonNpc = npc;

                            this.preGorgonFOV = playerCamera.GetFOV();
                            playerCamera.SetFOV(this.preGorgonFOV * 1.2);

                            this.player.AddGameplayRestriction(this.player.GetPlayerStateMachineBlackboard(), t"GameplayRestriction.NoScanning");

                            this.HandleGorgonCallback();
                        }


                    }
                }
            }

            i += 1;
        }
    }

    private func HandleVoodooAbility(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;

        while (i < size) {
            let npc = entities[i] as NPCPuppet;
            
            let hasVoodoo = this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasVoodoo"))); 
            
            if (hasVoodoo > 0.0 && npc.IsPuppetInCombat() && CheckCommonRestrictions(npc, true, false) && !StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CE_Voodoo")) {
                let healthPercentage = GameInstance.GetStatPoolsSystem(npc.GetGame()).GetStatPoolValue(Cast<StatsObjectID>(npc.GetEntityID()), gamedataStatPoolType.Health);
                let distanceToPlayer = Vector4.Distance(npc.GetWorldPosition(), this.player.GetWorldPosition());
                let npcAttitude = npc.GetAttitudeAgent();

                if (healthPercentage < 50.0 && !StatusEffectSystem.ObjectHasStatusEffectWithTag(npc, n"CommsNoiseJam")) {
                    let j = 0;
                    let canVoodoo = true;
                    while (j < size) {
                        if (i != j) {
                            let distanceToOtherNPC = Vector4.Distance(npc.GetWorldPosition(), (entities[j] as NPCPuppet).GetWorldPosition());
                            let otherAttitudeAgent = (entities[j] as NPCPuppet).GetAttitudeAgent();

                            if (distanceToOtherNPC < distanceToPlayer && Equals(npcAttitude.GetAttitudeTowards(otherAttitudeAgent), EAIAttitude.AIA_Friendly)) {
                                canVoodoo = false;
                            }
                        }

                        j += 1;
                    }

                    if (canVoodoo) {
                        StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.MandessLevel4PlusPlus");
                        StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_Voodoo");
                        StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_VoodooHeal");
                    }
                }
            }

            if (StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CE_VoodooHeal")) {
                GameInstance.GetStatPoolsSystem(npc.GetGame()).RequestChangingStatPoolValue(Cast<StatsObjectID>(npc.GetEntityID()), gamedataStatPoolType.Health, 8, npc, false, true);
            }

            i += 1;
        }
    }
    
    private func HandleFlameArmorAbility(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;

        while (i < size) {
            let npc = entities[i] as NPCPuppet;

            let CE_HasFlameArmor = this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasFlameArmor"))); 

            if (CE_HasFlameArmor > 0.0 && !VehicleComponent.IsMountedToVehicle(this.player.GetGame(), npc) && CheckCommonRestrictions(npc, false, false) && npc.IsPuppetInCombat()) {
                let distanceToPlayer = Vector4.Distance(npc.GetWorldPosition(), this.player.GetWorldPosition());
                if (
                    StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CE_FlameArmorActive") &&
                    !StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CE_FlameArmorCooldown") &&
                    distanceToPlayer < 3.0 &&
                    NPCPuppet.IsInCombatWithTarget(npc, this.player)
                 ) {
                    StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_FlameArmorActivation");
                }

                StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_FlameArmorActive");
            } else {
                if (StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CE_FlameArmorActive")) {
                    StatusEffectHelper.RemoveStatusEffect(npc, t"BaseStatusEffect.CE_FlameArmorActive");   
                }
            }

            i += 1;
        }
    }

    private func HandleElectricPlatingAbility(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;

        while (i < size) {
            let npc = entities[i] as NPCPuppet;

            let CE_HasElectricPlate = this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasElectricPlate"))); 

            if (CE_HasElectricPlate > 0.0 && !VehicleComponent.IsMountedToVehicle(this.player.GetGame(), npc) && CheckCommonRestrictions(npc, false, false) && npc.IsPuppetInCombat()) {
                StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_ElectricPlatingActive");
            } else {
                if (StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CE_ElectricPlatingActive")) {
                    StatusEffectHelper.RemoveStatusEffect(npc, t"BaseStatusEffect.CE_ElectricPlatingActive");   
                }
            }

            i += 1;
        }
    }

    private func HandleFlashStepAbility(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;

        while (i < size) {
            let npc = entities[i] as NPCPuppet;

            let hasFlashStep = this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasFlashStep"))); 
            let HasSandevistan = this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"HasSandevistan"))); 
            let distanceToPlayer = Vector4.Distance(npc.GetWorldPosition(), this.player.GetWorldPosition());

            if (HasSandevistan > 0.0 && hasFlashStep > 0.0 && !VehicleComponent.IsMountedToVehicle(this.player.GetGame(), this.player) && CheckCommonRestrictions(npc, true, false) && !StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CE_FlashStepCD") && NPCPuppet.IsInCombatWithTarget(npc, this.player)) {
                let bb: ref<IBlackboard>;
                let isOnGround: Bool;

                bb = GameInstance.GetBlackboardSystem(GetGameInstance())
                    .GetLocalInstanced(
                        GetPlayer(GetGameInstance()).GetEntityID(),
                        GetAllBlackboardDefs().PlayerStateMachine
                    );

                isOnGround = bb.GetBool(GetAllBlackboardDefs().PlayerStateMachine.IsOnGround);
                if (distanceToPlayer > 4.0 && distanceToPlayer < 25.0 && IsLookingAtTarget(npc, this.player, 45) && isOnGround) {
                    this.TryFlashStep(npc);
                }
            }

            i += 1;
        }
    }

    private func TryFlashStep(npc: ref<NPCPuppet>) {
        let queryDirection: Vector4;

        queryDirection = this.player.GetWorldForward();

        let newPosition: Vector4 = this.player.GetWorldPosition();
        let playerTargetVector: Vector4 = this.player.GetWorldPosition() - npc.GetWorldPosition();

        if (playerTargetVector.X < 0.0) {
            queryDirection.X = -AbsF(queryDirection.X);
        } else {
            queryDirection.X = AbsF(queryDirection.X);
        }

        if (playerTargetVector.Y < 0.0) {
            queryDirection.Y = -AbsF(queryDirection.Y);
        } else {
            queryDirection.Y = AbsF(queryDirection.Y);
        }

        if (!SpatialQueriesHelper.HasSpaceInFront(this.player, queryDirection, 0.1, 0.5, 0.5, 2.0)) { 
            return;
        }

        newPosition.X += queryDirection.X;
        newPosition.Y += queryDirection.Y;

        let rotation: EulerAngles = Quaternion.ToEulerAngles(npc.GetWorldOrientation());

        StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_FlashStepCD");

        GameInstance.GetAudioSystem(npc.GetGame()).Play(StringToName("ce_sonido"), npc.GetEntityID(), n"V");
        let aiCommandEvent: ref<AICommandEvent>;
        aiCommandEvent = new AICommandEvent();
        let aiTeleportCommand: ref<AITeleportCommand> = new AITeleportCommand();
        aiTeleportCommand.position = newPosition;
        aiTeleportCommand.rotation = AngleNormalize180(rotation.Yaw + 180.0);
        aiCommandEvent.command = aiTeleportCommand;
        npc.QueueEvent(aiCommandEvent);
    }

// OnCameraShakeEvent - todo - add from player puppet? and hurt noise
    private func HandleBansheeAbility(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;
        while (i < size) {
            let npc = entities[i] as NPCPuppet;
            let playerInSandevistan = StatusEffectSystem.ObjectHasStatusEffectWithTag(this.player, n"SandevistanPlayerBuff");

            let hasBanshee = this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasBanshee"))); 
            let distanceToPlayer = Vector4.Distance(npc.GetWorldPosition(), this.player.GetWorldPosition());
            // todo - make it work vs npcs too

            let j = 0;
            if (hasBanshee > 0.0 && !VehicleComponent.IsMountedToVehicle(this.player.GetGame(), this.player) && CheckCommonRestrictions(npc, true, false) && !StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CEBansheeCooldown")) {

                if ((distanceToPlayer < 4.0 && !playerInSandevistan && NPCPuppet.IsInCombatWithTarget(npc, this.player) && IsLookingAtTarget(npc, this.player, 60))) {
                    StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CEBansheeChargeUp");
                    StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CEBansheeCooldown");
                    GameInstance.GetAudioSystem(npc.GetGame()).Play(StringToName("banshee1"), npc.GetEntityID(), n"V");
                } else {
                    while (j < size) {
                        let otherNPC = entities[j] as NPCPuppet;
                        let dinstanceToOtherNPC = Vector4.Distance(npc.GetWorldPosition(), otherNPC.GetWorldPosition());

                        if (dinstanceToOtherNPC < 4.5 && NPCPuppet.IsInCombatWithTarget(npc, otherNPC) && IsLookingAtTarget(npc, otherNPC, 60)) {
                            StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CEBansheeChargeUp");
                            StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CEBansheeCooldown");

                            if (distanceToPlayer < 4.0) {
                                GameInstance.GetAudioSystem(npc.GetGame()).Play(StringToName("banshee1"), npc.GetEntityID(), n"V");
                            } else if (distanceToPlayer < 10.0) {
                                GameInstance.GetAudioSystem(npc.GetGame()).Play(StringToName("banshee2"), npc.GetEntityID(), n"V");
                            } else if (distanceToPlayer < 16.0) {
                                GameInstance.GetAudioSystem(npc.GetGame()).Play(StringToName("banshee3"), npc.GetEntityID(), n"V");
                            } else if (distanceToPlayer < 22.0) {
                                GameInstance.GetAudioSystem(npc.GetGame()).Play(StringToName("banshee4"), npc.GetEntityID(), n"V");
                            } else if (distanceToPlayer < 30.0) {
                                GameInstance.GetAudioSystem(npc.GetGame()).Play(StringToName("banshee5"), npc.GetEntityID(), n"V");
                            } else {
                                GameInstance.GetAudioSystem(npc.GetGame()).Play(StringToName("banshee6"), npc.GetEntityID(), n"V");
                            }
                        } 

                        j += 1;
                    }
                }


            }

            i += 1;
        }
    }

    private func HandleMedusaAbility(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;

        while (i < size) {
            let npc = entities[i] as NPCPuppet;
            let playerInSandevistan = StatusEffectSystem.ObjectHasStatusEffectWithTag(this.player, n"SandevistanPlayerBuff");
            let hasMedusa = this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasMedusa"))); 
            let distanceToPlayer = Vector4.Distance(npc.GetWorldPosition(), this.player.GetWorldPosition());

            if (hasMedusa > 0.0 && !playerInSandevistan && !VehicleComponent.IsMountedToVehicle(this.player.GetGame(), this.player) && distanceToPlayer < 4.5 && CheckCommonRestrictions(npc, true, false) && NPCPuppet.IsInCombatWithTarget(npc, this.player)) {
                if (IsLookingAtTarget(this.player, npc, 40.0) && IsLookingAtTarget(npc, this.player, 40) && !StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CEMedusaCooldown")) {
                    StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CEMedusaChargeUp");
                    StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CEMedusaCooldown");
                    
                    let targetNpcRarity: gamedataNPCRarity = npc.GetNPCRarity();
                    let isMaxtac = Equals(targetNpcRarity, gamedataNPCRarity.MaxTac);

                    if (!isMaxtac && NotEquals(npc.GetRecordID(), t"Character.q306_black_ops_fast_ranged")) {
                        GameInstance.GetAudioSystem(npc.GetGame()).Play(StringToName("medusa1"), npc.GetEntityID(), n"V");
                    }
                }
            } 

            i += 1;
        }
    }

    private func HandleDespawningLogic(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;

        while (i < size) {
            let npc = entities[i] as NPCPuppet;
            let distanceToPlayer = Vector4.Distance(npc.GetWorldPosition(), this.player.GetWorldPosition());
            let defeated = NPCPuppet.IsDefeated(npc) || npc.IsDead();

            if (distanceToPlayer > 40.0 && defeated) {
                this.m_entitySystem.DeleteEntity(npc.GetEntityID());
            } 

            i += 1;
        }

    }

    // private func SetUpAVACSTooltip() {
    //     let inkSystem = GameInstance.GetInkSystem();
    //     let hudRoot = inkSystem.GetLayer(n"inkHUDLayer").GetVirtualWindow();

    //     if (!IsDefined(hudRoot)) {
    //         LogChannel(n"DEBUG", "3");
    //         return;
    //     }

    //     this.AVACSwidget = new inkCanvas();
    //     this.AVACSwidget.Reparent(hudRoot);
    //     this.AVACSwidget.SetName(n"CEAWACSWidget");
    //     this.AVACSwidget.SetSize(800, 200);
    //     this.AVACSwidget.SetAnchor(inkEAnchor.Centered);
    //     this.AVACSwidget.SetAnchorPoint(0.5, 2.5);
    //     let textWrapper = new inkCanvas();
    //     textWrapper.SetName(n"textWrapper");
    //     textWrapper.Reparent(this.AVACSwidget);
        
    //     let text1 = new inkText();
    //     text1.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
    //     text1.SetFontSize(22);
    //     text1.SetName(n"text");
    //     text1.BindProperty(n"tintColor", n"MainColors.Black");
    //     text1.BindProperty(n"fontStyle", n"MainColors.HeaderFontWeight");
    //     text1.BindProperty(n"fontSize", n"MainColors.ReadableMedium");
    //     text1.SetText(GetLocalizedTextByKey(n"cyberEnemies_radar1"));
    //     text1.Reparent(textWrapper);

    //     let redContainer = new inkHorizontalPanel();
    //     redContainer.SetName(n"redContainer");
    //     redContainer.Reparent(this.AVACSwidget);

    //     let bracket = new inkCanvas();
    //     bracket.SetMargin(155, 0, 0, 0);
    //     bracket.SetSize(32, 85);
    //     bracket.SetName(n"bracket");
    //     bracket.Reparent(redContainer);

    //     let bracket1 = new inkImage();
    //     bracket1.SetAtlasResource(ResRef.FromString("base\\gameplay\\gui\\widgets\\notifications\\notification_assets.inkatlas"));
    //     bracket1.SetTexturePart(n"notification_bracket_bg");
    //     bracket1.SetAnchor(inkEAnchor.LeftFillVerticaly);
    //     bracket1.SetVAlign(inkEVerticalAlign.Center);
    //     bracket1.SetHAlign(inkEHorizontalAlign.Center);
    //     bracket1.SetName(n"bracket1");
    //     bracket1.SetTintColor(new HDRColor(1.177, 0.381, 0.348, 1.0));
    //     bracket1.Reparent(bracket);

    //     let tbar = new inkCanvas();
    //     tbar.SetAnchor(inkEAnchor.TopRight);
    //     tbar.SetAnchorPoint(1.0, 0);
    //     tbar.SetName(n"tbar");
    //     tbar.Reparent(redContainer);

    //     let tbar1 = new inkImage();
    //     tbar1.SetAtlasResource(ResRef.FromString("base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas"));
    //     tbar1.SetTexturePart(n"color_bg");
    //     tbar1.SetFitToContent(true);
    //     tbar1.SetTintColor(new HDRColor(1.177, 0.381, 0.348, 1.0));
    //     tbar1.SetAnchor(inkEAnchor.Fill);
    //     tbar1.SetNineSliceScale(true);
    //     tbar1.SetName(n"tbar1");
    //     tbar1.Reparent(tbar);
    // }

    private cb func HandleSecondHeart(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;

        while (i < size) {
            let npc = entities[i] as NPCPuppet;

            if (StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CESecondHeartMainEffect")) {
                if (StatusEffectSystem.ObjectHasStatusEffectOfType(npc, gamedataStatusEffectType.Poisoned)) {
                    GameInstance.GetStatPoolsSystem(npc.GetGame()).RequestChangingStatPoolValue(Cast<StatsObjectID>(npc.GetEntityID()), gamedataStatPoolType.Health, 2, npc, false, true);
                } else {
                    GameInstance.GetStatPoolsSystem(npc.GetGame()).RequestChangingStatPoolValue(Cast<StatsObjectID>(npc.GetEntityID()), gamedataStatPoolType.Health, 10, npc, false, true);
                }
                
            }

            i += 1;
        }
    }

    private cb func HandlePhoenixProtocol(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;

        while (i < size) {
            let npc = entities[i] as NPCPuppet;

            if (StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CEPhoenixProtocolMainEffect")) {
                GameInstance.GetStatPoolsSystem(npc.GetGame()).RequestChangingStatPoolValue(Cast<StatsObjectID>(npc.GetEntityID()), gamedataStatPoolType.Health, 10, npc, false, true);
            }

            i += 1;
        }
    }

    private func HandleChimeraSpawner(entities: array<ref<Entity>>) {
        
        let size = ArraySize(entities);
        let i = 0;

        while (i < size) {
            let npc = entities[i] as NPCPuppet;

            if (StatusEffectSystem.ObjectHasStatusEffect(npc, t"Chimera.ChimeraRepairing") && !StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CE_ChimeraPhase2Summon")) {
                StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_ChimeraPhase2Summon");

                let poisonSpec = new DynamicEntitySpec();
                poisonSpec.recordID = t"Character.CE_HasBombDrone1";
                poisonSpec.appearanceName = n"zetatech_bombus__basic_surveillance_drone_01";
                poisonSpec.orientation = npc.GetWorldOrientation();
                poisonSpec.persistState = true;
                poisonSpec.persistSpawn = false;
                poisonSpec.spawnInView = false;
                poisonSpec.tags = [n"CEModPuppet"];

                let vec1 = npc.GetWorldPosition();
                vec1.X += 8.0;
                vec1.Y += 8.0;

                poisonSpec.position = vec1;
                
                this.m_entitySystem.CreateEntity(poisonSpec);
                this.m_entitySystem.CreateEntity(poisonSpec);
                this.m_entitySystem.CreateEntity(poisonSpec);

                let vec2 = npc.GetWorldPosition();
                vec2.X -= 8.0;
                vec2.Y -= 8.0;

                poisonSpec.position = vec2;
                
                this.m_entitySystem.CreateEntity(poisonSpec);
                this.m_entitySystem.CreateEntity(poisonSpec);
                this.m_entitySystem.CreateEntity(poisonSpec);

                let heSpec = new DynamicEntitySpec();
                heSpec.recordID = t"Character.CE_HasHeBombDrone";
                heSpec.appearanceName = n"zetatech_bombus__basic_surveillance_drone_01";
                heSpec.orientation = npc.GetWorldOrientation();
                heSpec.persistState = true;
                heSpec.persistSpawn = false;
                heSpec.spawnInView = false;
                heSpec.tags = [n"CEModPuppet"];

                let vec3 = npc.GetWorldPosition();
                vec3.X += 8.0;
                vec3.Y -= 8.0;

                heSpec.position = vec3;
                
                this.m_entitySystem.CreateEntity(heSpec);
                this.m_entitySystem.CreateEntity(heSpec);
                this.m_entitySystem.CreateEntity(heSpec);

                let vec4 = npc.GetWorldPosition();
                vec4.X -= 8.0;
                vec4.Y += 8.0;

                heSpec.position = vec4;
                
                this.m_entitySystem.CreateEntity(heSpec);
                this.m_entitySystem.CreateEntity(heSpec);
                this.m_entitySystem.CreateEntity(heSpec);
            }

            i += 1;
        }
    }

    private func HandleDroneSpawner(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;

        while (i < size) {
            let npc = entities[i] as NPCPuppet;
            
            let hadDroneSpawner = this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasCombatDrones"))); 

            if (hadDroneSpawner > 0.0 && CheckCommonRestrictions(npc, true, false)) {
                let distanceToPlayer = Vector4.Distance(npc.GetWorldPosition(), this.player.GetWorldPosition());

                if (this.HandleSpawnRestrictions(npc, true) && !IsLookingAtTarget(this.player, npc, 90.0) && distanceToPlayer > 10.0) {
                    if (npc.IsPuppetInCombat() && !StatusEffectSystem.ObjectHasStatusEffectWithTag(npc, n"CE_DroneSpawnerCD")) {
                        if (this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasCombatDronesS1"))) > 0.0) {
                            StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_HasCombatDronesS1Cooldown");
                            this.lastDroneSpawner = npc;

                            let npcSpec = new DynamicEntitySpec();
                            npcSpec.recordID = t"Character.CE_ShooterBombus";
                            npcSpec.appearanceName = n"zetatech_bombus__basic_surveillance_drone_01";
                            npcSpec.position = npc.GetWorldPosition();
                            npcSpec.orientation = npc.GetWorldOrientation();
                            npcSpec.persistState = true;
                            npcSpec.persistSpawn = true;
                            npcSpec.spawnInView = false;
                            npcSpec.tags = [n"CEModPuppet"];

                            this.m_entitySystem.CreateEntity(npcSpec);
                        }
                        
                        if (this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasAWACSWyvern"))) > 0.0) {
                            StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_HasAWACSWyvernCooldown");
                            this.lastDroneSpawner = npc;

                            let npcSpec = new DynamicEntitySpec();
                            npcSpec.recordID = t"Character.CE_WyvernAWACS";
                            npcSpec.position = npc.GetWorldPosition();
                            npcSpec.orientation = npc.GetWorldOrientation();
                            npcSpec.persistState = true;
                            npcSpec.persistSpawn = false;
                            npcSpec.spawnInView = false;
                            npcSpec.tags = [n"CEModPuppet"];

                            this.m_entitySystem.CreateEntity(npcSpec);
                        }
                        
                        if (this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasBombDrone1"))) > 0.0 && !StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CE_HasBombDrone1Cooldown")) {
                            StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_HasBombDrone1Cooldown");
                            this.lastDroneSpawner = npc;

                            let npcSpec = new DynamicEntitySpec();
                            npcSpec.recordID = t"Character.CE_HasBombDrone1";
                            npcSpec.appearanceName = n"zetatech_bombus__basic_surveillance_drone_01";
                            npcSpec.position = npc.GetWorldPosition();
                            npcSpec.orientation = npc.GetWorldOrientation();
                            npcSpec.persistState = true;
                            npcSpec.persistSpawn = false;
                            npcSpec.spawnInView = false;
                            npcSpec.tags = [n"CEModPuppet"];

                            this.m_entitySystem.CreateEntity(npcSpec);
                        }
                        
                        if (this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasMultiHeAndRadar"))) > 0.0 && !StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CE_HasHeBombDroneMultipleCooldown")) {
                            if (npc.spawnedDroneCounter <= 3) {
                                StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_HasHeBombDroneMultipleCooldown");
                                npc.spawnedDroneCounter += 1;
                                this.lastDroneSpawner = npc;

                                let npcSpec = new DynamicEntitySpec();
                                npcSpec.recordID = t"Character.CE_HasHeBombDrone";
                                npcSpec.appearanceName = n"zetatech_bombus__basic_surveillance_drone_01";
                                npcSpec.position = npc.GetWorldPosition();
                                npcSpec.orientation = npc.GetWorldOrientation();
                                npcSpec.persistState = true;
                                npcSpec.persistSpawn = false;
                                npcSpec.spawnInView = false;
                                npcSpec.tags = [n"CEModPuppet"];

                                this.m_entitySystem.CreateEntity(npcSpec);

                                if (Equals(npc.GetRecordID(), t"Character.cbj_ep1_009_cyberjunkie")) {
                                    npcSpec.position = new Vector4(-1639.4456, -2579.3223, 96.95204, 1.0);
                                    this.m_entitySystem.CreateEntity(npcSpec);
                                    npcSpec.position = new Vector4(-1648.9015, -2606.6118, 96.95204, 1.0);
                                    this.m_entitySystem.CreateEntity(npcSpec);
                                    npcSpec.position = new Vector4(-1655.6694, -2586.3438, 96.95204, 1.0);
                                    this.m_entitySystem.CreateEntity(npcSpec);
                                }
                            }
                        }
                        if (this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasMultiPoisonAndRadar"))) > 0.0 && !StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CE_HasPoisonBombDroneMultipleCooldown")) {
                            if (npc.spawnedDroneCounter <= 3) {
                                StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_HasPoisonBombDroneMultipleCooldown");
                                npc.spawnedDroneCounter += 1;
                                this.lastDroneSpawner = npc;

                                let npcSpec = new DynamicEntitySpec();
                                npcSpec.recordID = t"Character.CE_HasBombDrone1";
                                npcSpec.appearanceName = n"zetatech_bombus__basic_surveillance_drone_01";
                                npcSpec.position = npc.GetWorldPosition();
                                npcSpec.orientation = npc.GetWorldOrientation();
                                npcSpec.persistState = true;
                                npcSpec.persistSpawn = false;
                                npcSpec.spawnInView = false;
                                npcSpec.tags = [n"CEModPuppet"];

                                this.m_entitySystem.CreateEntity(npcSpec);
                            }
                        }


                        if (this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasHeBombDrone"))) > 0.0 && !StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CE_HasHeBombDroneCooldown")) {
                            StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_HasHeBombDroneCooldown");
                            this.lastDroneSpawner = npc;

                            let npcSpec = new DynamicEntitySpec();
                            npcSpec.recordID = t"Character.CE_HasHeBombDrone";
                            npcSpec.appearanceName = n"zetatech_bombus__basic_surveillance_drone_01";
                            npcSpec.position = npc.GetWorldPosition();
                            npcSpec.orientation = npc.GetWorldOrientation();
                            npcSpec.persistState = true;
                            npcSpec.persistSpawn = false;
                            npcSpec.spawnInView = false;
                            npcSpec.tags = [n"CEModPuppet"];

                            this.m_entitySystem.CreateEntity(npcSpec);
                        }
                    }

                    

                    if (this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasScannerDronesS1"))) > 0.0 && 
                        Equals(npc.GetHighLevelStateFromBlackboard(), gamedataNPCHighLevelState.Alerted) &&
                        !StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CE_HasScannerDronesS1Cooldown")) {
                            StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_HasScannerDronesS1Cooldown");
                            this.lastDroneSpawner = npc;

                            let npcSpec = new DynamicEntitySpec();
                            npcSpec.recordID = t"Character.CE_ScannerBombus";
                            npcSpec.appearanceName = n"zetatech_bombus__basic_surveillance_drone_01";
                            npcSpec.position = npc.GetWorldPosition();
                            npcSpec.orientation = npc.GetWorldOrientation();
                            npcSpec.persistState = true;
                            npcSpec.persistSpawn = false;
                            npcSpec.spawnInView = false;
                            npcSpec.tags = [n"CEModPuppet"];

                            this.m_entitySystem.CreateEntity(npcSpec);
                    }

                
                    if (this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasAWACSWyvern"))) > 0.0 && 
                        Equals(npc.GetHighLevelStateFromBlackboard(), gamedataNPCHighLevelState.Alerted) &&
                        !StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CE_HasAWACSWyvernCooldown")) {
                        StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_HasAWACSWyvernCooldown");
                        this.lastDroneSpawner = npc;

                        let npcSpec = new DynamicEntitySpec();
                        npcSpec.recordID = t"Character.CE_WyvernAWACS";
                        npcSpec.position = npc.GetWorldPosition();
                        npcSpec.orientation = npc.GetWorldOrientation();
                        npcSpec.persistState = true;
                        npcSpec.persistSpawn = false;
                        npcSpec.spawnInView = false;
                        npcSpec.tags = [n"CEModPuppet"];

                        this.m_entitySystem.CreateEntity(npcSpec);
                    }
                }

            }

            i += 1;

        }
    }

    private func HasTurretSpawner(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;

        while (i < size) {
            let npc = entities[i] as NPCPuppet;
            
            let hasTurretSpawner = this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_CanSpawnTurret"))); 

            if (npc.IsPuppetInCombat() && hasTurretSpawner > 0.0 && CheckCommonRestrictions(npc, true, false) && !StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CETurretSpawningDisabled")) {
                let distanceToPlayer = Vector4.Distance(npc.GetWorldPosition(), this.player.GetWorldPosition());

                if (this.HandleSpawnRestrictions(npc, false) && !VehicleComponent.IsMountedToVehicle(this.player.GetGame(), this.player) && !IsLookingAtTarget(this.player, npc, 120.0) && distanceToPlayer > 18.0) {

                    StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CETurretSpawningDisabled");

                    this.lastTurretSpawner = npc;
                    let deviceSpec = new DynamicEntitySpec();
                    deviceSpec.templatePath = r"base\\gameplay\\devices\\security_systems\\security_turret\\security_turret_1.ent";
                    deviceSpec.position = npc.GetWorldPosition();
                    deviceSpec.orientation = npc.GetWorldOrientation();
                    deviceSpec.persistState = true;
                    deviceSpec.persistSpawn = false;
                    deviceSpec.spawnInView = false;
                    deviceSpec.tags = [n"CyberEnemies.Turret"];
                    this.m_entitySystem.CreateEntity(deviceSpec);
                }

            }

            i += 1;

        }
    }

    private func HandleSpawnRestrictions(npc: ref<NPCPuppet>, small: Bool) -> Bool {
        let worldForward = npc.GetWorldForward();

        if SpatialQueriesHelper.HasSpaceInFront(npc, worldForward, 0.1, 1,  small ? 0.5 : 2,  small ? 0.5 : 2) {
            return true;
        } else {
            return false;
        }

    }

    private func HandleThreatDetector(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;

        while (i < size) {
            let npc = entities[i] as NPCPuppet;
            
            let hasThreatDetector = this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasThreatDetector"))); 
            let hasENCExrayVison: Float = this.statsSystem.GetStatValue(Cast<StatsObjectID>(this.player.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"IMXrayVision"))); 

            i += 1;

            if (hasThreatDetector > 0.0 && IsLookingAtTarget(npc, this.player, 120) && CheckCommonRestrictions(npc, true, false)) {
                let canSeeWhatsUnseen: Float = this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"HasThermovision")));

                if (!(StatusEffectSystem.ObjectHasStatusEffectWithTag(this.player, n"ActiveCamo") && canSeeWhatsUnseen == 0.0)) {
                    

                    if ((hasENCExrayVison > 0.0 || npc.GetSourceShootComponent().CanSeeSecondaryPointOfTarget(this.player)) && !npc.IsPuppetInCombat()) {      
                        if (IsLookingAtTarget(this.player, npc, 30)) {
                            StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CE_ThreatDetectorStack");  
                        }            
                        
                        let CE_ThreatDetectorStack: Float = this.statsSystem.GetStatValue(Cast<StatsObjectID>(this.player.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_ThreatDetectorStack"))); 

                        if (IsLookingAtTarget(this.player, npc) || CE_ThreatDetectorStack >= 3.0) {
                            TargetTrackingExtension.InjectThreat(npc, this.player);   
                            let warningMsg: SimpleScreenMessage;
                            warningMsg.isShown = true;

                            warningMsg.duration = 5;
                            warningMsg.message = GetLocalizedTextByKey(n"cyberEnemies_notification_scanDetector");
                            
                            GameInstance.GetBlackboardSystem(this.player.GetGame()).Get(GetAllBlackboardDefs().UI_Notifications).SetVariant(GetAllBlackboardDefs().UI_Notifications.WarningMessage, ToVariant(warningMsg), true);
                        }

                    }
                }
            } 

        }
    }

    private func HandleJuiceInjector(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;

        while (i < size) {
            let npc = entities[i] as NPCPuppet;
            
            let hasInjector = this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasJuiceInjector"))); 
                //  todo - juice injector should scale stronger for weaker chars? maybe? less for bosses?
            if (hasInjector > 0.0 && CheckCommonRestrictions(npc, false, false)) {
                let healingPercentage = 1.0;
                let targetNpcRarity: gamedataNPCRarity = npc.GetNPCRarity();

                if (Equals(targetNpcRarity, gamedataNPCRarity.Weak) || Equals(targetNpcRarity, gamedataNPCRarity.Trash)) {
                    healingPercentage = this.settings.regenerativeTissueHealWeak;
                }

                if (Equals(targetNpcRarity, gamedataNPCRarity.Normal)) {
                    healingPercentage = this.settings.regenerativeTissueHealNormal;
                }

                if (Equals(targetNpcRarity, gamedataNPCRarity.Rare) || Equals(targetNpcRarity, gamedataNPCRarity.Officer)) {
                    healingPercentage = this.settings.regenerativeTissueHealRare;
                }

                if (Equals(targetNpcRarity, gamedataNPCRarity.Elite)) {
                    healingPercentage = this.settings.regenerativeTissueHealElite;
                }

                if (Equals(targetNpcRarity, gamedataNPCRarity.Boss) || Equals(targetNpcRarity, gamedataNPCRarity.MaxTac)) {
                    healingPercentage = this.settings.regenerativeTissueHealBoss;
                }

                if (StatusEffectSystem.ObjectHasStatusEffectOfType(npc, gamedataStatusEffectType.Poisoned)) {
                    healingPercentage *= 0.2;
                }

                GameInstance.GetStatPoolsSystem(npc.GetGame()).RequestChangingStatPoolValue(Cast<StatsObjectID>(npc.GetEntityID()), gamedataStatPoolType.Health, healingPercentage, npc, false, true);
            } 

            i += 1;
        }
    }

    private func HandleRadarFuckerAbility(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;

        let evt: ref<RadarFuckerEvent> = new RadarFuckerEvent();
        evt.active = false;

        while (i < size) {
            let npc = entities[i] as NPCPuppet;
            
            let hasRadarFucker = this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasRadarFucker"))); 
            let distanceToPlayer = Vector4.Distance(npc.GetWorldPosition(), this.player.GetWorldPosition());

            if (hasRadarFucker > 0.0 && distanceToPlayer <= this.settings.radarFuckerRange && CheckCommonRestrictions(npc, false, false) && NotEquals(npc.GetAttitudeTowards(this.player), EAIAttitude.AIA_Friendly)) {
                evt.active = true;
            } 

            i += 1;
        }

        GameInstance.GetUISystem(GetGameInstance()).QueueEvent(evt);
    }

    private func HandleCryoBulletsAbility() {
        if (StatusEffectSystem.ObjectHasStatusEffect(this.player, t"BaseStatusEffect.CEChilled") && StatusEffectSystem.ObjectHasStatusEffectOfType(this.player, gamedataStatusEffectType.Burning)) {
            GameInstance.GetStatusEffectSystem(this.player.GetGame()).RemoveStatusEffect(this.player.GetEntityID(), t"BaseStatusEffect.CEChilled", Cast<Uint32>(100));
        }
    }

    private func HandlePoisonTankAbility(entities: array<ref<Entity>>) {
        let size = ArraySize(entities);
        let i = 0;

        while (i < size) {
            let npc = entities[i] as NPCPuppet;
            let hasPoisonTank = this.statsSystem.GetStatValue(Cast<StatsObjectID>(npc.GetEntityID()), IntEnum<gamedataStatType>(EnumValueFromName(n"gamedataStatType", n"CE_HasPoisonTank"))); 
            
            if (IsDefined(npc) && hasPoisonTank > 0.0) {
                let distanceToPlayer = Vector4.Distance(npc.GetWorldPosition(), this.player.GetWorldPosition());

                if (!StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CEStartedFightWithPlayer") && NPCPuppet.IsInCombatWithTarget(npc, this.player)) {
                     StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CEStartedFightWithPlayer");
                }

                if (distanceToPlayer < 2.0 &&
                    !StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CEPoisonTankCooldown") &&
                    !StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CEPoisonTankDisabled") &&
                    CheckCommonRestrictions(npc, true, true)) {


                    if (NPCPuppet.IsInCombatWithTarget(npc, this.player) || (npc.IsIncapacitated() && StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CEStartedFightWithPlayer"))) {
                        let attack: ref<Attack_GameEffect>;
                        let attackRecord = t"Attacks.CE_PoisonTank";
                        
                        
                        let flag: SHitFlag;
                        flag.flag =  IntEnum<hitFlag>(Cast<Int32>(EnumValueFromString("hitFlag", "Explosion")));
                        flag.source = n"Attack";
                        let hitFlags: array<SHitFlag> = [flag];
                        let sourcePosition = npc.GetWorldPosition();

                        attack = RPGManager.PrepareGameEffectAttack(npc.GetGame(), npc, npc, attackRecord, sourcePosition, hitFlags, npc);
                        attack.StartAttack();
                        StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CEPoisonTankCooldown");

                        if (npc.IsIncapacitated()) {
                            StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CEPoisonTankDisabled");
                        }
                    }
                }

                if (StatusEffectSystem.ObjectHasStatusEffect(npc, t"BaseStatusEffect.CEPoisonTankCooldown") && StatusEffectSystem.ObjectHasStatusEffectOfType(npc, gamedataStatusEffectType.Burning)) {
                    StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.CEPoisonTankDisabled");

                    let attack: ref<Attack_GameEffect>;
                    let attackRecord = t"Attacks.BaseIncendiaryExplosion";
                    
                    let flag1: SHitFlag;
                    flag1.flag =  IntEnum<hitFlag>(Cast<Int32>(EnumValueFromString("hitFlag", "Explosion")));
                    flag1.source = n"Attack";

                    let flag2: SHitFlag;
                    flag2.flag =  IntEnum<hitFlag>(Cast<Int32>(EnumValueFromString("hitFlag", "DetonateGrenades")));
                    flag2.source = n"DetonateGrenades";

                    let hitFlags: array<SHitFlag> = [flag1, flag2];
                    let sourcePosition = npc.GetWorldPosition();

                    attack = RPGManager.PrepareGameEffectAttack(npc.GetGame(), npc, npc, attackRecord, sourcePosition, hitFlags, npc);
                    attack.StartAttack();

                    StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.Knockdown");
                    StatusEffectHelper.ApplyStatusEffect(npc, t"BaseStatusEffect.Burning");

                    let otherNpcs = npc.GetEntitiesAroundObject(3.0, TSF_NPC());
                    // test - prob not working - todo GetEntitiesAround object??

                    let j = 0;
                    while (j < ArraySize(otherNpcs)) {
                        let otherNpc = otherNpcs[j] as NPCPuppet;
                        StatusEffectHelper.ApplyStatusEffect(otherNpc, t"BaseStatusEffect.Burning");
                        j += 1;
                    }
                }
            }

            i += 1;
        }

    }
}

public class GorgonCallback extends DelayCallback {
  let system: wref<TickSystem>;

  public static func Create(system: ref<TickSystem>) -> ref<GorgonCallback> {
    let self: ref<GorgonCallback> = new GorgonCallback();
    self.system = system;
    return self;
  }

  public func Call() -> Void {
    this.system.HandleGorgonCallback();
  }
}



public class CyberEnemiesTickSystemCallback extends DelayCallback {
  let system: wref<TickSystem>;

  public static func Create(system: ref<TickSystem>) -> ref<CyberEnemiesTickSystemCallback> {
    let self: ref<CyberEnemiesTickSystemCallback> = new CyberEnemiesTickSystemCallback();
    self.system = system;
    return self;
  }

  public func Call() -> Void {
    this.system.HandleCallback();
  }
}