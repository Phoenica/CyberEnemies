module CyberEnemies.ExtraEnemies

import CyberEnemies.Utils.*
import CyberEnemies.TickSystem.*





// class ExtraEnemiesService extends ScriptableSystem {
//   private let m_entitySystem: wref<DynamicEntitySystem>;
//   private let m_callbackSystem: wref<CallbackSystem>;
//   private let m_player: wref<GameObject>;
//   private let m_handled: Bool;

//   // SpawnAreas
//   // public let community_tomAyer: ref<CommunityProxyPS>;
//   // // 

//   // public func GetSpawnerLocation(spawner: TweakDBID) -> wref<CommunityProxyPS> {
//   //   if (Equals(spawner, t"Character.ma_wat_nid_02_outpost_miniboss")) {
//   //     return this.community_tomAyer;
//   //   }



    
//   //   return this.community_tomAyer;
//   // }

//   public static func GetInstance(gameInstance: GameInstance) -> ref<ExtraEnemiesService> {
//       let system: ref<ExtraEnemiesService> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"CyberEnemies.ExtraEnemies.ExtraEnemiesService") as ExtraEnemiesService;
//       return system;
//   }

//   private func OnAttach() {
//     this.m_entitySystem = GameInstance.GetDynamicEntitySystem();
//     this.m_callbackSystem = GameInstance.GetCallbackSystem();


//     this.m_handled = false;
//   }

//   // private func OnRestored(saveVersion: Int32, gameVersion: Int32) {
//   //   if !this.m_handled {
//   //     this.m_handled = true;
//   //     this.HandleSpawning();
//   //   }
//   // }

//   private func OnPlayerAttach(request: ref<PlayerAttachRequest>) {
//     if !this.m_handled {
//       this.m_handled = true;
//       // this.HandleSpawning();
      
//       SpawnNPC(t"Character.we_ep1_17_miniboss", GetPlayer(GetGameInstance()).GetWorldPosition(), this.m_entitySystem);
//     }
//   }


//   // private func HandleSpawning() {
//   //   this.m_handled = true;
//   //   this.m_player = GetPlayer(this.GetGameInstance());

//   // }

// }

public func SpawnNPC(record: TweakDBID, position: Vector4, m_entitySystem: wref<DynamicEntitySystem>) -> Bool {
    if !HasSpaceAbove(position, 1.0, 2.0, 2.0, 2.0) {
      return false;
    }

    let npcSpec = new DynamicEntitySpec();
    npcSpec.recordID = record;
    npcSpec.position = position;
    npcSpec.orientation = GetPlayer(GetGameInstance()).GetWorldOrientation();
    npcSpec.persistState = true;
    npcSpec.persistSpawn = true;
    npcSpec.tags = [n"CEModPuppet", n"CEModExtraEnemies"];

    m_entitySystem.CreateEntity(npcSpec);

    return true;
}

// Attitude Fixers

// @addField(NPCPuppet)
// public let ce_extraAttitudeFixed: Bool;

// @wrapMethod(NPCPuppet)
// protected cb func OnPostInitialize(evt: ref<entPostInitializeEvent>) -> Bool {
//     let outcome = wrappedMethod(evt);

//     let tickSystem: wref<TickSystem> = TickSystem.GetInstance(GetGameInstance());
//     let isModPuppet: Bool;
//     let isExtraSpawnerPuppet: Bool;

//     isModPuppet = NPCManager.HasTag(this.GetRecordID(), n"CEModPuppet");
//     isExtraSpawnerPuppet = tickSystem.m_entitySystem.IsTagged(this.GetEntityID(), n"CEModExtraEnemies");
            
//     if isModPuppet || isExtraSpawnerPuppet {
//         if isExtraSpawnerPuppet {
//             LogChannel(n"DEBUG", "extra: ");
//             let bossSpawner = tickSystem.GetLastExtraSpawner();
//             FixAttitude(bossSpawner, this);
            
//             let extraEnemiesSystem: wref<ExtraEnemiesService> = ExtraEnemiesService.GetInstance(GetGameInstance());
//             let community = extraEnemiesSystem.GetSpawnerLocation(bossSpawner.GetRecordID());
            
