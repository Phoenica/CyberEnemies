module CyberEnemies

import CyberEnemies.Configurations.*




class TweakLoader extends ScriptableService {
    private let preInit: Bool = false;
    private let initialized: Bool = false;

    private let settings: ref<CyberEnemiesSettings>;

    private cb func OnInitialize() {
      this.settings = new CyberEnemiesSettings();

      GameInstance.GetCallbackSystem()
        .RegisterCallback(n"Session/BeforeStart", this, n"OnAfterInit");
    }

  private cb func OnAfterInit(event: ref<GameSessionEvent>) {
      if (!this.preInit) {
        this.preInit = true;
        return;
      }
      
      if (this.initialized) {
        return;
      }

      this.initialized = true;
      // light armor
      // AddAbilityTo(t"AU_HasSubdermalArmorLowAbilityGroup", [
      //   t"Character.militech_ranger1_ranged1_saratoga_ma_inline0",
      //   t"Character.militech_ranger1_ranged1_lexington_ma_inline0"
      // ]);

      // Poison Tank (just scavs?)
      // AddAbilityTo(t"CE_HasCombatDronesS1AbilityGroup", [
      //   t"Character.ep1_scavenger_grunt1_melee1_fists_ma_inline0",
      //   t"Character.ep1_scavenger_grunt1_melee1_fists_wa_inline0",
      //   t"Character.ep1_scavenger_grunt1_ranged1_nova_ma_inline0",
      //   t"Character.ep1_scavenger_grunt1_ranged1_nova_wa_inline0",
      //   t"Character.ep1_scavenger_grunt1_ranged1_slaughtomatic_ma_inline0",
      //   t"Character.ep1_scavenger_grunt1_ranged1_slaughtomatic_wa_inline0",
      //   t"Character.ep1_scavenger_grunt2_melee2_baseball_ma_inline22",
      //   t"Character.ep1_scavenger_grunt2_melee2_knife_ma_inline4",
      //   t"Character.ep1_scavenger_grunt2_melee2_knife_wa_inline4",
      //   t"Character.ep1_scavenger_grunt2_ranged2_copperhead_ma_inline0",
      //   t"Character.ep1_scavenger_grunt2_ranged2_copperhead_wa_inline0",
      //   t"Character.ep1_scavenger_grunt2_ranged2_pulsar_ma_inline0",
      //   t"Character.ep1_scavenger_grunt2_ranged2_pulsar_wa_inline0",
      //   t"Character.ep1_scavenger_grunt2_ranged2_pulsar_wa_inline0",
      //   t"Character.scavenger_grunt1_melee1_fists_ma_inline0",
      //   t"Character.scavenger_grunt1_melee1_fists_wa_inline0",
      //   t"Character.scavenger_grunt1_melee1_fists_wa_inline0",
      //   t"Character.scavenger_grunt1_melee1_tireiron_ma_inline4",
      //   t"Character.scavenger_grunt1_melee1_tireiron_wa_inline4",
      //   t"Character.scavenger_grunt1_melee1_pipewrench_ma_inline4",
      //   t"Character.scavenger_grunt1_melee1_pipewrench_wa_inline4",
      //   t"Character.scavenger_grunt1_ranged1_nova_ma_inline0",
      //   t"Character.scavenger_grunt1_ranged1_nova_wa_inline0",
      //   t"Character.scavenger_grunt1_ranged1_slaughtomatic_ma_inline0",
      //   t"Character.scavenger_grunt1_ranged1_slaughtomatic_wa_inline0",
      //   t"Character.scavenger_grunt2_melee2_baseball_ma_inline22",
      //   t"Character.scavenger_grunt2_melee2_knife_ma_inline4",
      //   t"Character.scavenger_grunt2_melee2_knife_wa_inline4" 
      // ]);

      // test new abilities on this?
      // 
      this.AbilitiesTweaks();
      this.InitializeStoryBosses();
      this.InitializeCrimeBosses();
      this.InitializePsychos();
      this.InitializeScavs();
      this.InitializeVoodoo();
      this.InitializeSixth();
      this.InitializeValentinos();
      this.InitializeTygers();
      this.InitializeAnimals();
      this.InitializeWraiths();
      this.InitializeMaelstormers();
      this.InitializeMercs();
      this.InitializeKangTao();
      this.InitializeSecurity();
      this.InitializeBarghest();
      this.InitializeMilitech();
      this.InitializeArasaka();
      this.InitializeTraumaTeam();
      this.InitializeMechs();
      this.InitializeBiotech();
      this.InitializeBeatsOnBrats();
  }

  @if(ModuleExists("EnemyArmorOverhaul"))
  private func AddEnemyArmorReworkAbilities(character: TweakDBID, abilities: array<TweakDBID>) {
    AddAbilitiesToCharacter(character, abilities);
  }

  @if(!ModuleExists("EnemyArmorOverhaul"))
  private func AddEnemyArmorReworkAbilities(character: TweakDBID, abilities: array<TweakDBID>) {
  }

  private func InitializeMechs() {
      if (this.settings.awacsEnabled) {
        AddAbilitiesToCharacter(t"Character.nid_militech_drone_wyvern_medium_tc", [t"Ability.CE_HasAWACS"]);
        AddAbilitiesToCharacter(t"Character.ma_wbr_nok_05_militech_base_drone_griffin", [t"Ability.CE_HasAWACS"]);
        AddAbilitiesToCharacter(t"Character.dtn_militech_drone_wyvern_hard", [t"Ability.CE_HasAWACS"]);
        AddAbilitiesToCharacter(t"Character.bls_se_militech_drone_wyvern_hard", [t"Ability.CE_HasAWACS"]);
        AddAbilitiesToCharacter(t"Character.bls_se_militech_drone_wyvern_easy", [t"Ability.CE_HasAWACS"]);
        AddAbilitiesToCharacter(t"Character.bls_se_militech_drone_octant_hard", [t"Ability.CE_HasAWACS"]);
        AddAbilitiesToCharacter(t"Character.bls_se_militech_drone_griffin_medium", [t"Ability.CE_HasAWACS"]);
        AddAbilitiesToCharacter(t"Character.q306_black_ops_drone_wyvern", [t"Ability.CE_HasAWACS"]);
        AddAbilitiesToCharacter(t"Character.we_ep1_17_miniboss", [t"Ability.CE_HasAWACS"]);

        


      }
      if (this.settings.radarEnabled) {
        AddAbilitiesToCharacter(t"Character.ina_07_drone_mlilitech", [t"Ability.CE_HasRadar"]);
      }
      
      if (this.settings.hotSwarmEnabled) {
        AddAbilitiesToCharacter(t"Character.nok_security_android_android2_lexington_ma", [t"Ability.CEMachineLearning"]);
        AddAbilitiesToCharacter(t"Character.nok_security_android_android2_ajax_ma", [t"Ability.CEMachineLearning"]);
        AddAbilitiesToCharacter(t"Character.q115_solo_nest_arasaka_droid_fodder", [t"Ability.CEMachineLearning"]);
      }
  }

  private func InitializeBiotech() {
    if (this.settings.bloodPumpEnabled) {
      AddAbilitiesToCharacter(t"Character.sts_dtn_04_security", [
        t"Ability.CE_BloodPump"
      ]);
    }
    if (this.settings.secondHeartEnabled) {
      AddAbilitiesToCharacter(t"Character.sts_dtn_04_target", [
        t"Ability.CESantaMuerta"
      ]);
    }
  }