//             LogChannel(n"DEBUG", "isDefined: "+ToString(IsDefined(community)));
//             ArrayPush(community.CE_ExtraEntities, this.GetEntityID());
//             LogChannel(n"DEBUG", "kurwa pies jebal: "+ToString(ArraySize(community.CE_ExtraEntities)));
//             extraEnemiesSystem.GetSpawnerLocation(bossSpawner.GetRecordID()).EstablishLink(this.GetEntityID());
//             // extraEnemiesSystem.GetSpawnerLocation(bossSpawner.GetRecordID()).EstablishLink(bossSpawner.GetEntityID());
//             // extraEnemiesSystem.GetSpawnerLocation(bossSpawner.GetRecordID()).GetNetworkArea().AddUser(this.GetEntityID(), ESecurityAccessLevel.ESL_4);
//         } else {
//             let droneSpawner = tickSystem.GetLastDroneSpawner();
//             FixAttitude(droneSpawner, this);
//             let player = GetPlayer(GetGameInstance());
//             this.ce_droneSpawner = droneSpawner;
//             this.ce_isSpawnedDrone = true;

//             NPCPuppet.ChangeHighLevelState(this, gamedataNPCHighLevelState.Alerted);
//             if (NPCPuppet.IsInCombatWithTarget(droneSpawner, player)) {
//                 TargetTrackingExtension.InjectThreat(this, player);  
//             }
//         }

//     }
    
    
//     return outcome;
// }

// @addField(CommunityProxyPS)
// public let CE_ExtraEntities: array<EntityID>;

// @wrapMethod(CommunityProxyPS)
//   public final const func ExtractEntityIDs() -> [EntityID] {
//     let communityEntryNames: array<CName>;
//     let spawnerRecordsIDs: array<EntityID>;
//     let spawnerID: EntityID = this.GetMyEntityID();
//     GetFixedEntityIdsFromSpawnerEntityID(spawnerID, communityEntryNames, this.GetGameInstance(), spawnerRecordsIDs);

//     LogChannel(n"DEBUG", "roomies!: "+ToString(ArraySize(this.CE_ExtraEntities)));
//     let i = 0;

//     while i < ArraySize(this.CE_ExtraEntities) {
//       ArrayPush(spawnerRecordsIDs, this.CE_ExtraEntities[i]);

//       i += 1;
//     } 

//     if !IsFinal() && ArraySize(spawnerRecordsIDs) == 0 {
//     };
//     return spawnerRecordsIDs;
//   }

// @wrapMethod(CommunityProxyPS)
// protected final func InitializeConnectionWithCommunity() -> Void {
//     let communityEntityId = this.GetMyEntityID().ToDebugString();

//     if (StrContains(communityEntityId, "ma_wat_nid_02_openworld/#ma_outpost_01_com"))  {
      
//             LogChannel(n"DEBUG", "community");
//       let extraEnemiesSystem: wref<ExtraEnemiesService> = ExtraEnemiesService.GetInstance(GetGameInstance());
//       extraEnemiesSystem.community_tomAyer = this;
//     }

//     wrappedMethod();
// }

public static func FixAttitude(spawner: wref<NPCPuppet>, spawnedObject: wref<GameObject>) {
    let callerSquadMembers: array<wref<Entity>>;
    let turretAttitudeAgent = spawnedObject.GetAttitudeAgent();
    let spawnerAttitudeAgent = spawner.GetAttitudeAgent();
    let currentTarget: wref<GameObject>;
    let i = 0;

    if AISquadHelper.GetSquadmates(spawner, callerSquadMembers) {
        i = 0;
        while i < ArraySize(callerSquadMembers) {
            currentTarget = callerSquadMembers[i] as GameObject;
            if !IsDefined(currentTarget){
            } else {
                turretAttitudeAgent.SetAttitudeTowards(currentTarget.GetAttitudeAgent(), EAIAttitude.AIA_Friendly);
                currentTarget.GetAttitudeAgent().SetAttitudeTowards(turretAttitudeAgent, EAIAttitude.AIA_Friendly);
        };
        i += 1;
        };
    };
    turretAttitudeAgent.SetAttitudeGroup(spawnerAttitudeAgent.GetAttitudeGroup());
    turretAttitudeAgent.SetAttitudeTowards(spawnerAttitudeAgent, EAIAttitude.AIA_Friendly);
    spawnerAttitudeAgent.SetAttitudeTowards(turretAttitudeAgent, EAIAttitude.AIA_Friendly);

    let squadBaseInterface: ref<PuppetSquadInterface>;
    if (AISquadHelper.GetSquadBaseInterface(spawner, squadBaseInterface)) {
        squadBaseInterface.Join(spawnedObject);
    }

}