  private func InitializePsychos() {
    // Zaria Hughes
    
    if (this.settings.flashStepEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_nid_15_psycho", [
        t"Ability.CE_HasFlashStep"
      ]);
    }


    if (this.settings.bansheeEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_nid_15_psycho", [
        t"Ability.CEBanshee"
      ]);
    }

    // Lely Hein
    if (this.settings.radarEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_nid_22_monk", [
        t"Ability.CE_HasRadar"
      ]);
    }
    
    if (this.settings.flameArmorgEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_nid_22_monk", [
        t"Ability.CE_HasFlameArmor"
      ]);
    }
    
    if (this.settings.secondHeartEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_nid_22_monk", [
        t"Ability.CESantaMuerta"
      ]);
    }

    // Matt Liaw
    if (this.settings.dronesEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_kab_02_cyberpsycho", [
        t"Ability.CE_HasMultiHeAndRadar"
      ]);
    }

    if (this.settings.radarEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_kab_02_cyberpsycho", [
        t"Ability.CE_HasRadar"
      ]);
    }

    if (this.settings.threatDetectorEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_kab_02_cyberpsycho", [
        t"Ability.CEThreatDetector"
      ]);
    }
    
    if (this.settings.painEditorEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_kab_02_cyberpsycho", [
        t"Ability.CE_PainEditor"
      ]);
    }

    if (this.settings.bloodPumpEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_kab_02_cyberpsycho", [
        t"Ability.CE_BloodPump"
      ]);
    }

    // LT Mower
    if (this.settings.dronesEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_kab_08_cyberpsycho", [
        t"Ability.CE_HasMultiHeAndRadar"
      ]);
    }

    if (this.settings.radarEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_kab_08_cyberpsycho", [
        t"Ability.CE_HasRadar"
      ]);
    }

    if (this.settings.scanShieldEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_kab_08_cyberpsycho", [
        t"Ability.CEScanShield"
      ]);
    }

    if (this.settings.bloodPumpEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_kab_08_cyberpsycho", [
        t"Ability.CE_BloodPump"
      ]);
    }
    // Alex Johnson

    if (this.settings.regenerativeTissueEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_lch_06_cyberpsycho", [t"Ability.CEJuiceInjector"]); 
    }
    AddAbilitiesToCharacter(t"Character.ma_wat_lch_06_cyberpsycho", [t"Ability.CE_AutoLoader"]); 

    // Elis Carter
    if (this.settings.regenerativeTissueEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_nid_03_shard_psycho", [t"Ability.CEJuiceInjector"]); 
    }

    if (this.settings.secondHeartEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_nid_03_shard_psycho", [t"Ability.CESantaMuerta"]); 
    }

    if (this.settings.radarFuckerEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_nid_03_shard_psycho", [t"Ability.CERadarFucker"]); 
    }

    // Cedric Muller
    if (this.settings.regenerativeTissueEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_cct_dtn_03_cyberpsycho", [t"Ability.CEJuiceInjector"]);
    }

    //Norio
    
    if (this.settings.painEditorEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_cct_dtn_07_cyberpsycho", [
        t"Ability.CE_PainEditor"
      ]);
    }
    
    if (this.settings.painEditorEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_cct_dtn_07_cyberpsycho", [
        t"Ability.CE_PainEditor"
      ]);
    }

    if (this.settings.electricPlatingEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_cct_dtn_07_cyberpsycho", [
        t"Ability.CEElectricPlating"
      ]);
    }

    if (this.settings.flashStepEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_cct_dtn_07_cyberpsycho", [
        t"Ability.CE_HasFlashStep"
      ]);
    }
    // Dao Hun
    if (this.settings.bansheeEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_hey_spr_04_cyberpsycho", [
        t"Ability.CEBanshee"
      ]);
    }

    // Ramirez
    if (this.settings.threatDetectorEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_pac_cvi_08_psycho", [
        t"Ability.CEThreatDetector"
      ]);
    }
    
    if (this.settings.secondHeartEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_pac_cvi_08_psycho", [
        t"Ability.CESantaMuerta"
      ]);
    }

    if (this.settings.shockAndAweEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_pac_cvi_08_psycho", [
        t"Ability.CESmokeTank"
      ]);
    }

    if (this.settings.bloodPumpEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_pac_cvi_08_psycho", [
        t"Ability.CE_BloodPump"
      ]);
    }

    if (this.settings.elementalBulletsEnable) {
        AddAbilitiesToCharacter(t"Character.ma_pac_cvi_08_psycho", [
          t"Ability.CanCauseElectrocution"
        ]);
    }

    // Voodoo Hacker
    if (this.settings.frostBulletsEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_pac_cvi_15_griffin", [
        t"Ability.CECryoBullets"
      ]);
    }

    if (this.settings.dronesEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_pac_cvi_15_griffin", [
        t"Ability.CE_HasCombatDronesS1"
      ]);
    }

    
    if (this.settings.hotSwarmEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_pac_cvi_15_droid", [
        t"Ability.CEMachineLearning"
      ]);
    }    
    
    if (this.settings.phoenixProtocolEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_pac_cvi_15_droid", [
        t"Ability.CEPhoenixProtocol"
      ]);
    }

    if (this.settings.scanShieldEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_pac_cvi_15_cyberpsycho", [
        t"Ability.CEScanShield"
      ]);
    }

    if (this.settings.bloodPumpEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_pac_cvi_15_cyberpsycho", [
        t"Ability.CE_BloodPump"
      ]);
    }

    if (this.settings.aegisEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_pac_cvi_15_cyberpsycho", [
        t"Ability.CE_HasAegis"
      ]);
    }

    if (this.settings.dronesEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_pac_cvi_15_cyberpsycho", [
        t"Ability.CE_HasCombatDronesS1"
      ]);
    }

    // Zion
    if (this.settings.frostBulletsEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_bls_ina_se1_22_psycho", [
        t"Ability.CECryoBullets"
      ]);
    }

    if (this.settings.bloodPumpEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_bls_ina_se1_22_psycho", [
        t"Ability.CE_BloodPump"
      ]);
    }

    if (this.settings.threatDetectorEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_bls_ina_se1_22_psycho", [
        t"Ability.CEThreatDetector"
      ]);
    }

    if (this.settings.gorgonEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_bls_ina_se1_22_psycho", [
        t"Ability.CE_HasGorgon"
      ]);
    }

    if (this.settings.regenerativeTissueEnabled) {
      AddAbilitiesToCharacter(t"Character.cbj_ep1_001_cyberjunkie", [t"Ability.CEJuiceInjector"]); 
    }

    if (this.settings.flashStepEnabled) {
      AddAbilitiesToCharacter(t"Character.cbj_ep1_001_cyberjunkie", [t"Ability.CE_HasFlashStep"]); 
    }

    AddAbilitiesToCharacter(t"Character.cbj_ep1_001_cyberjunkie", [
      t"Ability.CE_PowerPunchKurt"
    ]);

    // Magie


    if (this.settings.bloodPumpEnabled) {
      AddAbilitiesToCharacter(t"Character.cbj_ep1_002_cyberjunkie", [
        t"Ability.CE_BloodPump"
      ]);
    }

    if (this.settings.elementalBulletsEnable) {
        AddAbilitiesToCharacter(t"Character.cbj_ep1_002_cyberjunkie", [
          t"Ability.CanCausePoison"
        ]);
    }

    AddAbilitiesToCharacter(t"Character.cbj_ep1_002_cyberjunkie", [
      t"Ability.HasToxicBlood"
    ]);

    if (this.settings.poisonTankEnabled) {
      AddAbilitiesToCharacter(t"Character.cbj_ep1_002_cyberjunkie", [t"Ability.CEPoisonTank"]); 
    } 

    if (this.settings.aegisEnabled) {
      AddAbilitiesToCharacter(t"Character.cbj_ep1_002_cyberjunkie", [t"Ability.CE_HasAegis"]);
    }

    if (this.settings.secondHeartEnabled) {
      AddAbilitiesToCharacter(t"Character.cbj_ep1_002_cyberjunkie", [t"Ability.CESantaMuerta"]); 
    }

    // Cody
    AddAbilitiesToCharacter(t"Character.cbj_ep1_005_cyberjunkie", [
      t"Ability.CE_PowerPunch"
    ]);

    if (this.settings.painEditorEnabled) {
      AddAbilitiesToCharacter(t"Character.cbj_ep1_005_cyberjunkie", [
        t"Ability.CE_PainEditor"
      ]);
    }

    if (this.settings.electricPlatingEnabled) {
      AddAbilitiesToCharacter(t"Character.cbj_ep1_003_cyberjunkie", [
        t"Ability.CEElectricPlating"
      ]);
    }   

    if (this.settings.flameArmorgEnabled) {
      AddAbilitiesToCharacter(t"Character.cbj_ep1_003_cyberjunkie", [
        t"Ability.CE_HasFlameArmor"
      ]);
    }

    if (this.settings.secondHeartEnabled) {
      AddAbilitiesToCharacter(t"Character.cbj_ep1_006_cyberjunkie", [t"Ability.CESantaMuerta"]); 
    }
    
    if (this.settings.poisonTankEnabled) {
      AddAbilitiesToCharacter(t"Character.cbj_ep1_006_cyberjunkie", [t"Ability.CEPoisonTank"]); 
    }

    
    if (this.settings.dronesEnabled) {
      AddAbilitiesToCharacter(t"Character.cbj_ep1_009_cyberjunkie", [t"Ability.CE_HasMultiHeAndRadar"]);
    }
  }

  private func InitializeCrimeBosses() {
    TweakDBManager.SetFlat(t"CE.BossHPScaling.value", this.settings.crimeBossesHealthScale);
    TweakDBManager.UpdateRecord(t"CE.BossHPScaling");

    SetBoss(t"Character.ma_wat_lch_08_outpost_miniboss");
    SetBoss(t"Character.ma_wat_lch_01_outpost_miniboss");
    SetBoss(t"Character.ma_wat_nid_01_outpost_miniboss");
    SetBoss(t"Character.ma_wat_nid_02_outpost_miniboss");

    SetBoss(t"Character.ma_wbr_jpn_20_outpost_miniboss");
    SetBoss(t"Character.ma_hey_spr_11_outpost_miniboss");
    SetBoss(t"Character.ma_hey_gle_02_outpost_miniboss");
    SetBoss(t"Character.ma_hey_rey_06_outpost_miniboss");
    SetBoss(t"Character.ma_std_arr_03_outpost_miniboss");
    SetBoss(t"Character.ma_pac_cvi_12_outpost_miniboss");
    SetBoss(t"Character.ma_std_rcr_08_outpost_miniboss");
    SetBoss(t"Character.ma_std_rcr_18_outpost_miniboss");    
    SetBoss(t"Character.bls_se_militech_strongarms_hmelee3_fists_mb_elite");    
    SetBoss(t"Character.ma_bls_ina_se1_17_outpost_miniboss");      
    SetBoss(t"Character.ma_bls_se5_07_outpost_miniboss");    
    SetBoss(t"Character.sts_wat_kab_107_taki_kenmochi");    
    SetBoss(t"Character.ma_wat_nid_06_outpost_miniboss");    
    SetBoss(t"Character.Voodoo_Queen");     

    SetBoss(t"Character.cbj_ep1_001_cyberjunkie");    
    SetBoss(t"Character.cbj_ep1_002_cyberjunkie"); 
    SetBoss(t"Character.cbj_ep1_003_cyberjunkie");      
    SetBoss(t"Character.cbj_ep1_004_cyberjunkie");    
    SetBoss(t"Character.cbj_ep1_005_cyberjunkie");    
    SetBoss(t"Character.cbj_ep1_006_cyberjunkie");  
    SetBoss(t"Character.cbj_ep1_007_cyberjunkie");   
    SetBoss(t"Character.cbj_ep1_008_cyberjunkie");    
    SetBoss(t"Character.cbj_ep1_009_cyberjunkie");   
    SetBoss(t"Character.cbj_ep1_010_cyberjunkie");   
    SetBoss(t"Character.cbj_ep1_011_cyberjunkie");         


    

    // Mokomichi Yamada

    if (this.settings.electricPlatingEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_lch_08_outpost_miniboss", [
        t"Ability.CEElectricPlating"
      ]);
    }

    if (this.settings.shockAndAweEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_lch_08_outpost_miniboss", [
        t"Ability.CESmokeTank"
      ]);
    }


    if (this.settings.flashStepEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_lch_08_outpost_miniboss", [
        t"Ability.CE_HasFlashStep"
      ]);
    }

    // Berry Alken
    if (this.settings.painEditorEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_lch_01_outpost_miniboss", [
        t"Ability.CE_PainEditor"
      ]);
    }

    // Yelena
    if (this.settings.opticalCamoEnable) {
      AddAbilitiesToCharacter(t"Character.ma_wat_nid_01_outpost_miniboss", [
        t"Ability.CanUseOpticalCamo"
      ]);
    }

    if (this.settings.gorgonEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_nid_01_outpost_miniboss", [          
          t"Ability.CE_HasGorgon" 
      ]);
    }

    if (this.settings.threatDetectorEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_nid_01_outpost_miniboss", [          
          t"Ability.CEThreatDetector" 
      ]);
    }

    if (this.settings.medusaEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_nid_01_outpost_miniboss", [          
          t"Ability.CEMedusa"
      ]);
    }

    // Danzel
    if (this.settings.secondHeartEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_hey_spr_11_outpost_miniboss", [t"Ability.CESantaMuerta"]); 
    }

    if (this.settings.regenerativeTissueEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_hey_spr_11_outpost_miniboss", [t"Ability.CEJuiceInjector"]); 
    }
    
    if (this.settings.gorgonEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_hey_spr_11_outpost_miniboss", [t"Ability.CE_HasGorgon"]); 
    }

    // Tom  Ayer

    if (this.settings.poisonTankEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_nid_02_outpost_miniboss", [t"Ability.CEPoisonTank"]); // Tom Ayer
    }
    
    if (this.settings.regenerativeTissueEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_nid_02_outpost_miniboss", [t"Ability.CEJuiceInjector"]); // Tom Ayer
    }
    // if (this.settings.secondHeartEnabled) {
    //   AddAbilitiesToCharacter(t"Character.ma_wat_lch_08_outpost_miniboss", [
    //     t"Ability.CESantaMuerta"
    //   ]);
    // }

    // 
    // Minotaur boss
    if (this.settings.aegisEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wbr_nok_05_outpost_miniboss", [t"Ability.CE_HasAegis"]);
    }

    // Shinobu Imai
    if (this.settings.dronesEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wbr_jpn_20_outpost_miniboss", [t"Ability.CE_HasCombatDronesS1"]);
    }

    // Zoe
    if (this.settings.medusaEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_hey_gle_02_outpost_miniboss", [
        t"Ability.CEMedusa"
      ]);
    }

    if (this.settings.secondHeartEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_hey_gle_02_outpost_miniboss", [
        t"Ability.CESantaMuerta"
      ]);
    }

    // Miguel
  
    if (this.settings.secondHeartEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_hey_rey_06_outpost_miniboss", [
        t"Ability.CESantaMuerta"
      ]);
    }
    
    if (this.settings.threatDetectorEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_hey_rey_06_outpost_miniboss", [
        t"Ability.CEThreatDetector"
      ]);
    }
    
    if (this.settings.flashStepEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_hey_rey_06_outpost_miniboss", [
        t"Ability.CE_HasFlashStep"
      ]);
    }

    AddAbilitiesToCharacter(t"Character.ma_hey_rey_06_outpost_miniboss", [
      t"Ability.CE_RapidFire"
    ]);

    // Darius
    if (this.settings.poisonTankEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_std_arr_03_outpost_miniboss", [
        t"Ability.CEPoisonTank"
      ]);
    }

    if (this.settings.bloodPumpEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_std_arr_03_outpost_miniboss", [
        t"Ability.CE_BloodPump"
      ]);
    }

    if (this.settings.dronesEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_std_arr_03_outpost_miniboss", [
        t"Ability.CE_HasMultiPoisonAndRadar"
      ]);
    }

    // Zbyszko
    if (this.settings.threatDetectorEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_pac_cvi_12_outpost_miniboss", [
        t"Ability.CEThreatDetector"
      ]);
    }

    AddAbilitiesToCharacter(t"Character.ma_pac_cvi_12_outpost_miniboss", [
      t"Ability.CE_AutoLoader"
    ]);
    
    AddAbilitiesToCharacter(t"Character.ma_pac_cvi_12_outpost_miniboss", [
      t"Ability.CE_RapidFire"
    ]);

    // Firecracker (Olga Elizabeth)
    AddAbilitiesToCharacter(t"Character.ma_std_rcr_08_outpost_miniboss", [
      t"Ability.CE_RapidFire"
    ]);

    AddAbilitiesToCharacter(t"Character.ma_std_rcr_08_outpost_miniboss", [
      t"Ability.CanUseIncendiaryGrenades"
    ]);

    if (this.settings.elementalBulletsEnable) {
      AddAbilitiesToCharacter(t"Character.ma_std_rcr_08_outpost_miniboss", [
        t"Ability.CanCauseBurn"
      ]);
    }

    if (this.settings.regenerativeTissueEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_std_rcr_08_outpost_miniboss", [t"Ability.CEJuiceInjector"]);
    }

    // Paul Craven

    if (this.settings.regenerativeTissueEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_std_rcr_18_outpost_miniboss", [t"Ability.CEJuiceInjector"]);
    }
    
    if (this.settings.flashStepEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_std_rcr_18_outpost_miniboss", [
        t"Ability.CE_HasFlashStep"
      ]);
    }

    // Max Howe
    if (this.settings.turretsEnabled) {
      AddAbilitiesToCharacter(t"Character.bls_se_militech_strongarms_hmelee3_fists_mb_elite", [
        t"Ability.CECanSpawnTurret"
      ]);
    }
    
    if (this.settings.dronesEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_std_arr_03_outpost_miniboss", [
        t"Ability.CE_HasAWACSWyvern"
      ]);
    }

    // Bruce Ward
    if (this.settings.regenerativeTissueEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_bls_ina_se1_17_outpost_miniboss", [
        t"Ability.CEJuiceInjector"
      ]);
    }

    if (this.settings.poisonTankEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_bls_ina_se1_17_outpost_miniboss", [
        t"Ability.CEPoisonTank"
      ]);
    }

    if (this.settings.painEditorEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_bls_ina_se1_17_outpost_miniboss", [
        t"Ability.CE_PainEditor"
      ]);
    }
    
    if (this.settings.shockAndAweEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_bls_ina_se1_17_outpost_miniboss", [
        t"Ability.CESmokeTank"
      ]);
    }

    // Rufus
    if (this.settings.secondHeartEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_bls_se5_07_outpost_miniboss", [
        t"Ability.CESantaMuerta"
      ]);
    }

    // Anton
    
    if (this.settings.poisonTankEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_pac_wwd_02_outpost_miniboss", [
        t"Ability.CEPoisonTank"
      ]);
    }

    if (this.settings.turretsEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_pac_wwd_02_outpost_miniboss", [
        t"Ability.CECanSpawnTurret"
      ]);
    }

    // Taki
    if (this.settings.shockAndAweEnabled) {
      AddAbilitiesToCharacter(t"Character.sts_wat_kab_107_taki_kenmochi", [
        t"Ability.CESmokeTank"
      ]);
    }

    if (this.settings.bansheeEnabled) {
      AddAbilitiesToCharacter(t"Character.sts_wat_kab_107_taki_kenmochi", [
        t"Ability.CEBanshee"
      ]);
    }

    // Hare
    if (this.settings.painEditorEnabled) {
      AddAbilitiesToCharacter(t"Character.sts_wat_kab_03_solo", [
        t"Ability.CE_PainEditor"
      ]);
    }

    if (this.settings.bloodPumpEnabled) {
      AddAbilitiesToCharacter(t"Character.sts_wat_kab_03_solo", [
        t"Ability.CE_BloodPump"
      ]);
    }

    // Harry
    if (this.settings.radarFuckerEnabled) {
      AddAbilitiesToCharacter(t"Character.sts_wat_nid_06_enemy_officer", [
        t"Ability.CERadarFucker"
      ]);
    }

    // Anna Nox
    if (this.settings.bansheeEnabled) {
      AddAbilitiesToCharacter(t"Character.sts_wat_nid_01_cyberpsycho", [
        t"Ability.CEBanshee"
      ]);
    }

    // Mikhail
    if (this.settings.secondHeartEnabled) {
      AddAbilitiesToCharacter(t"Character.sts_wat_kab_04_tanyimu", [
        t"Ability.CESantaMuerta"
      ]);
    }
    // Tiurina
    if (this.settings.painEditorEnabled) {
      AddAbilitiesToCharacter(t"Character.sts_wat_kab_04_ryoko", [
        t"Ability.CE_PainEditor"
      ]);
    }

    if (this.settings.regenerativeTissueEnabled) {
      AddAbilitiesToCharacter(t"Character.sts_wat_kab_04_ryoko", [
        t"Ability.CEJuiceInjector"
      ]);
    }
    if (this.settings.secondHeartEnabled) {
      AddAbilitiesToCharacter(t"Character.sts_wat_kab_04_ryoko", [
        t"Ability.CESantaMuerta"
      ]);
    }

    
    if (this.settings.medusaEnabled) {
      AddAbilitiesToCharacter(t"Character.sts_wat_kab_04_ryoko", [
        t"Ability.CEMedusa"
      ]);
    }

    if (this.settings.flashStepEnabled) {
      AddAbilitiesToCharacter(t"Character.sts_wat_kab_04_ryoko", [
        t"Ability.CE_HasFlashStep"
      ]);
    }

    if (this.settings.threatDetectorEnabled) {
      AddAbilitiesToCharacter(t"Character.sts_wat_kab_04_ryoko", [
        t"Ability.CEThreatDetector"
      ]);
    }

    if (this.settings.radarEnabled) {
      AddAbilitiesToCharacter(t"Character.sts_wat_kab_04_ryoko", [
        t"Ability.CE_HasRadar"
      ]);
    }

    if (this.settings.scanShieldEnabled) {
      AddAbilitiesToCharacter(t"Character.sts_wat_kab_04_ryoko", [
        t"Ability.CEScanShield"
      ]);
    }

    if (this.settings.electricPlatingEnabled) {
      AddAbilitiesToCharacter(t"Character.sts_wat_kab_04_ryoko", [
        t"Ability.CEElectricPlating"
      ]);
    }

    // Jack Mauser
    if (this.settings.bloodPumpEnabled) {
      AddAbilitiesToCharacter(t"Character.sts_cct_dtn_02_dozy", [
        t"Ability.CE_BloodPump"
      ]);
    }

    // Kaiser
    if (this.settings.bloodPumpEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_nid_06_outpost_miniboss", [
        t"Ability.CE_BloodPump"
      ]);
    }

    
    if (this.settings.radarEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_nid_06_outpost_miniboss", [
        t"Ability.CE_HasRadar"
      ]);
    }
    
    if (this.settings.gorgonEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_nid_06_outpost_miniboss", [
        t"Ability.CE_HasGorgon"
      ]);
    }

    if (this.settings.gorgonEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_nid_06_outpost_miniboss", [
        t"Ability.CE_HasGorgon"
      ]);
    }

    if (this.settings.phoenixProtocolEnabled) {
      AddAbilitiesToCharacter(t"Character.ma_wat_nid_06_outpost_miniboss", [
        t"Ability.CEPhoenixProtocol"
      ]);
    }
  // Ayo Zarin
    if (this.settings.flashStepEnabled) {
      AddAbilitiesToCharacter(t"Character.we_ep1_05_mini_boss", [
        t"Ability.CE_HasFlashStep"
      ]);
    }

    if (this.settings.poisonTankEnabled) {
      AddAbilitiesToCharacter(t"Character.we_ep1_05_mini_boss", [
        t"Ability.CEPoisonTank"
      ]);
    }

    if (this.settings.aegisEnabled) {
      AddAbilitiesToCharacter(t"Character.we_ep1_05_mini_boss", [
        t"Ability.CE_HasAegis"
      ]);
    }

    if (this.settings.voodooEnabled) {
      AddAbilitiesToCharacter(t"Character.we_ep1_05_mini_boss", [
        t"Ability.CE_HasVoodoo"
      ]);
    }
    // Yasha
    if (this.settings.bloodPumpEnabled) {
      AddAbilitiesToCharacter(t"Character.sts_ep1_03_miniboss_placeholder", [
        t"Ability.CE_BloodPump"
      ]);
    }
    
    if (this.settings.poisonTankEnabled) {
      AddAbilitiesToCharacter(t"Character.sts_ep1_03_miniboss_placeholder", [
        t"Ability.CEPoisonTank"
      ]);
    }

    // Boris
    if (this.settings.dronesEnabled) {
      AddAbilitiesToCharacter(t"Character.sts_ep1_08_kgb_boss", [
        t"Ability.CE_HasAWACSWyvern"
      ]);
    }

    if (this.settings.elementalBulletsEnable) {
      AddAbilitiesToCharacter(t"Character.sts_ep1_08_boss_fight_drone", [
        t"Ability.CanCauseBurn"
      ]);
    }

    if (this.settings.painEditorEnabled) {
      AddAbilitiesToCharacter(t"Character.we_ep1_01_mini_boss_1st_phase", [
        t"Ability.CE_PainEditor"
      ]);
    }

    if (this.settings.painEditorEnabled) {
      AddAbilitiesToCharacter(t"Character.we_ep1_01_mini_boss_2nd_phase", [
        t"Ability.CE_PainEditor"
      ]);
    }

    if (this.settings.flameArmorgEnabled) {
      AddAbilitiesToCharacter(t"Character.we_ep1_01_mini_boss_1st_phase", [
        t"Ability.CE_HasFlameArmor"
      ]);
    }

    if (this.settings.flameArmorgEnabled) {
      AddAbilitiesToCharacter(t"Character.we_ep1_01_mini_boss_2nd_phase", [
        t"Ability.CE_HasFlameArmor"
      ]);
    }


    
  }

  private func AbilitiesTweaks() {
    if (this.settings.aegisEnabled) {
      let aegisCooldown = this.settings.aegisCooldown;
      let aegisDuration = this.settings.aegisDuration;
      let aegisShowsInCodes = this.settings.aegisShowInCodex;

      TweakDBManager.SetFlat(t"BaseStatusEffect.CE_AegiesCooldownStat.value", aegisCooldown + aegisDuration);
      TweakDBManager.UpdateRecord(t"BaseStatusEffect.CE_AegiesCooldownStat");

      TweakDBManager.SetFlat(t"BaseStatusEffect.CE_AegiesActiveStat.value", aegisDuration);
      TweakDBManager.UpdateRecord(t"BaseStatusEffect.CE_AegiesActiveStat");

      TweakDBManager.SetFlat(t"Ability.CE_HasAegis.showInCodex", aegisShowsInCodes);
      TweakDBManager.UpdateRecord(t"Ability.CE_HasAegis");
    }

    if (this.settings.bansheeEnabled) {
      let bansheeCooldown = this.settings.bansheeCooldown;
      let bansheeShowsInCodes = this.settings.bansheeShowInCodex;

      TweakDBManager.SetFlat(t"BaseStatusEffect.CEBansheeCooldownDurationStat.value", bansheeCooldown);
      TweakDBManager.UpdateRecord(t"BaseStatusEffect.CEBansheeCooldownDurationStat");

      TweakDBManager.SetFlat(t"Ability.CEBanshee.showInCodex", bansheeShowsInCodes);
      TweakDBManager.UpdateRecord(t"Ability.CEBanshee");
    }

    if (this.settings.bloodPumpEnabled) {
      let bloodPumpCooldown = this.settings.bloodPumpCooldown;
      let bloodPumpShowsInCodes = this.settings.bloodPumpShowInCodex;

      TweakDBManager.SetFlat(t"BaseStatusEffect.CE_BloodPumpCooldownDurationStat.value", bloodPumpCooldown);
      TweakDBManager.UpdateRecord(t"BaseStatusEffect.CE_BloodPumpCooldownDurationStat");

      TweakDBManager.SetFlat(t"Ability.CE_BloodPump.showInCodex", bloodPumpShowsInCodes);
      TweakDBManager.UpdateRecord(t"Ability.CE_BloodPump");
    }

    if (this.settings.electricPlatingEnabled) {
      let electricPlatingShowInCodex = this.settings.electricPlatingShowInCodex;

      TweakDBManager.SetFlat(t"Ability.CEElectricPlating.showInCodex", electricPlatingShowInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CEElectricPlating");
    }

    if (this.settings.flameArmorgEnabled) {
      let flameArmorShowInCodex = this.settings.flameArmorShowInCodex;

      TweakDBManager.SetFlat(t"Ability.CE_HasFlameArmor.showInCodex", flameArmorShowInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CE_HasFlameArmor");
    }

    if (this.settings.flashStepEnabled) {
      let flashStepCooldown = this.settings.flashStepCooldown;
      let flashStepShowInCodex = this.settings.flashStepShowInCodex;

      TweakDBManager.SetFlat(t"BaseStatusEffect.CE_FlashStepCDDurationStat.value", flashStepCooldown);
      TweakDBManager.UpdateRecord(t"BaseStatusEffect.CE_FlashStepCDDurationStat");

      TweakDBManager.SetFlat(t"Ability.CE_HasFlashStep.showInCodex", flashStepShowInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CE_HasFlashStep");
    }

    if (this.settings.gorgonEnabled) {
      let gorgonShowInCodex = this.settings.gorgonShowInCodex;

      TweakDBManager.SetFlat(t"Ability.CE_HasGorgon.showInCodex", gorgonShowInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CE_HasGorgon");
    }

    if (this.settings.gorgonEnabled) {
      let gorgonShowInCodex = this.settings.gorgonShowInCodex;

      TweakDBManager.SetFlat(t"Ability.CE_HasGorgon.showInCodex", gorgonShowInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CE_HasGorgon");
    }

    if (this.settings.poisonTankEnabled) {
      let poisonTankCooldown = this.settings.poisonTankCooldown;
      let poisonTankShowsInCodes = this.settings.poisonTankShowInCodex;

      TweakDBManager.SetFlat(t"BaseStatusEffect.CEPoisonTankCooldownStat.value", poisonTankCooldown);
      TweakDBManager.UpdateRecord(t"BaseStatusEffect.CEPoisonTankCooldownStat");

      TweakDBManager.SetFlat(t"Ability.CEPoisonTank.showInCodex", poisonTankShowsInCodes);
      TweakDBManager.UpdateRecord(t"Ability.CEPoisonTank");
    }

    if (this.settings.regenerativeTissueEnabled) {
      let regenTissueShowInCodex = this.settings.regenerativeTissueShowInCodex;

      TweakDBManager.SetFlat(t"Ability.CEJuiceInjector.showInCodex", regenTissueShowInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CEJuiceInjector");
    }

    if (this.settings.hotSwarmEnabled) {
      let hotSwarmShowsInCodex = this.settings.hotSwarmShowsInCodex;

      TweakDBManager.SetFlat(t"Ability.CEMachineLearning.showInCodex", hotSwarmShowsInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CEMachineLearning");

    }

    if (this.settings.painEditorEnabled) {
      let painEditorShowsInCodex = this.settings.painEditorShowsInCodex;
      let painEditorCooldown = this.settings.painEditorCooldown;
      let painEditorDuration = this.settings.painEditorDuration;

      TweakDBManager.SetFlat(t"Ability.CE_PainEditor.showInCodex", painEditorShowsInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CE_PainEditor");

      TweakDBManager.SetFlat(t"BaseStatusEffect.CE_PainEditorCooldownDurationStat.value", painEditorCooldown);
      TweakDBManager.UpdateRecord(t"BaseStatusEffect.CE_PainEditorCooldownDurationStat");

      TweakDBManager.SetFlat(t"BaseStatusEffect.CE_PainEditorEffectDurationStat.value", painEditorDuration);
      TweakDBManager.UpdateRecord(t"BaseStatusEffect.CE_PainEditorEffectDurationStat");

    }

    if (this.settings.phoenixProtocolEnabled) {
      let phoenixProtocolShowsInCodex = this.settings.phoenixProtocolShowsInCodex;

      TweakDBManager.SetFlat(t"Ability.CEPhoenixProtocol.showInCodex", phoenixProtocolShowsInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CEPhoenixProtocol");
    }

    if (this.settings.radarEnabled) {
      let radarShowsInCodex = this.settings.radarShowsInCodex;

      TweakDBManager.SetFlat(t"Ability.CE_HasRadar.showInCodex", radarShowsInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CE_HasRadar");
    }
    
    if (this.settings.awacsEnabled) {
      let awacsShowsInCodex = this.settings.awacsShowsInCodex;

      TweakDBManager.SetFlat(t"Ability.CE_HasAWACS.showInCodex", awacsShowsInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CE_HasAWACS");
    }

    if (this.settings.scanShieldEnabled) {
      let scanShieldShowsInCodex = this.settings.scanShieldShowInCodex;

      TweakDBManager.SetFlat(t"Ability.CEScanShield.showInCodex", scanShieldShowsInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CEScanShield");

      TweakDBManager.SetFlat(t"Ability.CEScavScanShield.showInCodex", scanShieldShowsInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CEScavScanShield");
    }

    if (this.settings.shockAndAweEnabled) {
      let shockAndAweShowsInCodex = this.settings.shockAndAweShowsInCodex;
      let shockAndAweCooldown = this.settings.shockAndAweCooldown;

      TweakDBManager.SetFlat(t"Ability.CESmokeTank.showInCodex", shockAndAweShowsInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CESmokeTank");

      TweakDBManager.SetFlat(t"BaseStatusEffect.CESmokeTankCooldownDurationStat.value", shockAndAweCooldown);
      TweakDBManager.UpdateRecord(t"BaseStatusEffect.CESmokeTankCooldownDurationStat");
    }

    if (this.settings.secondHeartEnabled) {
      let secondHeartShowsInCodex = this.settings.secondHeartShowInCodex;

      TweakDBManager.SetFlat(t"Ability.CESantaMuerta.showInCodex", secondHeartShowsInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CESantaMuerta");
    }

    if (this.settings.threatDetectorEnabled) {
      let threatDetectorShowsInCodex = this.settings.threatDetectorShowsInCodex;

      TweakDBManager.SetFlat(t"Ability.CEThreatDetector.showInCodex", threatDetectorShowsInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CEThreatDetector");
    }

    if (this.settings.turretsEnabled) {
      let turretsShowsInCodex = this.settings.turretsShowsInCodex;

      TweakDBManager.SetFlat(t"Ability.CECanSpawnTurret.showInCodex", turretsShowsInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CECanSpawnTurret");
    }

    if (this.settings.voodooEnabled) {
      let voodooShowsInCodex = this.settings.voodooShowsInCodex;

      TweakDBManager.SetFlat(t"Ability.CE_HasVoodoo.showInCodex", voodooShowsInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CE_HasVoodoo");
    }
    
    if (this.settings.medusaEnabled) {
      let medusaShowsInCodex = this.settings.medusaShowsInCodex;

      TweakDBManager.SetFlat(t"Ability.CEMedusa.showInCodex", medusaShowsInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CEMedusa");
    }

    if (this.settings.dronesEnabled) {
      let dronesShowInCodex = this.settings.dronesShowInCodex;

      TweakDBManager.SetFlat(t"Ability.CE_HasAWACSWyvern.showInCodex", dronesShowInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CE_HasAWACSWyvern");

      TweakDBManager.SetFlat(t"Ability.CE_HasHeBombDrone.showInCodex", dronesShowInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CE_HasHeBombDrone");
      
      TweakDBManager.SetFlat(t"Ability.CE_HasBombDrone1.showInCodex", dronesShowInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CE_HasBombDrone1");
      
      TweakDBManager.SetFlat(t"Ability.CE_HasScannerDronesS1.showInCodex", dronesShowInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CE_HasScannerDronesS1");
      
      TweakDBManager.SetFlat(t"Ability.CE_HasCombatDronesS1.showInCodex", dronesShowInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CE_HasCombatDronesS1");
      
      TweakDBManager.SetFlat(t"Ability.CE_HasMultiHeAndRadar.showInCodex", dronesShowInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CE_HasMultiHeAndRadar");
      
      TweakDBManager.SetFlat(t"Ability.CE_HasMultiPoisonAndRadar.showInCodex", dronesShowInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CE_HasMultiPoisonAndRadar");
      
      TweakDBManager.SetFlat(t"Ability.CE_HasShootHasScanDrones.showInCodex", dronesShowInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CE_HasShootHasScanDrones");
    }

    if (this.settings.radarFuckerEnabled) {
      let radarFuckerShowsInCodex = this.settings.radarFuckerShowsInCodex;

      TweakDBManager.SetFlat(t"Ability.CERadarFucker.showInCodex", radarFuckerShowsInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CERadarFucker");
    }

    if (this.settings.frostBulletsEnabled) {
      let frostBulletsShowInCodex = this.settings.frostBulletsShowInCodex;

      TweakDBManager.SetFlat(t"Ability.CECryoBullets.showInCodex", frostBulletsShowInCodex);
      TweakDBManager.UpdateRecord(t"Ability.CECryoBullets");
    }

    let autoloaderShowsInCodex = this.settings.autoloaderShowsInCodex;

    TweakDBManager.SetFlat(t"Ability.CE_AutoLoader.showInCodex", autoloaderShowsInCodex);
    TweakDBManager.UpdateRecord(t"Ability.CE_AutoLoader");

    let rapidFireShowsInCodes = this.settings.rapidFireShowsInCodex;

    TweakDBManager.SetFlat(t"Ability.CE_RapidFire.showInCodex", rapidFireShowsInCodes);
    TweakDBManager.UpdateRecord(t"Ability.CE_RapidFire");


  }

  private func InitializeScavs() {
      if (this.settings.scanShieldEnabled) {
        AddAbilityTo(t"CEScavScanShieldAbilityGroup", [
          t"Character.ep1_scavenger_grunt2_melee2_baseball_ma_inline22", // Hooligan
          t"Character.ep1_scavenger_grunt2_melee2_knife_ma_inline4",// Hooligan
          t"Character.ep1_scavenger_grunt2_melee2_knife_wa_inline4",// Hooligan
          t"Character.ep1_scavenger_grunt2_melee2_pipewrench_ma_inline4",// Hooligan
          t"Character.ep1_scavenger_grunt2_melee2_pipewrench_wa_inline4",// Hooligan
          t"Character.scavenger_grunt2_melee2_baseball_ma_inline22",// Hooligan
          t"Character.scavenger_grunt2_melee2_knife_ma_inline4",// Hooligan
          t"Character.scavenger_grunt2_melee2_knife_wa_inline4",// Hooligan
          t"Character.scavenger_grunt2_melee2_pipewrench_ma_inline4",// Hooligan
          t"Character.scavenger_grunt2_melee2_pipewrench_wa_inline4",// Hooligan

          t"Character.ep1_scavenger_grunt2_ranged2_copperhead_ma_inline0", // Crow
          t"Character.ep1_scavenger_grunt2_ranged2_copperhead_wa_inline0", // Crow
          t"Character.ep1_scavenger_grunt2_ranged2_pulsar_ma_inline0", // Crow
          t"Character.ep1_scavenger_grunt2_ranged2_pulsar_wa_inline0", // Crow
          t"Character.scavenger_grunt2_ranged2_copperhead_ma_inline0", // Crow
          t"Character.scavenger_grunt2_ranged2_copperhead_wa_inline0", // Crow
          t"Character.scavenger_grunt2_ranged2_pulsar_ma_inline0", // Crow
          t"Character.scavenger_grunt2_ranged2_pulsar_wa_inline0", // Crow

          t"Character.ep1_scavenger_grunt1_ranged1_nova_ma_inline0", // Rat
          t"Character.ep1_scavenger_grunt1_ranged1_nova_wa_inline0", // Rat
          t"Character.scavenger_grunt1_ranged1_nova_ma_inline0", // Rat
          t"Character.scavenger_grunt1_ranged1_nova_wa_inline0", // Rat
          t"Character.ep1_scavenger_grunt1_ranged1_pulsar_ma_inline0", // Rat
          t"Character.ep1_scavenger_grunt1_ranged1_pulsar_wa_inline0", // Rat
          t"Character.scavenger_grunt1_ranged1_pulsar_ma_inline0", // Rat
          t"Character.scavenger_grunt1_ranged1_pulsar_wa_inline0", // Rat
          t"Character.scavenger_grunt1_ranged1_slaughtomatic_ma_inline0", // Rat
          t"Character.scavenger_grunt1_ranged1_slaughtomatic_wa_inline0", // Rat
          t"Character.ep1_scavenger_grunt1_ranged1_slaughtomatic_ma_inline0", // Rat
          t"Character.ep1_scavenger_grunt1_ranged1_slaughtomatic_wa_inline0", // Rat

          t"Character.ep1_scavenger_elite2_shotgun_igla_ma_inline0", // Hound
          t"Character.ep1_scavenger_elite2_shotgun_tactician_ma_inline0", // Hound
          t"Character.scavenger_elite2_shotgun_igla_ma_inline0", // Hound
          t"Character.scavenger_elite2_shotgun_tactician_ma_inline0", // Hound

          t"Character.scavenger_elite3_sniper2_grad_ma_inline0", // Sniper
          t"Character.ep1_scavenger_elite3_sniper2_grad_ma_inline0", // Sniper
          
          t"Character.ep1_scavenger_grunt1_melee1_fists_ma_inline0", // Thug
          t"Character.ep1_scavenger_grunt1_melee1_fists_wa_inline0", // Thug
          t"Character.ep1_scavenger_grunt1_melee1_pipewrench_ma_inline4", // Thug
          t"Character.ep1_scavenger_grunt1_melee1_pipewrench_wa_inline4", // Thug
          t"Character.ep1_scavenger_grunt1_melee1_tireiron_ma_inline4", // Thug
          t"Character.ep1_scavenger_grunt1_melee1_tireiron_wa_inline4", // Thug
          t"Character.scavenger_grunt1_melee1_fists_ma_inline0", // Thug
          t"Character.scavenger_grunt1_melee1_fists_wa_inline0", // Thug
          t"Character.scavenger_grunt1_melee1_pipewrench_ma_inline4", // Thug
          t"Character.scavenger_grunt1_melee1_pipewrench_wa_inline4", // Thug
          t"Character.scavenger_grunt1_melee1_tireiron_ma_inline4", // Thug
          t"Character.scavenger_grunt1_melee1_tireiron_wa_inline4", // Thug

          t"Character.scavenger_grunt3_netrunner2_nova_ma_rare_inline4", // Spider
          t"Character.scavenger_netrunner2_netrunner2_nova_wa_rare_inline0", // Spider
          t"Character.ep1_scavenger_netrunner2_netrunner2_nova_wa_rare_inline0", // Spider

          t"Character.ep1_scavenger_butcher3_hmelee2_machete_mb_rare_inline6", // Cur
          t"Character.scavenger_butcher3_hmelee2_machete_mb_rare_inline6", // Cur
          
          t"Character.ep1_scavenger_strong3_gunner2_defender_mb_rare_inline0", // Vulture
          t"Character.scavenger_strong3_gunner2_defender_mb_rare_inline0", // Vulture
          t"Character.scavenger_fast2_fmelee2rare_knife_ma_rare_inline8", // Jackal
          t"Character.scavenger_fast3_fmelee3_machete_wa_elite_inline8" // Hyena
        ]);
      }

      if (this.settings.poisonTankEnabled) {
        AddAbilityTo(t"CEKPoisonTankAbilityGroup", [
          t"Character.ep1_scavenger_grunt2_melee2_baseball_ma_inline22", // Hooligan
          t"Character.ep1_scavenger_grunt2_melee2_knife_ma_inline4",// Hooligan
          t"Character.ep1_scavenger_grunt2_melee2_knife_wa_inline4",// Hooligan
          t"Character.ep1_scavenger_grunt2_melee2_pipewrench_ma_inline4",// Hooligan
          t"Character.ep1_scavenger_grunt2_melee2_pipewrench_wa_inline4",// Hooligan
          t"Character.scavenger_grunt2_melee2_baseball_ma_inline22",// Hooligan
          t"Character.scavenger_grunt2_melee2_knife_ma_inline4",// Hooligan
          t"Character.scavenger_grunt2_melee2_knife_wa_inline4",// Hooligan
          t"Character.scavenger_grunt2_melee2_pipewrench_ma_inline4",// Hooligan
          t"Character.scavenger_grunt2_melee2_pipewrench_wa_inline4",// Hooligan

          t"Character.ep1_scavenger_grunt2_ranged2_copperhead_ma_inline0", // Crow
          t"Character.ep1_scavenger_grunt2_ranged2_copperhead_wa_inline0", // Crow
          t"Character.ep1_scavenger_grunt2_ranged2_pulsar_ma_inline0", // Crow
          t"Character.ep1_scavenger_grunt2_ranged2_pulsar_wa_inline0", // Crow
          t"Character.scavenger_grunt2_ranged2_copperhead_ma_inline0", // Crow
          t"Character.scavenger_grunt2_ranged2_copperhead_wa_inline0", // Crow
          t"Character.scavenger_grunt2_ranged2_pulsar_ma_inline0", // Crow
          t"Character.scavenger_grunt2_ranged2_pulsar_wa_inline0", // Crow

          t"Character.ep1_scavenger_grunt1_ranged1_nova_ma_inline0", // Rat
          t"Character.ep1_scavenger_grunt1_ranged1_nova_wa_inline0", // Rat
          t"Character.scavenger_grunt1_ranged1_nova_ma_inline0", // Rat
          t"Character.scavenger_grunt1_ranged1_nova_wa_inline0", // Rat
          t"Character.ep1_scavenger_grunt1_ranged1_pulsar_ma_inline0", // Rat
          t"Character.ep1_scavenger_grunt1_ranged1_pulsar_wa_inline0", // Rat
          t"Character.scavenger_grunt1_ranged1_pulsar_ma_inline0", // Rat
          t"Character.scavenger_grunt1_ranged1_pulsar_wa_inline0", // Rat
          t"Character.scavenger_grunt1_ranged1_slaughtomatic_ma_inline0", // Rat
          t"Character.scavenger_grunt1_ranged1_slaughtomatic_wa_inline0", // Rat
          t"Character.ep1_scavenger_grunt1_ranged1_slaughtomatic_ma_inline0", // Rat
          t"Character.ep1_scavenger_grunt1_ranged1_slaughtomatic_wa_inline0", // Rat

          t"Character.ep1_scavenger_butcher3_hmelee2_machete_mb_rare_inline6", // Cur
          t"Character.scavenger_butcher3_hmelee2_machete_mb_rare_inline6", // Cur
          
          t"Character.ep1_scavenger_strong3_gunner2_defender_mb_rare_inline0", // Vulture
          t"Character.scavenger_strong3_gunner2_defender_mb_rare_inline0" // Vulture
        ]);
      }

      if (this.settings.dronesEnabled) {
        AddAbilityTo(t"CE_HasBombDrone1AbilityGroup", [
          t"Character.ep1_scavenger_strong3_gunner2_defender_mb_rare_inline0", // Vulture
          t"Character.scavenger_strong3_gunner2_defender_mb_rare_inline0" // Vulture
        ]);
      }

      // this.AddEnemyArmorReworkAbilities(t"Character.CE_Scav_ButcherRobot", [
      //   t"Ability.AU_HasSubdermalArmorMediumMech"
      // ]);
      if (this.settings.elementalBulletsEnable) {
        AddAbilitiesToCharacter(t"Character.CE_Scav_ButcherRobot", [
          t"Ability.CanCausePoison"
        ]);
      }
      // Robots in Treating Symptomps

      if (this.settings.phoenixProtocolEnabled) {
        AddAbilitiesToCharacter(t"Character.sts_ep1_12_droid_miniboss", [
          t"Ability.CEPhoenixProtocol"
        ]);
      }

      if (this.settings.hotSwarmEnabled) {
        AddAbilitiesToCharacter(t"Character.sts_ep1_12_droid_miniboss", [t"Ability.CEMachineLearning"]);
        AddAbilitiesToCharacter(t"Character.sts_ep1_12_security_android_android2_ajax_ma", [t"Ability.CEMachineLearning"]);
        AddAbilitiesToCharacter(t"Character.sts_ep1_12_security_android_android2_lexington_ma", [t"Ability.CEMachineLearning"]);
      }
      
  }

  private func InitializeVoodoo() {
      if (this.settings.scanShieldEnabled) {
        AddAbilityTo(t"CEScanShieldAbilityGroup", [
          t"Character.ep1_voodooboys_grunt1_ranged2_saratoga_ma_inline4", // Malfini
          t"Character.ep1_voodooboys_grunt1_ranged2_saratoga_wa_inline4", // Malfini
          t"Character.ep1_voodooboys_grunt1_ranged2_sidewinder_wa_inline0", // Malfini
          t"Character.ep1_voodooboys_grunt1_ranged2_sidewinder_ma_inline4", // Malfini
          t"Character.voodooboys_grunt1_ranged2_saratoga_ma_inline4", // Malfini
          t"Character.voodooboys_grunt1_ranged2_saratoga_wa_inline4", // Malfini
          t"Character.voodooboys_grunt1_ranged2_sidewinder_ma_inline4", // Malfini
          t"Character.voodooboys_grunt1_ranged2_sidewinder_wa_inline0", // Malfini

          t"Character.voodooboys_grunt1coat_shotgun2_palica_ma_inline4", // Snakecharamer
          t"Character.voodooboys_grunt2coat_shotgun2_palica_wa_inline4", // Snakecharamer
          t"Character.ep1_voodooboys_grunt1coat_shotgun2_palica_ma_inline4", // Snakecharamer
          t"Character.ep1_voodooboys_grunt1coat_shotgun2_palica_wa_inline4", // Snakecharamer

          t"Character.voodooboys_grunt1_fmelee2rare_baseball_ma_rare_inline4", // Spirit

          t"Character.voodooboys_netrunner2_netrunner2_lexington_ma_rare_inline0", // Netrunner
          t"Character.voodooboys_netrunner2_netrunner2_lexington_wa_rare_inline0", // Netrunner
          
          t"Character.voodooboys_grunt3coat_shotgun3_zhuo_ma_elite_inline4", // Punisher
          t"Character.ep1_voodooboys_grunt3coat_shotgun3_zhuo_ma_elite_inline4", // Punisher

          t"Character.ep1_voodooboys_netrunner3_netrunner3_quasar_wa_elite_inline0", // Mananbo
          t"Character.voodooboys_netrunner3_netrunner3_quasar_wa_elite_inline0" // Mananbo
        ]);  
      }

      if (this.settings.aegisEnabled) { 
        AddAbilityTo(t"CE_HasAegisAbilityGroup", [
          t"Character.voodooboys_netrunner2_netrunner2_lexington_ma_rare_inline0", // Netrunner
          t"Character.voodooboys_netrunner2_netrunner2_lexington_wa_rare_inline0", // Netrunner
          t"Character.voodooboys_grunt3coat_shotgun3_zhuo_ma_elite_inline4", // Punisher
          t"Character.ep1_voodooboys_grunt3coat_shotgun3_zhuo_ma_elite_inline4", // Punisher
        t"Character.ep1_voodooboys_netrunner3_netrunner3_quasar_wa_elite_inline0", // Mananbo
          t"Character.voodooboys_netrunner3_netrunner3_quasar_wa_elite_inline0" // Mananbo
        ]);  
      }

      if (this.settings.voodooEnabled) {
        AddAbilityTo(t"CE_HasVoodooAbilityGroup", [
          t"Character.voodooboys_grunt1_fmelee2rare_baseball_ma_rare_inline4", // Spirit

          t"Character.voodooboys_netrunner2_netrunner2_lexington_ma_rare_inline0", // Netrunner
          t"Character.voodooboys_netrunner2_netrunner2_lexington_wa_rare_inline0", // Netrunner

          t"Character.ep1_voodooboys_netrunner3_netrunner3_quasar_wa_elite_inline0", // Mananbo
          t"Character.voodooboys_netrunner3_netrunner3_quasar_wa_elite_inline0" // Mananbo
        ]); 
      }

      if (this.settings.gorgonEnabled) { 
        AddAbilityTo(t"CE_HasGorgonAbilityGroup", [
          t"Character.voodooboys_grunt3coat_shotgun3_zhuo_ma_elite_inline4", // Punisher
          t"Character.ep1_voodooboys_grunt3coat_shotgun3_zhuo_ma_elite_inline4" // Punisher
        ]);  
      }

      if (this.settings.dronesEnabled) {
        AddAbilityTo(t"CE_HasScannerDronesS1AbilityGroup", [
          t"Character.voodooboys_netrunner2_netrunner2_lexington_ma_rare_inline0", // Netrunner
          t"Character.voodooboys_netrunner2_netrunner2_lexington_wa_rare_inline0" // Netrunner
        ]);  
        
        AddAbilityTo(t"CE_HasCombatDronesS1AbilityGroup", [
          t"Character.voodooboys_grunt1coat_shotgun2_palica_ma_inline4", // Snakecharamer
          t"Character.voodooboys_grunt2coat_shotgun2_palica_wa_inline4", // Snakecharamer
          t"Character.ep1_voodooboys_grunt1coat_shotgun2_palica_ma_inline4", // Snakecharamer
          t"Character.ep1_voodooboys_grunt1coat_shotgun2_palica_wa_inline4", // Snakecharamer
        t"Character.ep1_voodooboys_netrunner3_netrunner3_quasar_wa_elite_inline0", // Mananbo
          t"Character.voodooboys_netrunner3_netrunner3_quasar_wa_elite_inline0" // Mananbo
        ]);  
      }
  }

  private func InitializeSixth() {
      if (this.settings.bloodPumpEnabled) {
        AddAbilityTo(t"CE_BloodPumpAbilityGroup", [
          t"Character.sixthstreet_patrol2_melee2_baseball_wa_inline4", // Soldier
          t"Character.sixthstreet_patrol2_melee2_baton_wa_inline4", // Soldier
          t"Character.sixthstreet_menace1_shotgun2_tactician_ma_inline0", // Sarge
          t"Character.sixthstreet_menace1_shotgun2_igla_ma_inline4", // Sarge
          t"Character.sixthstreet_menace1_fmelee2_baton_wa_rare_inline4", // Soldier
          t"Character.sixthstreet_menace1_fshotgun2_tactician_wa_rare_inline4", // Sarge
          t"Character.sixthstreet_prepers3_shotgun3_carnage_ma_rare_inline0", // Lieutenant
          t"Character.sixthstreet_patrol2_shotgun3_satara_ma_elite_inline0" // Lieutenant
        ]);  
      }

      if (this.settings.flashStepEnabled) {
        AddAbilityTo(t"CE_HasFlashStepAbilityGroup", [
          t"Character.sixthstreet_menace1_fshotgun2_tactician_wa_rare_inline4" // Sarge
        ]);  
      }

      AddAbilityTo(t"CE_RapidFireAbilityGroup", [
        t"Character.sixthstreet_hooligan_ranged1_nova_ma_inline4", // Recruit
        t"Character.sixthstreet_hooligan_ranged1_nova_wa_inline4", // Recruit
        t"Character.sixthstreet_menace1_shotgun2_igla_ma_inline4", // Sarge
        t"Character.sixthstreet_prepers3_grenadier2_nova_ma_rare_inline0", // Corporal
        t"Character.sixthstreet_prepers3_shotgun3_carnage_ma_rare_inline0" // Lieutenant
      ]);  
  }

  private func InitializeValentinos() {
      if (this.settings.flameArmorgEnabled) {
        AddAbilityTo(t"CE_HasFlameArmorAbilityGroup", [
          t"Character.valentinos_grunt2_melee2_knife_ma_inline4", // Seasoned Thug
          t"Character.valentinos_grunt2_melee2_knife_wa_inline4", // Seasoned Thug
          t"Character.valentinos_grunt2_melee2_machete_ma_inline0", // Seasoned Thug
          t"Character.valentinos_grunt2_melee2_machete_wa_inline0", // Seasoned Thug
          t"Character.valentinos_grunt4_hmelee2_fists_mb_rare_inline0", // Maton
          t"Character.valentinos_grunt4_hmelee2_knife_mb_rare_inline4", // Maton
          t"Character.valentinos_machete_hmelee3_machete_mb_elite_inline4" // Toro
        ]);  
      }

      if (this.settings.painEditorEnabled) {
        AddAbilityTo(t"CE_PainEditorAbilityGroup", [
          t"Character.valentinos_grunt4_hmelee2_fists_mb_rare_inline0", // Maton
          t"Character.valentinos_grunt4_hmelee2_knife_mb_rare_inline4", // Maton
          t"Character.valentinos_shotgun3_shotgun3_testera_ma_elite_inline0", // Sicario
          t"Character.valentinos_sniper_sniper3_grad_wa_elite_inline0" // Franco
        ]);  
      }

      if (this.settings.secondHeartEnabled) {
        AddAbilityTo(t"CESantaMuertaAbilityGroup", [
          t"Character.valentinos_grunt2_melee2_knife_ma_inline4", // Seasoned Thug
          t"Character.valentinos_grunt2_melee2_knife_wa_inline4", // Seasoned Thug
          t"Character.valentinos_grunt2_melee2_machete_ma_inline0", // Seasoned Thug
          t"Character.valentinos_grunt2_melee2_machete_wa_inline0", // Seasoned Thug
          t"Character.valentinos_grunt3_fmelee2_knife_ma_rare_inline4", // Guerro
          t"Character.valentinos_grunt3_fmelee2_machete_ma_rare_inline4", // Guerro
          t"Character.valentinos_strong2_shotgun2_igla_ma_rare_inline4", // Macho
          t"Character.valentinos_machete_hmelee3_machete_mb_elite_inline4", // Toro
          t"Character.valentinos_grunt4_hmelee2_fists_mb_rare_inline0", // Maton
          t"Character.valentinos_grunt4_hmelee2_knife_mb_rare_inline4" // Maton
        
        ]);  
      }

      if (this.settings.flashStepEnabled) {
        AddAbilityTo(t"CE_HasFlashStepAbilityGroup", [
          t"Character.valentinos_shotgun3_shotgun3_testera_ma_elite_inline0" // Sicario
        ]); 
      }
  }

  private func InitializeTygers() {
      if (this.settings.threatDetectorEnabled) {
        AddAbilityTo(t"CEThreatDetectorAbilityGroup", [
          t"Character.tyger_claws_kunoichi_fmelee3_katana_wa_elite_inline4", // Kunoichi
          t"Character.tyger_claws_kunoichi_fmelee3_fists_ma_elite_inline0" // Kunoichi
        ]);  
      }

      if (this.settings.radarEnabled) {
        AddAbilityTo(t"CE_RadarAbilityGroup", [
          t"Character.tygerclaw_gangster3_netrunner_nue_wa_rare_inline4" // Jonin
        ]);  
      }

      if (this.settings.electricPlatingEnabled) {
        AddAbilityTo(t"CEElectricPlatingAbilityGroup", [
          t"Character.tyger_claws_biker1_melee1_baseball_ma_inline0", // Thug
          t"Character.tyger_claws_gangster1_melee1_knife_ma_inline0", // Thug
          t"Character.tyger_claws_biker1_melee1_baseball_wa_inline0", // Thug
          t"Character.tyger_claws_gangster1_melee1_knife_wa_inline0", // Thug
          t"Character.tyger_claws_biker3_shotgun2_tactician_wa_inline0", // Blitzer
          t"Character.tyger_claws_martial_fmelee2_fists_ma_rare_inline0", // Adept
          t"Character.tyger_claws_martial_hmelee2_StrongArms_ma_inline0", // Claw
          t"Character.tyger_claws_gangster3_ranged3_sidewinder_ma_inline4", // Dragoon
          t"Character.tyger_claws_kunoichi_fmelee3_fists_ma_elite_inline0", // Kunoichi
          t"Character.tyger_claws_kunoichi_fmelee3_katana_wa_elite_inline4", // Kunoichi
          t"Character.tyger_claws_biker3_shotgun3_zhuo_ma_elite_inline4" // Blitzer
        ]);  
      }

      if (this.settings.painEditorEnabled) {
        AddAbilityTo(t"CE_PainEditorAbilityGroup", [
          t"Character.tyger_claws_martial_hmelee3_StrongArms_mb_inline0", // Ozeki
          t"Character.tyger_claws_ozeki_hmelee3_kanabo_mb_inline4", // Ozeki
          t"Character.tyger_claws_ozeki_hmelee3_hammer_mb_inline0" // Ozeki
        ]);  
      }

      if (this.settings.flashStepEnabled) {
            AddAbilityTo(t"CE_HasFlashStepAbilityGroup", [
              t"Character.tyger_claws_martial_fmelee2_katana_ma_rare_inline4", // Adept
              t"Character.tyger_claws_kunoichi_fmelee3_katana_wa_elite_inline4" // Kunoichi
            ]);  
      }
      
      AddAbilityTo(t"CE_AutoLoaderAbilityGroup", [
        t"Character.tyger_claws_gangster3_ranged3_sidewinder_ma_inline4" // Dragoon
      ]);  

      if (this.settings.shockAndAweEnabled) {
        AddAbilityTo(t"CEKSmokeTankAbilityGroup", [
          t"Character.tyger_claws_gangster3_ranged3_sidewinder_ma_inline4", // Dragoon
          t"Character.tygerclaw_gangster3_netrunner_nue_wa_rare_inline4", // Jonin
          t"Character.tyger_claws_biker3_shotgun3_zhuo_ma_elite_inline4" // Blitzer
        ]);  
      }

      if (this.settings.bansheeEnabled) {
        AddAbilityTo(t"CEBansheeAbilityGroup", [
          t"Character.tyger_claws_kunoichi_fmelee3_fists_ma_elite_inline0" // Kunoichi
        ]);  
      }

      if (this.settings.medusaEnabled) {
        AddAbilityTo(t"CEMedusaAbilityGroup", [
          t"Character.tyger_claws_kunoichi_fmelee3_katana_wa_elite_inline4" // Kunoichi
        ]);  
      }

      if (this.settings.dronesEnabled) {
        AddAbilityTo(t"CE_HasShootHasScanDronesAbilityGroup", [
          t"Character.tyger_claws_kunoichi_fmelee3_fists_ma_elite_inline0", // Kunoichi
          t"Character.tyger_claws_kunoichi_fmelee3_katana_wa_elite_inline4" // Kunoichi
        ]);  
      }

      if (this.settings.radarEnabled) {
        AddAbilityTo(t"CE_HasMultiHeAndRadarAbilityGroup", [
          t"Character.tygerclaw_gangster3_netrunner_nue_wa_rare_inline4" // Jonin
        ]);  
      }
  }

  private func InitializeAnimals() {
      if (this.settings.painEditorEnabled) {
        AddAbilityTo(t"CE_PainEditorAbilityGroup", [
          t"Character.animals_bouncer2_hmelee2_fists_mba_rare_inline0", // Undertaker
          t"Character.animals_bouncer2_hmelee2_hammer_mba_rare_inline0", // Undertaker
          t"Character.animals_elite2_hmelee2_fists_mba_rare_inline0", // Undertaker
          t"Character.animals_grunt2_hmelee2_fists_wba_rare_inline0", // Undertaker
          t"Character.animals_elite2_hmelee2_hammer_mba_rare_inline0", // Undertaker
          t"Character.animals_grunt2_hmelee2_hammer_wba_rare_inline0", // Undertaker
          t"Character.animals_elite2_ranged3_burya_mba_rare_inline4", // Ogre
          t"Character.animals_bouncer3_hmelee3_fists_mba_elite_inline0", // Thickskull
          t"Character.animals_elite3_hmelee3_fists_mba_elite_inline0" // Thickskull
        ]);  
      }

      if (this.settings.secondHeartEnabled) {
        AddAbilityTo(t"CESantaMuertaAbilityGroup", [
          t"Character.animals_grunt3_gunner2_defender_mb_rare_inline0", // Crusher
          t"Character.animals_elite2_shotgun3_carnage_wba_elite_inline4", // Jackhammer
          t"Character.animals_elite2_shotgun3_testera_wba_elite_inline4", // Jackhammer
          t"Character.animals_elite3_shotgun3_carnage_mba_elite_inline4" // Jackhammer
        ]);  
      }

      if (this.settings.regenerativeTissueEnabled) {
        AddAbilityTo(t"CEJuiceInjectorAbilityGroup", [
          t"Character.animals_elite2_ranged3_burya_mba_rare_inline4", // Ogre
          t"Character.animals_bouncer3_hmelee3_fists_mba_elite_inline0", // Thickskull
          t"Character.animals_elite3_gunner3_hmg_mba_elite_inline2", // Wrecker
          t"Character.animals_elite3_hmelee3_fists_mba_elite_inline0" // Thickskull
          
        ]); 
      }
      
  }

  private func InitializeWraiths() {
      if (this.settings.threatDetectorEnabled) {
        AddAbilityTo(t"CEThreatDetectorAbilityGroup", [
          t"Character.wraiths_grunt2_ranged2_copperhead_wa_inline0", // Devil
          t"Character.wraiths_grunt2_ranged2_pulsar_wa_inline0", // Devil
          t"Character.wraiths_ghost2_sniper2_achilles_ma_rare_inline0", // Sniper
          t"Character.wraiths_prisoner_fmelee3_fists_ma_elite_inline0", // Revenant
          t"Character.wraiths_strong_gunner3_hmg_mb_elite_inline0" // Goliath
        ]); 
      }

      if (this.settings.radarEnabled) {
        AddAbilityTo(t"CE_RadarAbilityGroup", [
          t"Character.wraiths_grunt2_ranged2_copperhead_ma_inline0", // Hunter
          t"Character.wraiths_grunt2_ranged2_pulsar_ma_inline0", // Hunter
          t"Character.wraiths_ghost2_sniper2_achilles_ma_rare_inline0", // Sniper
          t"Character.wraiths_warrior3_shotgun3_satara_ma_elite_inline0" // Bane
        ]); 
      }

      if (this.settings.scanShieldEnabled) {
        AddAbilityTo(t"CEScanShieldAbilityGroup", [
          t"Character.wraiths_grunt2_ranged2_copperhead_ma_inline0", // Hunter
          t"Character.wraiths_grunt2_ranged2_copperhead_wa_inline0", // Devil
          t"Character.wraiths_grunt2_ranged2_pulsar_ma_inline0", // Hunter
          t"Character.wraiths_grunt2_ranged2_pulsar_wa_inline0", // Devil
          t"Character.wraiths_warrior3_shotgun3_palica_ma_elite_inline2", // Bane
          t"Character.wraiths_ghost2_sniper2_achilles_ma_rare_inline0", // Sniper
          t"Character.wraiths_operator3_shotgun2_crusher_ma_rare_inline4", // Ghoul
          t"Character.wraiths_warrior3_melee3_hammer_wa_rare_inline0", // Skewer
          t"Character.wraiths_warrior3_ranged3_quasar_wa_rare_inline4", // Ghoul
          t"Character.wraiths_prisoner_fmelee3_fists_ma_elite_inline0", // Revenant
          t"Character.wraiths_strong_gunner3_hmg_mb_elite_inline0", // Goliath
          t"Character.wraiths_warrior3_shotgun3_satara_ma_elite_inline0" // Bane
        ]); 
      }

      if (this.settings.poisonTankEnabled) {
        AddAbilityTo(t"CEKPoisonTankAbilityGroup", [
          t"Character.wraiths_operator3_shotgun2_crusher_ma_rare_inline4", // Ghoul
          t"Character.wraiths_warrior3_ranged3_quasar_wa_rare_inline4" // Ghoul
        ]); 
      }

      if (this.settings.painEditorEnabled) {
        AddAbilityTo(t"CE_PainEditorAbilityGroup", [
          t"Character.wraiths_ghost2_sniper2_achilles_ma_rare_inline0", // Sniper
          t"Character.wraiths_warrior3_melee3_hammer_wa_rare_inline0", // Skewer
          t"Character.wraiths_strong_gunner3_hmg_mb_elite_inline0", // Goliath
          t"Character.wraiths_warrior3_shotgun3_satara_ma_elite_inline0" // Bane
        ]); 
      }

      if (this.settings.regenerativeTissueEnabled) {
        AddAbilityTo(t"CEJuiceInjectorAbilityGroup", [
          t"Character.wraiths_grunt1_ranged1_nova_ma_inline0", // Marauder
          t"Character.wraiths_grunt1_ranged1_nova_wa_inline0", // Marauder
          t"Character.wraiths_grunt1_ranged1_pulsar_ma_inline0", // Marauder
          t"Character.wraiths_grunt1_ranged1_pulsar_wa_inline0", // Marauder
          t"Character.wraiths_grunt2_ranged2_copperhead_ma_inline0", // Hunter
          t"Character.wraiths_grunt2_ranged2_copperhead_wa_inline0", // Devil
          t"Character.wraiths_grunt2_ranged2_pulsar_ma_inline0", // Hunter
          t"Character.wraiths_grunt2_ranged2_pulsar_wa_inline0", // Devil
          t"Character.wraiths_warrior3_shotgun3_palica_ma_elite_inline2", // Bane
          t"Character.wraiths_ghost2_sniper2_achilles_ma_rare_inline0", // Sniper
          t"Character.wraiths_operator3_shotgun2_crusher_ma_rare_inline4", // Ghoul
          t"Character.wraiths_warrior3_melee3_hammer_wa_rare_inline0", // Skewer
          t"Character.wraiths_warrior3_ranged3_quasar_wa_rare_inline4", // Ghoul
          t"Character.wraiths_prisoner_fmelee3_fists_ma_elite_inline0", // Revenant
          t"Character.wraiths_strong_gunner3_hmg_mb_elite_inline0", // Goliath
          t"Character.wraiths_warrior3_shotgun3_satara_ma_elite_inline0" // Bane
        ]); 
      }

      AddAbilityTo(t"CE_AutoLoaderAbilityGroup", [
        t"Character.wraiths_grunt2_ranged2_pulsar_ma_inline0", // Hunter
        t"Character.wraiths_grunt2_ranged2_pulsar_wa_inline0" // Devil
      ]); 

      if (this.settings.dronesEnabled) {
        AddAbilityTo(t"CE_HasBombDrone1AbilityGroup", [
          t"Character.wraiths_grunt1_ranged1_nova_ma_inline0", // Marauder
          t"Character.wraiths_grunt1_ranged1_nova_wa_inline0", // Marauder
          t"Character.wraiths_grunt1_ranged1_pulsar_ma_inline0", // Marauder
          t"Character.wraiths_grunt1_ranged1_pulsar_wa_inline0" // Marauder
        ]); 

        AddAbilityTo(t"CE_HasShootHasScanDronesAbilityGroup", [
          t"Character.wraiths_strong_gunner3_hmg_mb_elite_inline0" // Goliath
        ]); 
      }

      if (this.settings.radarEnabled) {
        AddAbilityTo(t"CE_HasMultiPoisonAndRadarAbilityGroup", [
          t"Character.wraiths_ghost2_sniper2_achilles_ma_rare_inline0" // Sniper
        ]); 
      }
  }

  private func InitializeMaelstormers() {
      if (this.settings.radarEnabled) {
        AddAbilityTo(t"CE_RadarAbilityGroup", [
          t"Character.maelstrom_fast_sniper2_grad_ma_inline0", // Raven
          t"Character.maelstrom_techie_grenadier2_lexington_ma_inline6" // Techie
        ]); 
        
        AddAbilitiesToCharacter(t"Character.maelstrom_android_android2_copperhead_ma", [t"Ability.CE_HasRadar"]);
        AddAbilitiesToCharacter(t"Character.maelstrom_android_android2_pulsar_ma", [t"Ability.CE_HasRadar"]);
        AddAbilitiesToCharacter(t"Character.nid_maelstrom_android_android2_pulsar_ma", [t"Ability.CE_HasRadar"]);
        AddAbilitiesToCharacter(t"Character.sq031_maelstrom_ajax", [t"Ability.CE_HasRadar"]);
      }

    if (this.settings.turretsEnabled) {
      AddAbilityTo(t"CECanSpawnTurretAbilityGroup", [          
          t"Character.maelstrom_techie_grenadier2_lexington_ma_inline6" // Techie
      ]); 
    }

      if (this.settings.flameArmorgEnabled) {
        AddAbilityTo(t"CE_HasFlameArmorAbilityGroup", [
          t"Character.maelstrom_techie_grenadier2_lexington_ma_inline6", // Techie        
          t"Character.maelstrom_fast2_fmelee2_knife_ma_rare_inline4", // Zaelot
          t"Character.maelstrom_fast_fmelee2_machete_ma_rare_inline4" // Zaelot
        ]); 

        AddAbilitiesToCharacter(t"Character.maelstrom_android_android2_copperhead_ma", [t"Ability.CE_HasFlameArmor"]);
        AddAbilitiesToCharacter(t"Character.maelstrom_android_android2_pulsar_ma", [t"Ability.CE_HasFlameArmor"]);
        AddAbilitiesToCharacter(t"Character.nid_maelstrom_android_android2_pulsar_ma", [t"Ability.CE_HasFlameArmor"]);
        AddAbilitiesToCharacter(t"Character.sq031_maelstrom_ajax", [t"Ability.CE_HasFlameArmor"]);
      }



      if (this.settings.aegisEnabled) {
        AddAbilityTo(t"CE_HasAegisAbilityGroup", [
          t"Character.maelstrom_netrunner_netrunner2_lexington_ma_inline4" // CodeFreak     
        ]); 
      }

      if (this.settings.painEditorEnabled) {
        AddAbilityTo(t"CE_PainEditorAbilityGroup", [        
          t"Character.maelstom_strong_shotgun2_carnage_ma_rare_inline17", // Maniac
          t"Character.maelstom_strong_shotgun2_igla_ma_inline0", // Maniac
          t"Character.maelstrom_fast2_fmelee2_knife_ma_rare_inline4", // Zaelot
          t"Character.maelstrom_fast_fmelee2_machete_ma_rare_inline4" // Zaelot
        ]); 
      }

      AddAbilityTo(t"CE_AutoLoaderAbilityGroup", [
        t"Character.maelstrom_strong_gunner2_defender_mb_rare_inline0", // Ironstormer     
        t"Character.maelstrom_fast_franged2_pulsar_ma_rare_inline4" // Good     
      ]); 

      if (this.settings.elementalBulletsEnable) {
        AddAbilityTo(t"CE_CanCauseBurnAbilityGroup", [        
          t"Character.maelstrom_grunt1_ranged1_copperhead_ma_inline0", // Fanatic
          t"Character.maelstrom_grunt1_ranged1_copperhead_wa_inline0", // Fanatic
          t"Character.maelstrom_grunt1_ranged1_lexington_ma_inline0", // Fanatic
          t"Character.maelstrom_grunt1_ranged1_lexington_wa_inline0" // Fanatic
        ]); 
      }

      if (this.settings.medusaEnabled) {
        AddAbilityTo(t"CEMedusaAbilityGroup", [                
          t"Character.maelstrom_fast_fmelee3_mantis_wa_elite_inline10" // Fiend
        ]); 
      }

      if (this.settings.gorgonEnabled) { 
        AddAbilityTo(t"CE_HasGorgonAbilityGroup", [                
          t"Character.maelstrom_fast_fmelee3_mantis_wa_elite_inline10", // Fiend
          t"Character.maelstrom_strong_gunner2_defender_mb_rare_inline0" // Ironstormer
        ]); 
      }

      if (this.settings.dronesEnabled) {
        AddAbilityTo(t"CE_HasShootHasScanDronesAbilityGroup", [                
          t"Character.maelstrom_netrunner_netrunner2_lexington_ma_inline4" // Codefreak
        ]); 

        AddAbilityTo(t"CE_HasMultiHeAndRadarAbilityGroup", [                
          t"Character.maelstrom_techie_grenadier2_lexington_ma_inline6" // Techie
        ]); 
      }


      if (this.settings.healthMonitorEnable) {
        AddAbilityTo(t"CE_HealthBomb", [
            t"Character.maelstom_strong_shotgun2_carnage_ma_rare_inline17", // Maniac
            t"Character.maelstom_strong_shotgun2_igla_ma_inline0", // Maniac
            t"Character.maelstrom_fast2_fmelee2_knife_ma_rare_inline4", // Zaelot
            t"Character.maelstrom_fast_fmelee2_machete_ma_rare_inline4", // Zaelot
            t"Character.maelstrom_grunt1_ranged1_copperhead_ma_inline0", // Fanatic
            t"Character.maelstrom_grunt1_ranged1_copperhead_wa_inline0", // Fanatic
            t"Character.maelstrom_grunt1_ranged1_lexington_ma_inline0", // Fanatic
            t"Character.maelstrom_grunt1_ranged1_lexington_wa_inline0" // Fanatic
        ]);
      }

      if (this.settings.radarFuckerEnabled) {
        AddAbilityTo(t"CERadarFuckerAbilityGroup", [
          t"Character.maelstrom_grunt2_melee2_hammer_ma_inline4", // Goon
          t"Character.maelstrom_grunt2_melee2_hammer_wa_inline4", // Goon
          t"Character.maelstrom_grunt2_melee2_machete_ma_inline4", // Goon
          t"Character.maelstrom_grunt2_melee2_machete_wa_inline4", // Goon
          t"Character.maelstrom_grunt2_ranged2_ajax_ma_inline0", // Goon
          t"Character.maelstrom_grunt2_ranged2_ajax_wa_inline0", // Goon
          t"Character.maelstrom_grunt2_ranged2_copperhead_ma_inline0", // Goon
          t"Character.maelstrom_grunt2_ranged2_copperhead_wa_inline0", // Goon

          t"Character.maelstom_strong_shotgun2_carnage_ma_rare_inline17", // Maniac
          t"Character.maelstom_strong_shotgun2_igla_ma_inline0", // Maniac

          t"Character.maelstrom_fast_sniper2_grad_ma_inline0", // Raven

          t"Character.maelstrom_grunt1_melee1_knife_ma_inline4", // Scout
          
          t"Character.maelstrom_grunt1_ranged1_copperhead_ma_inline0", // Fanatic
          t"Character.maelstrom_grunt1_ranged1_copperhead_wa_inline0", // Fanatic
          t"Character.maelstrom_grunt1_ranged1_lexington_ma_inline0", // Fanatic
          t"Character.maelstrom_grunt1_ranged1_lexington_wa_inline0", // Fanatic

          t"Character.maelstrom_netrunner_netrunner2_lexington_ma_inline4", // Codefreak
          t"Character.maelstrom_techie_grenadier2_lexington_ma_inline6", // Techie

          t"Character.maelstrom_fast2_fmelee2_knife_ma_rare_inline4", // Zaelot
          t"Character.maelstrom_fast_fmelee2_machete_ma_rare_inline4", // Zaelot
          t"Character.maelstrom_fast_franged2_pulsar_ma_rare_inline4", // Goon
          t"Character.maelstrom_strong_gunner2_defender_mb_rare_inline0", // Ironstormer
          t"Character.maelstrom_fast_fmelee3_mantis_wa_elite_inline10" // Fiend
        ]);  
      } 
  }

  private func InitializeBeatsOnBrats() {
    // Cesar
    if (this.settings.electricPlatingEnabled) {
      AddAbilitiesToCharacter(t"Character.mq025_cesar", [
        t"Ability.CEElectricPlating"
      ]);
    }

    // Buck
    AddAbilitiesToCharacter(t"Character.mq025_buck", [
      t"Ability.CE_PowerPunch"
    ]);

    // Rhino
    if (this.settings.painEditorEnabled) {
      AddAbilitiesToCharacter(t"Character.mq025_rhino", [t"Ability.CE_PainEditor"]);
    }
    AddAbilitiesToCharacter(t"Character.mq025_rhino", [t"Ability.HasExtendedHitReactionImmunity", t"Ability.HasMeleeHitReactionAndTakedownResistance"]);

    // Razor


    // if (this.settings.regenerativeTissueEnabled) {
    //   AddAbilitiesToCharacter(t"Character.mq025_rhino", [t"Ability.CEJuiceInjector"]);
    // }
  }

  private func InitializeStoryBosses() {
    if (this.settings.radarFuckerEnabled) {
      AddAbilitiesToCharacter(t"Character.Royce", [t"Ability.CERadarFucker"]);
      AddAbilitiesToCharacter(t"Character.main_boss_royce", [t"Ability.CERadarFucker"]);
      AddAbilitiesToCharacter(t"Character.q003_maelstrom_royce_boss", [t"Ability.CERadarFucker"]);
      AddAbilitiesToCharacter(t"Character.q003_royce_boss", [t"Ability.CERadarFucker"]);
    }
// Sasquatch
    if (this.settings.painEditorEnabled) {
      AddAbilitiesToCharacter(t"Character.q110_animals_boss", [t"Ability.CE_PainEditor"]);
    }

    if (this.settings.flameArmorgEnabled) {
      AddAbilitiesToCharacter(t"Character.q110_animals_boss", [
        t"Ability.CE_HasFlameArmor"
      ]);
    }

    if (this.settings.electricPlatingEnabled) {
      AddAbilitiesToCharacter(t"Character.q110_animals_boss", [
        t"Ability.CEElectricPlating"
      ]);
    }

    // Brigitte
    if (this.settings.bloodPumpEnabled) {
      AddAbilitiesToCharacter(t"Character.Voodoo_Queen", [
        t"Ability.CE_BloodPump"
      ]);
    }

    // Placide
    if (this.settings.painEditorEnabled) {
      AddAbilitiesToCharacter(t"Character.Placide", [
        t"Ability.CE_PainEditor"
      ]);
    }

    if (this.settings.voodooEnabled) {
      AddAbilitiesToCharacter(t"Character.Placide", [
        t"Ability.CE_HasVoodoo"
      ]);
    }

    // Chimera
    if (this.settings.frostBulletsEnabled) {
      AddAbilitiesToCharacter(t"Character.q302_spidertank_drone", [
        t"Ability.CECryoBullets"
      ]);
    }

    // Voodoo Fake netrunners

    if (this.settings.gorgonEnabled) {
      AddAbilitiesToCharacter(t"Character.q303_voodoo_boy_guard_fake_netrunner_wa", [
        t"Ability.CE_HasGorgon"
      ]);
    }

    if (this.settings.elementalBulletsEnable) {
        AddAbilitiesToCharacter(t"Character.q303_voodoo_boy_guard_fake_netrunner_wa", [
          t"Ability.CanCauseElectrocution"
        ]);
    }

    if (this.settings.dronesEnabled) {
      AddAbilitiesToCharacter(t"Character.q303_voodoo_boy_guard_fake_netrunner_wa", [
        t"Ability.CE_HasShootHasScanDrones"
      ]);
    }

    // Oda

    if (this.settings.frostBulletsEnabled) {
      AddAbilitiesToCharacter(t"Character.Cyberninja_Oda", [
        t"Ability.CECryoBullets"
      ]);
    }

    AddAbilitiesToCharacter(t"Character.Cyberninja_Oda", [
      t"Ability.CE_PowerPunchKurt"
    ]);
    
    if (this.settings.flameArmorgEnabled) {
      AddAbilitiesToCharacter(t"Character.Cyberninja_Oda", [
        t"Ability.CE_HasFlameArmor"
      ]);
    }    
    
    if (this.settings.gorgonEnabled) {
      AddAbilitiesToCharacter(t"Character.Cyberninja_Oda", [
        t"Ability.CE_HasGorgon"
      ]);
    }

    if (this.settings.painEditorEnabled) {
      AddAbilitiesToCharacter(t"Character.Cyberninja_Oda", [
        t"Ability.CE_PainEditor"
      ]);
    }

    if (this.settings.elementalBulletsEnable) {
      AddAbilitiesToCharacter(t"Character.Cyberninja_Oda", [
        t"Ability.CanCausePoison"
      ]);
    }
    // Kurt

    if (this.settings.painEditorEnabled) {
      AddAbilitiesToCharacter(t"Character.q304_kurt_miniboss", [
        t"Ability.CE_PainEditor"
      ]);
    }

    if (this.settings.painEditorEnabled) {
      AddAbilitiesToCharacter(t"Character.kurtz", [
        t"Ability.CE_PainEditor"
      ]);
    }

    if (this.settings.bloodPumpEnabled) {
      AddAbilitiesToCharacter(t"Character.q304_kurt_miniboss", [
        t"Ability.CE_BloodPump"
      ]);
    }

    if (this.settings.bloodPumpEnabled) {
      AddAbilitiesToCharacter(t"Character.kurtz", [
        t"Ability.CE_BloodPump"
      ]);
    }

    AddAbilitiesToCharacter(t"Character.q304_kurt_miniboss", [
      t"Ability.CE_PowerPunchKurt"
    ]);

    // Maxtac

    AddAbilitiesToCharacter(t"Character.q305_maxtac_droid", [
      t"Ability.CanSeeThroughSmoke"
    ]);

    if (this.settings.elementalBulletsEnable) {
      AddAbilitiesToCharacter(t"Character.q305_maxtac_droid", [
        t"Ability.CanCauseElectrocution"
      ]);
    }

    if (this.settings.shockAndAweEnabled) {
      AddAbilitiesToCharacter(t"Character.q305_maxtac_droid", [
        t"Ability.CESmokeTank"
      ]);
    }

    if (this.settings.scanShieldEnabled) {
      AddAbilitiesToCharacter(t"Character.q305_maxtac_droid", [
        t"Ability.CEScanShield"
      ]);
    }

    // Maxtac - Netrunner
    if (this.settings.dronesEnabled) {
      AddAbilitiesToCharacter(t"Character.q305_maxtac_miniboss_netrunner_ma", [
        t"Ability.CE_HasAWACSWyvern"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_netrunner_ma", [
        t"Ability.CE_HasAWACSWyvern"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_netrunner_ma_2nd_wave", [
        t"Ability.CE_HasAWACSWyvern"
      ]);
    }

    if (this.settings.scanShieldEnabled) {
      AddAbilitiesToCharacter(t"Character.q305_maxtac_miniboss_netrunner_ma", [
        t"Ability.CEScanShield"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_netrunner_ma", [
        t"Ability.CEScanShield"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_netrunner_ma_2nd_wave", [
        t"Ability.CEScanShield"
      ]);
    }

    if (this.settings.opticalCamoEnable) {
      AddAbilitiesToCharacter(t"Character.q305_maxtac_miniboss_netrunner_ma", [
        t"Ability.CanUseOpticalCamo"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_netrunner_ma", [
        t"Ability.CanUseOpticalCamo"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_netrunner_ma_2nd_wave", [
        t"Ability.CanUseOpticalCamo"
      ]);
    }

    if (this.settings.aegisEnabled) {
      AddAbilitiesToCharacter(t"Character.q305_maxtac_miniboss_netrunner_ma", [
        t"Ability.CE_HasAegis"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_netrunner_ma", [
        t"Ability.CE_HasAegis"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_netrunner_ma_2nd_wave", [
        t"Ability.CE_HasAegis"
      ]);
    }

    if (this.settings.regenerativeTissueEnabled) {
      AddAbilitiesToCharacter(t"Character.q305_maxtac_miniboss_netrunner_ma", [t"Ability.CEJuiceInjector"]); 
      AddAbilitiesToCharacter(t"Character.maxtac_av_netrunner_ma", [t"Ability.CEJuiceInjector"]); 
      AddAbilitiesToCharacter(t"Character.maxtac_av_netrunner_ma_2nd_wave", [t"Ability.CEJuiceInjector"]); 
    }

    if (this.settings.shockAndAweEnabled) {
      AddAbilitiesToCharacter(t"Character.q305_maxtac_miniboss_netrunner_ma", [
        t"Ability.CESmokeTank"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_netrunner_ma", [
        t"Ability.CESmokeTank"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_netrunner_ma_2nd_wave", [
        t"Ability.CESmokeTank"
      ]);
    }

    // MaxTac - Tank
    
    if (this.settings.shockAndAweEnabled) {
      AddAbilitiesToCharacter(t"Character.q305_maxtac_miniboss_fshotgun_mb", [
        t"Ability.CESmokeTank"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_LMG_mb", [
        t"Ability.CESmokeTank"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_LMG_mb_2nd_wave", [
        t"Ability.CESmokeTank"
      ]);

    }    

    if (this.settings.scanShieldEnabled) {
      AddAbilitiesToCharacter(t"Character.q305_maxtac_miniboss_fshotgun_mb", [
        t"Ability.CEScanShield"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_LMG_mb", [
        t"Ability.CEScanShield"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_LMG_mb_2nd_wave", [
        t"Ability.CEScanShield"
      ]);
    }

    if (this.settings.gorgonEnabled) {
      AddAbilitiesToCharacter(t"Character.q305_maxtac_miniboss_fshotgun_mb", [
        t"Ability.CE_HasGorgon"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_LMG_mb", [
        t"Ability.CE_HasGorgon"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_LMG_mb_2nd_wave", [
        t"Ability.CE_HasGorgon"
      ]);
    }

    if (this.settings.flashStepEnabled) {
      AddAbilitiesToCharacter(t"Character.q305_maxtac_miniboss_fshotgun_mb", [
        t"Ability.CE_HasFlashStep"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_LMG_mb", [
        t"Ability.CE_HasFlashStep"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_LMG_mb_2nd_wave", [
        t"Ability.CE_HasFlashStep"
      ]);
    }

    // Max Tac - Shooter
    if (this.settings.frostBulletsEnabled) {
      AddAbilitiesToCharacter(t"Character.q305_maxtac_miniboss_frifle_wa", [
        t"Ability.CECryoBullets"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_riffle_ma", [
        t"Ability.CECryoBullets"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_riffle_ma_2nd_wave", [
        t"Ability.CECryoBullets"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_sniper_wa_elite", [
        t"Ability.CECryoBullets"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_sniper_wa_elite_2nd_wave", [
        t"Ability.CECryoBullets"
      ]);
    }
    
    if (this.settings.bansheeEnabled) {
      AddAbilitiesToCharacter(t"Character.q305_maxtac_miniboss_frifle_wa", [
        t"Ability.CEBanshee"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_riffle_ma", [
        t"Ability.CEBanshee"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_sniper_wa_elite_2nd_wave", [
        t"Ability.CEBanshee"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_riffle_ma_2nd_wave", [
        t"Ability.CEBanshee"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_sniper_wa_elite", [
        t"Ability.CEBanshee"
      ]);
    }
    
    if (this.settings.secondHeartEnabled) {
      AddAbilitiesToCharacter(t"Character.q305_maxtac_miniboss_frifle_wa", [
        t"Ability.CESantaMuerta"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_riffle_ma", [
        t"Ability.CESantaMuerta"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_riffle_ma_2nd_wave", [
        t"Ability.CESantaMuerta"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_sniper_wa_elite", [
        t"Ability.CESantaMuerta"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_sniper_wa_elite_2nd_wave", [
        t"Ability.CESantaMuerta"
      ]);
    }

    if (this.settings.scanShieldEnabled) {
      AddAbilitiesToCharacter(t"Character.q305_maxtac_miniboss_frifle_wa", [
        t"Ability.CEScanShield"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_riffle_ma", [
        t"Ability.CEScanShield"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_riffle_ma_2nd_wave", [
        t"Ability.CEScanShield"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_sniper_wa_elite", [
        t"Ability.CEScanShield"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_sniper_wa_elite_2nd_wave", [
        t"Ability.CEScanShield"
      ]);
    }

    // Max Tac - Mantis
    if (this.settings.medusaEnabled) {
      AddAbilitiesToCharacter(t"Character.q305_maxtac_miniboss_mantis_ma", [
        t"Ability.CEMedusa"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_mantis_wa", [
        t"Ability.CEMedusa"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_mantis_wa_2nd_wave", [
        t"Ability.CEMedusa"
      ]);
    }

    if (this.settings.scanShieldEnabled) {
      AddAbilitiesToCharacter(t"Character.q305_maxtac_miniboss_mantis_ma", [
        t"Ability.CEScanShield"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_mantis_wa", [
        t"Ability.CEScanShield"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_mantis_wa_2nd_wave", [
        t"Ability.CEScanShield"
      ]);
    }

    if (this.settings.electricPlatingEnabled) {
      AddAbilitiesToCharacter(t"Character.q305_maxtac_miniboss_mantis_ma", [
        t"Ability.CEElectricPlating"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_mantis_wa", [
        t"Ability.CEElectricPlating"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_mantis_wa_2nd_wave", [
        t"Ability.CEElectricPlating"
      ]);
    }

    AddAbilitiesToCharacter(t"Character.q305_maxtac_miniboss_mantis_ma", [
      t"Ability.CE_PowerPunchKurt"
    ]);
    AddAbilitiesToCharacter(t"Character.maxtac_av_mantis_wa", [
      t"Ability.CE_PowerPunchKurt"
    ]);
    AddAbilitiesToCharacter(t"Character.maxtac_av_mantis_wa_2nd_wave", [
      t"Ability.CE_PowerPunchKurt"
    ]);

    if (this.settings.flashStepEnabled) {
      AddAbilitiesToCharacter(t"Character.q305_maxtac_miniboss_mantis_ma", [
        t"Ability.CE_HasFlashStep"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_mantis_wa", [
        t"Ability.CE_HasFlashStep"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_mantis_wa_2nd_wave", [
        t"Ability.CE_HasFlashStep"
      ]);
    }    

    if (this.settings.painEditorEnabled) {
      AddAbilitiesToCharacter(t"Character.q305_maxtac_miniboss_mantis_ma", [
        t"Ability.CE_PainEditor"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_mantis_wa", [
        t"Ability.CE_PainEditor"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_mantis_wa_2nd_wave", [
        t"Ability.CE_PainEditor"
      ]);
    }

    if (this.settings.secondHeartEnabled) {
      AddAbilitiesToCharacter(t"Character.q305_maxtac_miniboss_mantis_ma", [
        t"Ability.CESantaMuerta"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_mantis_wa", [
        t"Ability.CESantaMuerta"
      ]);
      AddAbilitiesToCharacter(t"Character.maxtac_av_mantis_wa_2nd_wave", [
        t"Ability.CESantaMuerta"
      ]);
    }

    // Black Ops - Infantry male
    if (this.settings.shockAndAweEnabled) {
      AddAbilitiesToCharacter(t"Character.q306_black_ops_ma", [
        t"Ability.CESmokeTank"
      ]);
    }
    if (this.settings.scanShieldEnabled) {
      AddAbilitiesToCharacter(t"Character.q306_black_ops_ma", [
        t"Ability.CEScanShield"
      ]);
    }
    // Black Ops - Infantry female

    if (this.settings.elementalBulletsEnable) {
      AddAbilitiesToCharacter(t"Character.q306_black_ops_wa", [
        t"Ability.CanCauseElectrocution"
      ]);
    }

    if (this.settings.bansheeEnabled) {
      AddAbilitiesToCharacter(t"Character.q306_black_ops_wa", [
        t"Ability.CEBanshee"
      ]);
    }
    if (this.settings.scanShieldEnabled) {
      AddAbilitiesToCharacter(t"Character.q306_black_ops_wa", [
        t"Ability.CEScanShield"
      ]);
    }
    // Black Ops - Officer / Tech
    if (this.settings.opticalCamoEnable) {
      AddAbilitiesToCharacter(t"Character.q306_black_ops_fast_ranged", [
        t"Ability.CanUseOpticalCamo"
      ]);    
    }
    if (this.settings.medusaEnabled) {
      AddAbilitiesToCharacter(t"Character.q306_black_ops_fast_ranged", [
        t"Ability.CEMedusa"
      ]);
    }

    if (this.settings.scanShieldEnabled) {
      AddAbilitiesToCharacter(t"Character.q306_black_ops_fast_ranged", [
        t"Ability.CEScanShield"
      ]);
    }

    if (this.settings.gorgonEnabled) {
      AddAbilitiesToCharacter(t"Character.q306_black_ops_shotgunner", [
        t"Ability.CE_HasGorgon"
      ]);
    }

    if (this.settings.scanShieldEnabled) {
      AddAbilitiesToCharacter(t"Character.q306_black_ops_shotgunner", [
        t"Ability.CEScanShield"
      ]);
    }

    // HMG
    AddAbilitiesToCharacter(t"Character.q306_black_ops_HMG", [
      t"Ability.CEScanShield"
    ]);

    if (this.settings.secondHeartEnabled) {
      AddAbilitiesToCharacter(t"Character.q306_black_ops_HMG", [
        t"Ability.CESantaMuerta"
      ]);
    }
    
    if (this.settings.shockAndAweEnabled) {
      AddAbilitiesToCharacter(t"Character.q306_black_ops_HMG", [
        t"Ability.CESmokeTank"
      ]);
    }

    // Sniper
    if (this.settings.scanShieldEnabled) {
      AddAbilitiesToCharacter(t"Character.q306_black_ops_sniper", [
        t"Ability.CEScanShield"
      ]);
    }
    if (this.settings.opticalCamoEnable) {
      AddAbilitiesToCharacter(t"Character.q306_black_ops_sniper", [
        t"Ability.CanUseOpticalCamo"
      ]);    
    }
    // Smasher Ads
    if (this.settings.opticalCamoEnable) {
      AddAbilitiesToCharacter(t"Character.q113_smasher_arasaka_mantis", [
        t"Ability.CanUseOpticalCamo"
      ]);    
    }

    if (this.settings.frostBulletsEnabled) {
      AddAbilitiesToCharacter(t"Character.q113_smasher_arasaka_mantis", [
        t"Ability.CECryoBullets"
      ]);
    }

    if (this.settings.flashStepEnabled) {
        AddAbilitiesToCharacter(t"Character.q113_smasher_arasaka_mantis", [
          t"Ability.CE_HasFlashStep"
        ]);
    }   

    if (this.settings.gorgonEnabled) {
      AddAbilitiesToCharacter(t"Character.q113_smasher_arasaka_masamune", [
        t"Ability.CE_HasGorgon"
      ]);
    }

    if (this.settings.threatDetectorEnabled) {
      AddAbilitiesToCharacter(t"Character.q113_boss_smasher", [
        t"Ability.CEThreatDetector"
      ]);
    }
  }

  private func InitializeMercs() {
      if (this.settings.flameArmorgEnabled) {
        AddAbilityTo(t"CE_HasFlameArmorAbilityGroup", [                
          t"Character.afterlife_rare_fmelee3_katana_wa_elite_inline4" // Merc
        ]); 
      }

      if (this.settings.electricPlatingEnabled) {
        AddAbilityTo(t"CEElectricPlatingAbilityGroup", [                
          t"Character.generic_fast_fmelee2_knife_wa_rare_inline4", // Merc
          t"Character.generic_fast_fmelee2_machete_ma_rare_inline4", // Merc
          t"Character.afterlife_rare_fmelee3_mantis_ma_elite_inline0", // Merc
          t"Character.afterlife_rare_fmelee3_mantis_wa_elite_inline0" // Merc
        ]); 
      }
      
      if (this.settings.poisonTankEnabled) {
        AddAbilityTo(t"CEKPoisonTankAbilityGroup", [                
          t"Character.afterlife_rare_fmelee3_katana_ma_elite_inline4" // Merc
        ]); 
      }

      if (this.settings.aegisEnabled) {
        AddAbilityTo(t"CE_HasAegisAbilityGroup", [                        
          t"Character.generic_netrunner_netrunner_chao_ma_rare_inline4", // Netrunner
          t"Character.generic_netrunner_netrunner_chao_wa_rare_inline4", // Netrunner
          t"Character.afterlife_rare_fmelee3_mantis_ma_elite_inline0", // Merc
          t"Character.afterlife_rare_fmelee3_mantis_wa_elite_inline0", // Merc
          t"Character.afterlife_rare_sniper3_ashura_ma_elite_inline4" // Merc
        ]); 
      }

      if (this.settings.painEditorEnabled) {
        AddAbilityTo(t"CE_PainEditorAbilityGroup", [                                
          t"Character.afterlife_rare_gunner3_hmg_mb_elite_inline0" // Merc
        ]); 
      }

      if (this.settings.secondHeartEnabled) {
        AddAbilityTo(t"CESantaMuertaAbilityGroup", [                                
          t"Character.afterlife_rare_fshotgun3_zhuo_mb_elite_inline4", // Merc
          t"Character.generic_gunner_gunner3_hmg_mb_elite_inline4" // Support
        ]); 
      }

      if (this.settings.regenerativeTissueEnabled) {
        AddAbilityTo(t"CEJuiceInjectorAbilityGroup", [                                
          t"Character.afterlife_rare_gunner3_hmg_mb_elite_inline0" // Merc
        ]); 
      }

      if (this.settings.flashStepEnabled) {
        AddAbilityTo(t"CE_HasFlashStepAbilityGroup", [                                
          t"Character.generic_shotgun_shotgun3_carnage_mb_elite_inline4" // Edgerunner
        ]); 
      }
      
      AddAbilityTo(t"CE_AutoLoaderAbilityGroup", [        
        t"Character.afterlife_rare_franged2_saratoga_ma_rare_inline4", // Merc
        t"Character.afterlife_rare_franged2_saratoga_wa_rare_inline4", // Merc    
        t"Character.afterlife_rare_fshotgun3_zhuo_mb_elite_inline4", // Merc    
        t"Character.generic_shotgun_shotgun3_carnage_mb_elite_inline4" // Edgerunner
      ]); 

      if (this.settings.frostBulletsEnabled) {
        AddAbilityTo(t"CECryoBulletsAbilityGroup", [        
          t"Character.afterlife_rare_franged2_ajax_ma_rare_inline4", // Merc
          t"Character.afterlife_rare_franged2_ajax_wa_rare_inline4", // Merc
          t"Character.afterlife_rare_franged2_saratoga_ma_rare_inline4", // Merc
          t"Character.afterlife_rare_franged2_saratoga_wa_rare_inline4" // Merc
        ]); 
      }

      if (this.settings.shockAndAweEnabled) {
        AddAbilityTo(t"CEKSmokeTankAbilityGroup", [                
          t"Character.afterlife_rare_fmelee3_mantis_ma_elite_inline0", // Merc
          t"Character.afterlife_rare_sniper3_ashura_ma_elite_inline4" // Merc
        ]); 
      }

      if (this.settings.bansheeEnabled) {
        AddAbilityTo(t"CEBansheeAbilityGroup", [                        
          t"Character.afterlife_rare_fmelee3_mantis_wa_elite_inline0" // Merc
        ]); 
      }

      if (this.settings.medusaEnabled) {
        AddAbilityTo(t"CEMedusaAbilityGroup", [                        
          t"Character.afterlife_rare_fmelee3_katana_wa_elite_inline4" // Merc
        ]); 
      }

      if (this.settings.turretsEnabled) {
        AddAbilityTo(t"CECanSpawnTurretAbilityGroup", [                        
          t"Character.generic_gunner_gunner3_hmg_mb_elite_inline4" // Merc
        ]); 
      }

      if (this.settings.dronesEnabled) {
        AddAbilityTo(t"CE_HasShootHasScanDronesAbilityGroup", [                           
          t"Character.generic_netrunner_netrunner_chao_ma_rare_inline4", // Netrunner
          t"Character.generic_netrunner_netrunner_chao_wa_rare_inline4", // Netrunner
          t"Character.afterlife_netrunner_netrunner2_yukimura_ma_rare_inline4", // Netrunner,
          t"Character.generic_sniper_sniper2_grad_ma_rare_inline4", // Sniper
          t"Character.generic_gunner_gunner3_hmg_mb_elite_inline4" // Support
        ]); 
      }
  }

  private func InitializeKangTao() {
      if (this.settings.threatDetectorEnabled) {
        AddAbilityTo(t"CEThreatDetectorAbilityGroup", [                           
          t"Character.kangtao_android_android2_dian_ma_inline0", // Android
          t"Character.kangtao_ranger1_ranged2_dian_ma_inline0", // Comando
          t"Character.kangtao_soldier2_shotgun3_zhuo_mah_elite_inline0" // Elite gunner
        ]); 
      }

      if (this.settings.radarEnabled) {
        AddAbilityTo(t"CE_RadarAbilityGroup", [                           
          t"Character.kangtao_android_android2_dian_ma_inline0" // Android
        ]); 
      }

      if (this.settings.scanShieldEnabled) {
        AddAbilityTo(t"CEScanShieldAbilityGroup", [                           
          t"Character.kangtao_ranger1_ranged2_dian_ma_inline0", // Comando
          t"Character.kangtao_soldier2_shotgun2_zhuo_mah_rare_inline6", // Soldier
          t"Character.kangtao_soldier2_shotgun3_zhuo_mah_elite_inline0", // Elite gunner
          t"Character.kangtao_officer_grenadier3_mah_elite_inline4" // Officer
        ]); 
      }

      if (this.settings.aegisEnabled) {
        AddAbilityTo(t"CE_HasAegisAbilityGroup", [                           
          t"Character.kangtao_officer_grenadier3_mah_elite_inline4" // Officer
        ]); 
      }

      AddAbilityTo(t"CE_AutoLoaderAbilityGroup", [                           
        t"Character.kangtao_android_android2_dian_ma_inline0", // Android
        t"Character.kangtao_soldier2_shotgun3_zhuo_mah_elite_inline0" // Elite gunner
      ]); 

      if (this.settings.frostBulletsEnabled) {
        AddAbilityTo(t"CECryoBulletsAbilityGroup", [                           
          t"Character.kangtao_android_android2_dian_ma_inline0", // Android
          t"Character.kangtao_ranger1_ranged2_dian_ma_inline0", // Comando
          t"Character.kangtao_soldier2_shotgun2_zhuo_mah_rare_inline6", // Soldier
          t"Character.kangtao_soldier2_shotgun3_zhuo_mah_elite_inline0", // Elite gunner
          t"Character.kangtao_officer_grenadier3_mah_elite_inline4" // Officer
        ]); 
      }
      if (this.settings.shockAndAweEnabled) {
        AddAbilityTo(t"CEKSmokeTankAbilityGroup", [                           
          t"Character.kangtao_android_android2_dian_ma_inline0", // Android
          t"Character.kangtao_soldier2_shotgun3_zhuo_mah_elite_inline0", // Elite gunner
          t"Character.kangtao_officer_grenadier3_mah_elite_inline4" // Officer
        ]); 
      }

      if (this.settings.dronesEnabled) {
        AddAbilityTo(t"CE_HasAWACSWyvernAbilityGroup", [                          
          t"Character.kangtao_soldier2_shotgun3_zhuo_mah_elite_inline0", // Elite gunner
          t"Character.kangtao_officer_grenadier3_mah_elite_inline4" // Officer
        ]); 
      }
  }

  private func InitializeSecurity() {
      if (this.settings.threatDetectorEnabled) {
        AddAbilityTo(t"CEThreatDetectorAbilityGroup", [                         
          t"Character.security_blackmasked_sniper3_grad_ma_elite_inline4" // Elite - Sec
        ]);
      }

      if (this.settings.painEditorEnabled) {
        AddAbilityTo(t"CE_PainEditorAbilityGroup", [                         
          t"Character.security_security1_hmelee2_fists_mb_rare_inline0", // Rare - Vet
          t"Character.security_blackmasked3_fmelee3_katana_mb_elite_inline0" // Elite  - Sec
        ]); 
      }

      if (this.settings.bloodPumpEnabled) {
        AddAbilityTo(t"CE_BloodPumpAbilityGroup", [                         
          t"Character.security_security2_melee2_baton_ma_inline4", //Normal - Vet
          t"Character.security_security2_ranged2_ajax_wa_inline0", // Normal - Vet
          t"Character.security_enforcer3_shotgun2_tactician_mb_rare_inline4", // Rare - Vet
          t"Character.security_security1_hmelee2_fists_mb_rare_inline0", // Rare - Vet
          t"Character.security_security2_gunner2_defender_mb_rare_inline0", // Rare - Vet
          t"Character.security_blackmasked3_fmelee3_katana_mb_elite_inline0", // Elite  - Sec
          t"Character.security_blackmasked_sniper3_grad_ma_elite_inline4" // Elite - Sec
        ]); 
      }

      if (this.settings.frostBulletsEnabled) {
        AddAbilityTo(t"CECryoBulletsAbilityGroup", [                         
          t"Character.security_security2_ranged2_ajax_wa_inline0", // Normal - Vet
          t"Character.security_security2_gunner2_defender_mb_rare_inline0" // Rare - Vet
        ]); 
      }
  }

  private func InitializeTraumaTeam() {
    if (this.settings.painEditorEnabled) {
      AddAbilityTo(t"CE_PainEditorAbilityGroup", [          
        t"Character.trauma_soldier_shotgun2_zhuo_ma_rare_inline0" // Assault Specialist
      ]);  
    }

    if (this.settings.secondHeartEnabled) {
      AddAbilityTo(t"CESantaMuertaAbilityGroup", [          
        t"Character.trauma_rare_officer_chao_ma_inline0" // Medic
      ]);  
    }

    if (this.settings.bloodPumpEnabled) {
      AddAbilityTo(t"CE_BloodPumpAbilityGroup", [          
          t"Character.trauma_rare_officer_chao_ma_inline0", // Medic
          t"Character.trauma_soldier_ranged2_dian_ma_inline0", // Support
          t"Character.trauma_soldier_shotgun2_zhuo_ma_rare_inline0" // Assault Specialist
      ]);  
    }

    if (this.settings.elementalBulletsEnable) {
      AddAbilityTo(t"CE_CanCauseElectrocutionAbilityGroup", [          
          t"Character.trauma_rare_officer_chao_ma_inline0", // Medic
          t"Character.trauma_soldier_ranged2_dian_ma_inline0", // Support
          t"Character.trauma_soldier_shotgun2_zhuo_ma_rare_inline0" // Assault Specialist
      ]);  
    }

    AddAbilityTo(t"CE_AutoLoaderAbilityGroup", [          
        t"Character.trauma_soldier_ranged2_dian_ma_inline0", // Support
        t"Character.trauma_soldier_shotgun2_zhuo_ma_rare_inline0" // Assault Specialist
    ]);  
  }

  private func InitializeBarghest() {
    if (this.settings.threatDetectorEnabled) {
      AddAbilityTo(t"CEThreatDetectorAbilityGroup", [          
        t"Character.kurtz_recon_sniper2_achilles_ma_rare_inline0", // Sniper
        t"Character.prevention_dogtown_rifle_ma_inline5", // Infantry Scout
        t"Character.prevention_dogtown_rifle_wa_inline5", // Infantry Scout
        t"Character.prevention_dogtown_shotgun_ma_inline4" // Prevention Shotgunner
      ]);
    }

    if (this.settings.radarEnabled) {
      AddAbilityTo(t"CE_RadarAbilityGroup", [          
        t"Character.kurtz_netrunner2_netrunner2_lexington_ma_rare_inline0", // Netrunner
        t"Character.prevention_dogtown_rifle_ma_inline5", // Infantry Scout
        t"Character.prevention_dogtown_rifle_wa_inline5", // Infantry Scout
        t"Character.prevention_dogtown_shotgun_ma_inline4" // Prevention Shotgunner
      ]);  
    }
    
    if (this.settings.flameArmorgEnabled) {
        AddAbilityTo(t"CE_HasFlameArmorAbilityGroup", [          
            t"Character.kurtz_martial_hmelee3_fists_mb_elite_inline0", // Warrior
            t"Character.kurtz_strongarms_hmelee3_fists_mb_elite_inline0" // Warrior
        ]);  
    }

    if (this.settings.electricPlatingEnabled) {
      AddAbilityTo(t"CEElectricPlatingAbilityGroup", [          
          t"Character.kurtz_martial_fmelee3_fists_ma_rare_inline0", // Assassin
          t"Character.prevention_dogtown_martial_fmelee3_fists_ma_rare_inline5" // Assassin
      ]);  
    }

    if (this.settings.poisonTankEnabled) {
      AddAbilityTo(t"CEKPoisonTankAbilityGroup", [          
          t"Character.kurtz_rifle_flashlight3_ma_inline0", // Lieutenant
          t"Character.kurtz_soldier1_generic_ranged2_rifle_wa_inline4", // Lieutenant
          t"Character.kurtz_soldier2_generic_ranged3_rifle_ma_inline4" // Lieutenant
      ]);  
    }

    if (this.settings.aegisEnabled) {
      AddAbilityTo(t"CE_HasAegisAbilityGroup", [          
          t"Character.kurtz_netrunner2_netrunner2_lexington_ma_rare_inline0" // Netrunner
      ]);  
    }

    if (this.settings.painEditorEnabled) {
      AddAbilityTo(t"CE_PainEditorAbilityGroup", [          
          t"Character.kurtz_rifle_flashlight3_ma_inline0", // Lieutenant
          t"Character.kurtz_soldier1_generic_ranged2_rifle_wa_inline4", // Lieutenant
          t"Character.kurtz_soldier2_generic_ranged3_rifle_ma_inline4", // Lieutenant
          t"Character.kurtz_elite3_gunner3_HMG_mb_elite_inline0", // Gunner
          t"Character.kurtz_soldier2_shotgun3_shotgun_ma_inline4", // Enforcer
          t"Character.prevention_dogtown_HMG_mb_inline2" // Heavy Gunner
      ]);  
    }

    if (this.settings.bloodPumpEnabled) {
      AddAbilityTo(t"CE_BloodPumpAbilityGroup", [          
          t"Character.kurtz_grunt1_ranged1_handgun_ma_inline4", // Sergant
          t"Character.kurtz_grunt1_ranged1_handgun_wa_inline4", // Sergant
          t"Character.kurtz_recon_sniper2_achilles_ma_rare_inline0", // Sniper
          t"Character.kurtz_rifle_flashlight3_ma_inline0", // Lieutenant
          t"Character.kurtz_soldier1_generic_ranged2_rifle_wa_inline4", // Lieutenant
          t"Character.kurtz_soldier2_generic_ranged3_rifle_ma_inline4", // Lieutenant
          t"Character.kurtz_elite3_gunner3_HMG_mb_elite_inline0", // Gunner
          t"Character.prevention_dogtown_HMG_mb_inline2" // Heavy Gunner
      ]); 
    }

    if (this.settings.regenerativeTissueEnabled) {
      AddAbilityTo(t"CEJuiceInjectorAbilityGroup", [          
          t"Character.kurtz_martial_fmelee3_fists_ma_rare_inline0", // Assassin
          t"Character.prevention_dogtown_martial_fmelee3_fists_ma_rare_inline5" // Assassin
      ]); 
    }

    if (this.settings.flashStepEnabled) {
        AddAbilityTo(t"CE_HasFlashStepAbilityGroup", [          
            t"Character.kurtz_tech_franged2_handgun_ma_rare_inline0", // Commando
            t"Character.kurtz_martial_fmelee3_fists_ma_rare_inline0", // Assassin
            t"Character.prevention_dogtown_martial_fmelee3_fists_ma_rare_inline5" // Assassin
        ]); 
    }

    if (this.settings.shockAndAweEnabled) {
      AddAbilityTo(t"CEKSmokeTankAbilityGroup", [          
          t"Character.kurtz_tech_franged2_handgun_ma_rare_inline0", // Commando
          t"Character.kurtz_elite3_gunner3_LMG_mb_elite_inline0", // Gunner
          t"Character.kurtz_martial_fmelee3_fists_ma_rare_inline0", // Assassin
          t"Character.prevention_dogtown_martial_fmelee3_fists_ma_rare_inline5" // Assassin
      ]); 
    }

    if (this.settings.radarEnabled) {
      AddAbilityTo(t"CE_HasMultiHeAndRadarAbilityGroup", [          
          t"Character.kurtz_tech_franged2_handgun_ma_rare_inline0" // Assassin
      ]); 
    }
  }

  private func InitializeMilitech() {
    if (this.settings.radarEnabled) {
      AddAbilityTo(t"CE_RadarAbilityGroup", [          
          t"Character.militech_ranger1_ranged1_saratoga_ma_inline0", // Recon Support
          t"Character.militech_ranger1_ranged1_lexington_ma_inline0", // Recon Support
          t"Character.militech_soldier3_shotgun3_crusher_mah_elite_inline0" // Spec op
      ]); 
    }

    if (this.settings.scanShieldEnabled) {
      AddAbilityTo(t"CEScanShieldAbilityGroup", [          
          t"Character.militech_tech_grenadier2_omaha_ma_rare_inline0", // Field Engi
          t"Character.militech_tech_franged2_omaha_ma_rare_inline0", // Comando
          t"Character.militech_recon_sniper2_achilles_ma_rare_inline0", // Sniper
          t"Character.militech_enforcer2_shotgun2_tactician_mah_rare_inline4", // Ranger
          t"Character.militech_soldier3_shotgun3_crusher_mah_elite_inline0", // Spec op
          t"Character.militech_enforcer3_gunner3_HMG_mb_elite_inline0" // Heavy Gunner
      ]); 
    }

    if (this.settings.threatDetectorEnabled) {
      AddAbilityTo(t"CEThreatDetectorAbilityGroup", [          
        t"Character.militech_enforcer2_shotgun2_tactician_mah_rare_inline4" // Ranger
      ]); 
    }

    if (this.settings.bloodPumpEnabled) {
      AddAbilityTo(t"CE_BloodPumpAbilityGroup", [          
          t"Character.militech_tech_franged2_omaha_ma_rare_inline0", // Comando
          t"Character.militech_soldier3_shotgun3_crusher_mah_elite_inline0", // Spec op
          t"Character.militech_enforcer3_gunner3_HMG_mb_elite_inline0" // Heavy Gunner
      ]); 
    }
    AddAbilityTo(t"CE_RapidFireAbilityGroup", [          
        t"Character.militech_tech_franged2_omaha_ma_rare_inline0" // Field enghi
    ]); 


    AddAbilityTo(t"CE_AutoLoaderAbilityGroup", [          
        t"Character.militech_enforcer3_gunner3_HMG_mb_elite_inline0" // Heavy Gunner
    ]); 

    if (this.settings.elementalBulletsEnable) {
      AddAbilityTo(t"CE_CanCauseBurnAbilityGroup", [          
          t"Character.militech_ranger2_ranged2_omaha_ma_inline4", // Infantry Scout
          t"Character.militech_ranger2_ranged2_ajax_ma_inline4", // Infantry Scout
          t"Character.militech_recon_sniper2_achilles_ma_rare_inline0", // Sniper
          t"Character.militech_enforcer2_shotgun2_tactician_mah_rare_inline4", // Ranger
          t"Character.militech_soldier3_shotgun3_crusher_mah_elite_inline0", // Spec op
          t"Character.militech_enforcer3_gunner3_HMG_mb_elite_inline0" // Heavy Gunner
      ]); 
    }

    if (this.settings.shockAndAweEnabled) {
      AddAbilityTo(t"CEKSmokeTankAbilityGroup", [          
          t"Character.militech_android_android2_ajax_ma_inline4", // Robot
          t"Character.militech_android_android2_crusher_ma_inline4" // Robot
      ]); 
    }

    if (this.settings.turretsEnabled) {
      AddAbilityTo(t"CECanSpawnTurretAbilityGroup", [          
          t"Character.militech_tech_franged2_omaha_ma_rare_inline0", // Comando
          t"Character.militech_tech_grenadier2_omaha_ma_rare_inline0" // Field Engi
      ]); 
    }

    if (this.settings.dronesEnabled) {
      AddAbilityTo(t"CE_HasShootHasScanDronesAbilityGroup", [          
          t"Character.militech_ranger1_ranged1_saratoga_ma_inline0", // Recon Support
          t"Character.militech_ranger1_ranged1_lexington_ma_inline0", // Recon Support
          t"Character.militech_recon_sniper2_achilles_ma_rare_inline0" // Sniper
      ]); 

      AddAbilityTo(t"CE_HasCombatDronesS1AbilityGroup", [          
          t"Character.militech_tech_franged2_omaha_ma_rare_inline0" // Comando
      ]); 

      AddAbilityTo(t"CE_HasHeBombDroneAbilityGroup", [          
          t"Character.militech_enforcer2_shotgun2_tactician_mah_rare_inline4" // Ranger
      ]); 
    }

    if (this.settings.radarEnabled) {
        AddAbilityTo(t"CE_HasMultiHeAndRadarAbilityGroup", [          
            t"Character.militech_soldier3_shotgun3_crusher_mah_elite_inline0" // Spec op
        ]); 
    }

    if (this.settings.awacsEnabled) {
        AddAbilityTo(t"CE_HasAWACSWyvernAbilityGroup", [          
            t"Character.militech_tech_grenadier2_omaha_ma_rare_inline0" // Field Engi
        ]); 
    }

    
  }

  private func InitializeArasaka() {
    if (this.settings.threatDetectorEnabled) {
      AddAbilityTo(t"CEThreatDetectorAbilityGroup", [          
          t"Character.arasaka_sniper_sniper3_ashura_ma_elite_inline0", // Sniper
          t"Character.arasaka_sniper_sniper3_nekomata_ma_elite_inline0" // Sniper
      ]); 
    }

    if (this.settings.radarEnabled) {
        AddAbilityTo(t"CE_RadarAbilityGroup", [          
            t"Character.arasaka_sniper_sniper3_ashura_ma_elite_inline0", // Sniper
            t"Character.arasaka_sniper_sniper3_nekomata_ma_elite_inline0" // Sniper
        ]); 
    }

    if (this.settings.scanShieldEnabled) {
      AddAbilityTo(t"CEScanShieldAbilityGroup", [          
          t"Character.arasaka_netrunner_netrunner2_yukimura_ma_rare_inline0", // Netrunner
          t"Character.arasaka_netrunner_netrunner2_yukimura_wa_rare_inline0", // Netrunner
          
          t"Character.arasaka_agent_fmelee2rare_katana_ma_rare_inline4", // Agent
          t"Character.arasaka_agent_fmelee2rare_katana_wa_rare_inline4", // Agent
          t"Character.arasaka_agent_fmelee2rare_knife_ma_rare_inline4", // Agent
          t"Character.arasaka_agent_fmelee2rare_knife_wa_rare_inline4", // Agent
          t"Character.arasaka_agent_franged2_yukimura_wa_rare_inline4", // Agent

          t"Character.arasaka_agent_fshotgun2_tactician_ma_rare_inline4", // Specialist
          t"Character.arasaka_agent_fshotgun2_tactician_wa_rare_inline4", // Specialist
          t"Character.arasaka_sniper_sniper3_ashura_ma_elite_inline0", // Sniper
          t"Character.arasaka_sniper_sniper3_nekomata_ma_elite_inline0", // Sniper

          t"Character.arasaka_soldier2_shotgun2_tactician_mah_rare_inline4", // Assault Specialist
          t"Character.arasaka_tank2_gunner2_defender_mb_rare_inline0", // Armored Enforcer

          t"Character.arasaka_cyborg_franged3_shingen_ma_elite_inline4", // Executioner
          t"Character.arasaka_cyborg_franged3_shingen_wa_elite_inline4", // Executioner
          
          t"Character.arasaka_cyborg_fshotgun3_zhuo_ma_elite_inline4", // Agent

          t"Character.arasaka_ninja_fmelee3_katana_ma_elite_inline4", // Special Agent
          t"Character.arasaka_ninja_fmelee3_katana_wa_elite_inline4", // Assassin
          t"Character.arasaka_ninja_fmelee3_mantis_ma_elite_inline0", // Special Agent
          t"Character.arasaka_ninja_fmelee3_mantis_wa_elite_inline0", // Asassin

          t"Character.arasaka_terminator_shotgun3_zhuo_mah_elite_inline4" // Elite Assault Specialist
      ]); 
     }
      AddAbilitiesToCharacter(t"Character.q115_solo_nest_arasaka_fists_massive", [t"Ability.CE_PowerPunch"]);

    if (this.settings.electricPlatingEnabled) {
      AddAbilitiesToCharacter(t"Character.q115_solo_nest_arasaka_fists_massive", [
        t"Ability.CEElectricPlating"
      ]);
    }

    if (this.settings.flameArmorgEnabled) {
      AddAbilitiesToCharacter(t"Character.q115_solo_nest_arasaka_fists_massive", [
        t"Ability.CE_HasFlameArmor"
      ]);
    }

    AddAbilitiesToCharacter(t"Character.q115_lobby_arasaka_ninja_mantis_elite", [
      t"Ability.CE_PowerPunchKurt"
    ]);

    if (this.settings.opticalCamoEnable) {
      AddAbilitiesToCharacter(t"Character.q113_smasher_arasaka_sniper", [
        t"Ability.CanUseOpticalCamo"
      ]);
    }

    if (this.settings.shockAndAweEnabled) {
      AddAbilitiesToCharacter(t"Character.q113_smasher_arasaka_sniper", [
        t"Ability.CESmokeTank"
      ]);
    }

    

    if (this.settings.electricPlatingEnabled) {
      AddAbilityTo(t"CEElectricPlatingAbilityGroup", [          
          t"Character.arasaka_ninja_fmelee3_katana_ma_elite_inline4", // Special Agent
          t"Character.arasaka_ninja_fmelee3_katana_wa_elite_inline4", // Assassin
          t"Character.arasaka_ninja_fmelee3_mantis_ma_elite_inline0", // Special Agent
          t"Character.arasaka_ninja_fmelee3_mantis_wa_elite_inline0" // Asassin
      ]); 
    }

    if (this.settings.aegisEnabled) { 
      AddAbilityTo(t"CE_HasAegisAbilityGroup", [          
          t"Character.arasaka_sniper_sniper3_ashura_ma_elite_inline0", // Sniper
          t"Character.arasaka_sniper_sniper3_nekomata_ma_elite_inline0", // Sniper
          t"Character.arasaka_cyborg_franged3_shingen_ma_elite_inline4", // Executioner
          t"Character.arasaka_cyborg_franged3_shingen_wa_elite_inline4", // Executioner
          t"Character.arasaka_cyborg_fshotgun3_zhuo_ma_elite_inline4" // Agent
      ]); 
    }

    if (this.settings.painEditorEnabled) {
        AddAbilityTo(t"CE_PainEditorAbilityGroup", [          
            t"Character.arasaka_bodyguard_hmelee2_fists_mb_rare_inline0" // Body Guard
        ]); 
    }

    if (this.settings.secondHeartEnabled) {
      AddAbilityTo(t"CESantaMuertaAbilityGroup", [          
          t"Character.arasaka_soldier2_shotgun2_tactician_mah_rare_inline4", // Assault Specialist
          t"Character.arasaka_rare2_gunner3_hmg_mm_elite_inline0", // juggernaut
          t"Character.arasaka_rare2_hmelee3_fists_mm_elite_inline0", // juggernaut
          t"Character.arasaka_terminator_shotgun3_zhuo_mah_elite_inline4" // Elite Assault Specialist
      ]); 
    }

    if (this.settings.bloodPumpEnabled) {
      AddAbilityTo(t"CE_BloodPumpAbilityGroup", [          
          t"Character.arasaka_bodyguard_ranged3_kenshin_mb_rare_inline4", // Soldier
          t"Character.arasaka_bodyguard_ranged3_masamune_mb_rare_inline4", // Soldier
          t"Character.arasaka_soldier1_ranged3_masamune_mah_rare_inline4", // Soldier
          t"Character.arasaka_soldier2_shotgun2_tactician_mah_rare_inline4", // Assault Specialist
          t"Character.arasaka_tank2_gunner2_defender_mb_rare_inline0", // Armored Enforcer
          t"Character.arasaka_rare2_gunner3_hmg_mm_elite_inline0", // juggernaut
          t"Character.arasaka_rare2_hmelee3_fists_mm_elite_inline0", // juggernaut
          t"Character.arasaka_terminator_shotgun3_zhuo_mah_elite_inline4" // Elite Assault Specialist
      ]); 
    }

    if (this.settings.regenerativeTissueEnabled) {
        AddAbilityTo(t"CEJuiceInjectorAbilityGroup", [          
            t"Character.arasaka_bodyguard_hmelee2_fists_mb_rare_inline0" // Body Guard
        ]); 
    }

    if (this.settings.flashStepEnabled) {
      AddAbilityTo(t"CE_HasFlashStepAbilityGroup", [          
          t"Character.arasaka_agent_fmelee2rare_katana_ma_rare_inline4", // Agent
          t"Character.arasaka_agent_fmelee2rare_knife_ma_rare_inline4", // Agent
          t"Character.arasaka_ninja_fmelee3_katana_wa_elite_inline4", // Assassin
          t"Character.arasaka_ninja_fmelee3_mantis_wa_elite_inline0" // Asassin
      ]); 
    }
    
    AddAbilityTo(t"CE_AutoLoaderAbilityGroup", [          
        t"Character.arasaka_cyborg_franged3_shingen_ma_elite_inline4", // Executioner
        t"Character.arasaka_cyborg_franged3_shingen_wa_elite_inline4", // Executioner
        t"Character.arasaka_rare2_gunner3_hmg_mm_elite_inline0", // juggernaut
        t"Character.arasaka_terminator_shotgun3_zhuo_mah_elite_inline4" // Elite Assault Specialist
    ]);

    if (this.settings.shockAndAweEnabled) {
      AddAbilityTo(t"CEKSmokeTankAbilityGroup", [          
          t"Character.arasaka_cyborg_franged3_shingen_ma_elite_inline4", // Executioner
          t"Character.arasaka_cyborg_franged3_shingen_wa_elite_inline4", // Executioner
          t"Character.arasaka_cyborg_fshotgun3_zhuo_ma_elite_inline4" // Agent
      ]);
    }

    if (this.settings.bansheeEnabled) {
      AddAbilityTo(t"CEBansheeAbilityGroup", [          
          t"Character.arasaka_ninja_fmelee3_mantis_wa_elite_inline0" // Asassin
      ]);
    }

    if (this.settings.medusaEnabled) {
      AddAbilityTo(t"CEMedusaAbilityGroup", [          
          t"Character.arasaka_agent_fmelee2rare_katana_wa_rare_inline4", // Agent
          t"Character.arasaka_agent_fmelee2rare_knife_wa_rare_inline4", // Agent
          t"Character.arasaka_ninja_fmelee3_katana_wa_elite_inline4" // Assassin
      ]);
    }

    if (this.settings.gorgonEnabled) { 
      AddAbilityTo(t"CE_HasGorgonAbilityGroup", [          
          t"Character.arasaka_ninja_fmelee3_mantis_ma_elite_inline0" // Special Agent
      ]);
    }

    if (this.settings.voodooEnabled) {
      AddAbilityTo(t"CE_HasVoodooAbilityGroup", [          
          t"Character.arasaka_ninja_fmelee3_katana_ma_elite_inline4" // Special Agent
      ]);
    }

    if (this.settings.dronesEnabled) {
      AddAbilityTo(t"CE_HasScannerDronesS1AbilityGroup", [          
          t"Character.arasaka_netrunner_netrunner2_yukimura_ma_rare_inline0", // Netrunner
          t"Character.arasaka_netrunner_netrunner2_yukimura_wa_rare_inline0" // Netrunner
      ]);
      
      // AddAbilityTo(t"CE_HasScannerDronesS1AbilityGroup", [          
      //     t"Character.arasaka_netrunner_netrunner2_yukimura_ma_rare_inline0", // Netrunner - todo - check who did i miss
      //     t"Character.arasaka_netrunner_netrunner2_yukimura_wa_rare_inline0" // Netrunner
      // ]);
    }
  }

}

public final static func AddAbilityTo(ability: TweakDBID, archetypes: array<TweakDBID>) -> Void {
  let i = 0;
  let len = ArraySize(archetypes);
  while (i < len) {
    let tab = TweakDBInterface.GetForeignKeyArray(archetypes[i] + t".abilityGroups");
    ArrayPush(tab, ability);
    TweakDBManager.SetFlat(archetypes[i] + t".abilityGroups", tab);
    TweakDBManager.UpdateRecord(archetypes[i]);

    i += 1;
  }
}

public final static func AddAbilitiesToCharacter(character: TweakDBID, abilities: array<TweakDBID>) -> Void {
  let i = 0;
  let len = ArraySize(abilities);
  
  let tab = TweakDBInterface.GetForeignKeyArray(character + t".abilities");

  while (i < len) {
    ArrayPush(tab, abilities[i]);

    i += 1;
  }
  
  TweakDBManager.SetFlat(character + t".abilities", tab);
  TweakDBManager.UpdateRecord(character);
}

public final static func SetBoss(character: TweakDBID) -> Void {
  AddAbilitiesToCharacter(character, [t"Ability.CE_BossHPScaling"]);
}