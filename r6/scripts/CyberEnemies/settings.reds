module CyberEnemies.Configurations

public class CyberEnemiesSettings {
    // Generic
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "General")
	@runtimeProperty("ModSettings.category.order", "0")
    @runtimeProperty("ModSettings.displayName", "Crime bosses Health Scaling")
    @runtimeProperty("ModSettings.description", "Scales health of Crime Bosses, if they are turned to Bosses (*Restart Required)")
    @runtimeProperty("ModSettings.step", "0.1")
    @runtimeProperty("ModSettings.min", "0.1")
    @runtimeProperty("ModSettings.max", "5")
    @runtimeProperty("ModSettings.dependency", "crimeBosses")
    public let crimeBossesHealthScale: Float = 2.0;

    // Vanila Abilities
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Extra Vanila Abilities")
	@runtimeProperty("ModSettings.category.order", "1")
    @runtimeProperty("ModSettings.displayName", "Elemental Mods")
    @runtimeProperty("ModSettings.description", "Will add 'Can Burn', 'Can Poison' and 'Can Electrocute' to some enemies, that didn't have those abilities already. .(*Restart Required)")
    public let elementalBulletsEnable: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Extra Vanila Abilities")
	@runtimeProperty("ModSettings.category.order", "1")
    @runtimeProperty("ModSettings.displayName", "Health Monitor Bomb")
    @runtimeProperty("ModSettings.description", "Will add 'Health Monitor Bomb' ability, to some enemies, that didn't have those abilities already.(*Restart Required)")
    public let healthMonitorEnable: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Extra Vanila Abilities")
	@runtimeProperty("ModSettings.category.order", "1")
    @runtimeProperty("ModSettings.displayName", "Optical Camo")
    @runtimeProperty("ModSettings.description", "Will add 'Optical Camo' ability, to some enemies, that didn't have those abilities already.(*Restart Required)")
    public let opticalCamoEnable: Bool = true;

    // Aegis
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Aegis")
	@runtimeProperty("ModSettings.category.order", "10")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "Enemies with Aegis, can activate defensive ability, that blocks incoming bullets. Shield can be overwhelmed with faster fire rate wapons, and Smart guns can go through the Aegis too.(*Restart Required)")
    public let aegisEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Aegis")
	@runtimeProperty("ModSettings.category.order", "10")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    @runtimeProperty("ModSettings.dependency", "aegisEnabled")
    public let aegisShowInCodex: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Aegis")
	@runtimeProperty("ModSettings.category.order", "10")
    @runtimeProperty("ModSettings.displayName", "Cooldown")
    @runtimeProperty("ModSettings.description", "In Seconds. (*Restart Required)")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "300")
    @runtimeProperty("ModSettings.dependency", "aegisEnabled")
    public let aegisCooldown: Float = 30;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Aegis")
	@runtimeProperty("ModSettings.category.order", "10")
    @runtimeProperty("ModSettings.displayName", "Duration")
    @runtimeProperty("ModSettings.description", "In Seconds. (*Restart Required)")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "300")
    @runtimeProperty("ModSettings.dependency", "aegisEnabled")
    public let aegisDuration: Float = 30;

    // Autoloader
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Autoloader")
	@runtimeProperty("ModSettings.category.order", "20")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    public let autoloaderShowsInCodex: Bool = true;

    // Banshee
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Banshee")
	@runtimeProperty("ModSettings.category.order", "30")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "Allows enemies to shout, which can knock you down, and slow down your movement, when close enough. It's possible to get away from the attack if you are fast enough. Requires Audioware to hear the incoming attack. (*Restart Required)")
    public let bansheeEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Banshee")
	@runtimeProperty("ModSettings.category.order", "30")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    @runtimeProperty("ModSettings.dependency", "bansheeEnabled")
    public let bansheeShowInCodex: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Banshee")
	@runtimeProperty("ModSettings.category.order", "30")
    @runtimeProperty("ModSettings.displayName", "Cooldown")
    @runtimeProperty("ModSettings.description", "In Seconds. (*Restart Required)")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "300")
    @runtimeProperty("ModSettings.dependency", "bansheeEnabled")
    public let bansheeCooldown: Float = 30;

    // Blood Pump
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Blood Pump")
	@runtimeProperty("ModSettings.category.order", "40")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "Activates heal when low hp. When poisoned, healing is greately reduced. (*Restart Required)")
    public let bloodPumpEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Blood Pump")
	@runtimeProperty("ModSettings.category.order", "40")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    @runtimeProperty("ModSettings.dependency", "bloodPumpEnabled")
    public let bloodPumpShowInCodex: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Blood Pump")
	@runtimeProperty("ModSettings.category.order", "40")
    @runtimeProperty("ModSettings.displayName", "Cooldown")
    @runtimeProperty("ModSettings.description", "In Seconds. (*Restart Required)")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "300")
    @runtimeProperty("ModSettings.dependency", "bloodPumpEnabled")
    public let bloodPumpCooldown: Float = 45;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Blood Pump")
	@runtimeProperty("ModSettings.category.order", "40")
    @runtimeProperty("ModSettings.displayName", "Instant Heal")
    @runtimeProperty("ModSettings.description", "In % of max health. (*Restart Required)")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "100")
    @runtimeProperty("ModSettings.dependency", "bloodPumpEnabled")
    public let bloodPumpInstantHeal: Float = 10;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Blood Pump")
	@runtimeProperty("ModSettings.category.order", "40")
    @runtimeProperty("ModSettings.displayName", "Over Time Heal")
    @runtimeProperty("ModSettings.description", "In % of max health. Total healing calculated over 10 seconds. (*Restart Required)")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "100")
    @runtimeProperty("ModSettings.dependency", "bloodPumpEnabled")
    public let bloodPumpDoTHeal: Float = 65;

    // Combat Drones
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Combat Drones")
	@runtimeProperty("ModSettings.category.order", "50")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "Allows enemies to summon combat drones in combat. (*Restart Required)")
    public let dronesEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Combat Drones")
	@runtimeProperty("ModSettings.category.order", "50")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    @runtimeProperty("ModSettings.dependency", "dronesEnabled")
    public let dronesShowInCodex: Bool = true;

    // Electric Plating
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Electric Plating")
	@runtimeProperty("ModSettings.category.order", "60")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "When hiting with melee or attacked by melee, enemies can electrocute you. (*Restart Required)")
    public let electricPlatingEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Electric Plating")
	@runtimeProperty("ModSettings.category.order", "60")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    @runtimeProperty("ModSettings.dependency", "electricPlatingShowInCodex")
    public let electricPlatingShowInCodex: Bool = true;

    // Flame Armor
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Flame Armor")
	@runtimeProperty("ModSettings.category.order", "70")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "When hiting with melee or attacked by melee, enemies can set you on fire you. (*Restart Required)")
    public let flameArmorgEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Flame Armor")
	@runtimeProperty("ModSettings.category.order", "70")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    @runtimeProperty("ModSettings.dependency", "flameArmorgEnabled")
    public let flameArmorShowInCodex: Bool = true;

    // Flash Step
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Flash Step")
	@runtimeProperty("ModSettings.category.order", "80")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "Enemy can teleport behind you. (*Restart Required)")
    public let flashStepEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Flash Step")
	@runtimeProperty("ModSettings.category.order", "80")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    @runtimeProperty("ModSettings.dependency", "flashStepEnabled")
    public let flashStepShowInCodex: Bool = true;
    
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Flash Step")
	@runtimeProperty("ModSettings.category.order", "80")
    @runtimeProperty("ModSettings.displayName", "Cooldown")
    @runtimeProperty("ModSettings.description", "In Seconds. (*Restart Required)")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "300")
    @runtimeProperty("ModSettings.dependency", "flashStepEnabled")
    public let flashStepCooldown: Float = 15;


    // Frost Bullets
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Frost Bullets")
	@runtimeProperty("ModSettings.category.order", "90")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "This bullets will slow you done. (*Restart Required)")
    public let frostBulletsEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Frost Bullets")
	@runtimeProperty("ModSettings.category.order", "90")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    @runtimeProperty("ModSettings.dependency", "frostBulletsEnabled")
    public let frostBulletsShowInCodex: Bool = true;

    // Gorgon
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Gorgon")
	@runtimeProperty("ModSettings.category.order", "100")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "When looking directly at enemy face, player camera gets locked, and mobility is severally affected. (*Restart Required)")
    public let gorgonEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Gorgon")
	@runtimeProperty("ModSettings.category.order", "100")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    @runtimeProperty("ModSettings.dependency", "gorgonEnabled")
    public let gorgonShowInCodex: Bool = true;

    // Hot Swarm
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Hot Swarm")
	@runtimeProperty("ModSettings.category.order", "110")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "When enemy with this ability dies, all other enemies with this abilities, gets buffed. (*Restart Required)")
    public let hotSwarmEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Hot Swarm")
	@runtimeProperty("ModSettings.category.order", "110")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    @runtimeProperty("ModSettings.dependency", "hotSwarmEnabled")
    public let hotSwarmShowsInCodex: Bool = true;

    // Medusa
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Medusa")
	@runtimeProperty("ModSettings.category.order", "120")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "Allows enemies to flashbang you, if they are close and you are looking at their eyes. (*Restart Required)")
    public let medusaEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Medusa")
	@runtimeProperty("ModSettings.category.order", "120")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    @runtimeProperty("ModSettings.dependency", "hotSwarmEnabled")
    public let medusaShowsInCodex: Bool = true;

    // Pain Editor
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Pain Editor")
	@runtimeProperty("ModSettings.category.order", "130")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "Allows enemies, to take greatly reduced amount of damage, for few seconds..(*Restart Required)")
    public let painEditorEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Pain Editor")
	@runtimeProperty("ModSettings.category.order", "130")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    @runtimeProperty("ModSettings.dependency", "painEditorEnabled")
    public let painEditorShowsInCodex: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Pain Editor")
	@runtimeProperty("ModSettings.category.order", "130")
    @runtimeProperty("ModSettings.displayName", "Cooldown")
    @runtimeProperty("ModSettings.description", "In Seconds. (*Restart Required)")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "300")
    @runtimeProperty("ModSettings.dependency", "painEditorEnabled")
    public let painEditorCooldown: Float = 60;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Pain Editor")
	@runtimeProperty("ModSettings.category.order", "130")
    @runtimeProperty("ModSettings.displayName", "Duration")
    @runtimeProperty("ModSettings.description", "In Seconds. (*Restart Required)")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "60")
    @runtimeProperty("ModSettings.dependency", "painEditorEnabled")
    public let painEditorDuration: Float = 14;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Pain Editor")
	@runtimeProperty("ModSettings.category.order", "130")
    @runtimeProperty("ModSettings.displayName", "Damage Reduction")
    @runtimeProperty("ModSettings.description", "In % of damage mitigated. (*Restart Required)")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "100")
    @runtimeProperty("ModSettings.dependency", "painEditorEnabled")
    public let painEditorDamageReduction: Float = 80;

    
    // Phoenix Protocol
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Phoenix Protocol")
	@runtimeProperty("ModSettings.category.order", "140")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "Allows enemy, to repair when when downed. If not killed durning the repair time, enemy can repair again.(*Restart Required)")
    public let phoenixProtocolEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Phoenix Protocol")
	@runtimeProperty("ModSettings.category.order", "140")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    @runtimeProperty("ModSettings.dependency", "phoenixProtocolEnabled")
    public let phoenixProtocolShowsInCodex: Bool = true;


    // Poison Tank
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Poison Tank")
	@runtimeProperty("ModSettings.category.order", "150")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "Enemies with Poison Tank, will emit poison cloud when hit (mostly melee), or when attacking. It also makes them weaker to fire, and can cause them to explode, when attacking with fire, shortly after emiting poison.(*Restart Required)")
    public let poisonTankEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Poison Tank")
	@runtimeProperty("ModSettings.category.order", "150")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    @runtimeProperty("ModSettings.dependency", "poisonTankEnabled")
    public let poisonTankShowInCodex: Bool = true;
    
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Poison Tank")
	@runtimeProperty("ModSettings.category.order", "150")
    @runtimeProperty("ModSettings.displayName", "Cooldown")
    @runtimeProperty("ModSettings.description", "In Seconds. (*Restart Required)")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "300")
    @runtimeProperty("ModSettings.dependency", "poisonTankEnabled")
    public let poisonTankCooldown: Float = 5;

    // Radar 
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Radar")
	@runtimeProperty("ModSettings.category.order", "160")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "Enemies with Radar, can detect you when stealthed. Progress can be halted when invisible. (*Restart Required)")
    public let radarEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Radar")
	@runtimeProperty("ModSettings.category.order", "160")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    @runtimeProperty("ModSettings.dependency", "radarEnabled")
    public let radarShowsInCodex: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Radar")
	@runtimeProperty("ModSettings.category.order", "160")
    @runtimeProperty("ModSettings.displayName", "Range")
    @runtimeProperty("ModSettings.description", "In Meters. (*Restart Required)")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "80")
    @runtimeProperty("ModSettings.dependency", "radarEnabled")
    public let radarRange: Float = 24;


    // Radar - AWACS
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Radar - AWACS")
	@runtimeProperty("ModSettings.category.order", "170")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "Same benefits as regular Radar, but also increases enemmies accuracy, and protects friendlies, from smart weapons. Has also ability to 'tag' player when in combat. Tagged player, has even more increased chance to be hit by bullets, and can't hide from enemies in smoke / using invisibility. (*Restart Required)")
    public let awacsEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Radar - AWACS")
	@runtimeProperty("ModSettings.category.order", "170")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    @runtimeProperty("ModSettings.dependency", "awacsEnabled")
    public let awacsShowsInCodex: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Radar - AWACS")
	@runtimeProperty("ModSettings.category.order", "170")
    @runtimeProperty("ModSettings.displayName", "Range")
    @runtimeProperty("ModSettings.description", "In Meters. (*Restart Required)")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "80")
    @runtimeProperty("ModSettings.dependency", "awacsEnabled")
    public let awacsRange: Float = 40;

    // Radar Scrambler
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Radar Scrambler")
	@runtimeProperty("ModSettings.category.order", "180")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "When in range, minimap stops working. (*Restart Required)")
    public let radarFuckerEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Radar Scrambler")
	@runtimeProperty("ModSettings.category.order", "180")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    @runtimeProperty("ModSettings.dependency", "radarFuckerEnabled")
    public let radarFuckerShowsInCodex: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Radar Scrambler")
	@runtimeProperty("ModSettings.category.order", "180")
    @runtimeProperty("ModSettings.displayName", "Range")
    @runtimeProperty("ModSettings.description", "In Meters. (*Restart Required)")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "80")
    @runtimeProperty("ModSettings.dependency", "radarFuckerEnabled")
    public let radarFuckerRange: Float = 30;

    // Rapid Fire
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Rapid Fire")
	@runtimeProperty("ModSettings.category.order", "190")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    public let rapidFireShowsInCodex: Bool = true;

    // Regenerative Tissue
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Regenerative Tissue")
	@runtimeProperty("ModSettings.category.order", "200")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "Passive HP regeneration. Healing is Reduced for Poisoned enemies. (*Restart Required)")
    public let regenerativeTissueEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Regenerative Tissue")
	@runtimeProperty("ModSettings.category.order", "200")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    @runtimeProperty("ModSettings.dependency", "regenerativeTissueEnabled")
    public let regenerativeTissueShowInCodex: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Regenerative Tissue")
	@runtimeProperty("ModSettings.category.order", "200")
    @runtimeProperty("ModSettings.displayName", "Healing - Weak Enemies")
    @runtimeProperty("ModSettings.description", "% of Max HP in Second. (*Restart Required)")
    @runtimeProperty("ModSettings.step", "0.1")
    @runtimeProperty("ModSettings.min", "0.1")
    @runtimeProperty("ModSettings.max", "100")
    @runtimeProperty("ModSettings.dependency", "regenerativeTissueEnabled")
    public let regenerativeTissueHealWeak: Float = 15;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Regenerative Tissue")
	@runtimeProperty("ModSettings.category.order", "200")
    @runtimeProperty("ModSettings.displayName", "Healing - Normal Enemies")
    @runtimeProperty("ModSettings.description", "% of Max HP in Second. (*Restart Required)")
    @runtimeProperty("ModSettings.step", "0.1")
    @runtimeProperty("ModSettings.min", "0.1")
    @runtimeProperty("ModSettings.max", "100")
    @runtimeProperty("ModSettings.dependency", "regenerativeTissueEnabled")
    public let regenerativeTissueHealNormal: Float = 12;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Regenerative Tissue")
	@runtimeProperty("ModSettings.category.order", "200")
    @runtimeProperty("ModSettings.displayName", "Healing - Rare Enemies")
    @runtimeProperty("ModSettings.description", "% of Max HP in Second. (*Restart Required)")
    @runtimeProperty("ModSettings.step", "0.1")
    @runtimeProperty("ModSettings.min", "0.1")
    @runtimeProperty("ModSettings.max", "100")
    @runtimeProperty("ModSettings.dependency", "regenerativeTissueEnabled")
    public let regenerativeTissueHealRare: Float = 10;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Regenerative Tissue")
	@runtimeProperty("ModSettings.category.order", "200")
    @runtimeProperty("ModSettings.displayName", "Healing - Elite Enemies")
    @runtimeProperty("ModSettings.description", "% of Max HP in Second. (*Restart Required)")
    @runtimeProperty("ModSettings.step", "0.1")
    @runtimeProperty("ModSettings.min", "0.1")
    @runtimeProperty("ModSettings.max", "100")
    @runtimeProperty("ModSettings.dependency", "regenerativeTissueEnabled")
    public let regenerativeTissueHealElite: Float = 8;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Regenerative Tissue")
	@runtimeProperty("ModSettings.category.order", "200")
    @runtimeProperty("ModSettings.displayName", "Healing - Boss / Max Tac Enemies")
    @runtimeProperty("ModSettings.description", "% of Max HP in Second. (*Restart Required)")
    @runtimeProperty("ModSettings.step", "0.1")
    @runtimeProperty("ModSettings.min", "0.1")
    @runtimeProperty("ModSettings.max", "100")
    @runtimeProperty("ModSettings.dependency", "regenerativeTissueEnabled")
    public let regenerativeTissueHealBoss: Float = 4;

    // Scan Shield 
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Scan Shield")
	@runtimeProperty("ModSettings.category.order", "210")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "Blocks player from scanning, unless good enough Kiroshi Scanner is used. (Tier 1 For Scavs, Tier 4 for Others) (*Restart Required)")
    public let scanShieldEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Scan Shield")
	@runtimeProperty("ModSettings.category.order", "210")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    @runtimeProperty("ModSettings.dependency", "scanShieldEnabled")
    public let scanShieldShowInCodex: Bool = true;
    
    // Second Heart
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Second Heart")
	@runtimeProperty("ModSettings.category.order", "220")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "Downed enemy, can once get back to fight. Provides healing, and damage reduction when healing. (*Restart Required)")
    public let secondHeartEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Second Heart")
	@runtimeProperty("ModSettings.category.order", "220")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    @runtimeProperty("ModSettings.dependency", "secondHeartEnabled")
    public let secondHeartShowInCodex: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Second Heart")
	@runtimeProperty("ModSettings.category.order", "220")
    @runtimeProperty("ModSettings.displayName", "Damage Reduction")
    @runtimeProperty("ModSettings.description", "In % of damage mitigated. (*Restart Required)")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "100")
    @runtimeProperty("ModSettings.dependency", "secondHeartEnabled")
    public let secondHeartDamageReduction: Float = 60;

    // Shock And Awe
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Shock And Awe")
	@runtimeProperty("ModSettings.category.order", "230")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "Electrocutes and knocks down player, when attacked in Melee. (*Restart Required)")
    public let shockAndAweEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Shock And Awe")
	@runtimeProperty("ModSettings.category.order", "230")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    @runtimeProperty("ModSettings.dependency", "shockAndAweEnabled")
    public let shockAndAweShowsInCodex: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Shock And Awe")
	@runtimeProperty("ModSettings.category.order", "230")
    @runtimeProperty("ModSettings.displayName", "Cooldown")
    @runtimeProperty("ModSettings.description", "In Seconds. (*Restart Required)")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "300")
    @runtimeProperty("ModSettings.dependency", "shockAndAweEnabled")
    public let shockAndAweCooldown: Float = 30;

    // Threat Detector
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Threat Detector")
	@runtimeProperty("ModSettings.category.order", "240")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "Allows Enemies to spot you, when you look at them directly (*Restart Required)")
    public let threatDetectorEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Threat Detector")
	@runtimeProperty("ModSettings.category.order", "240")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    @runtimeProperty("ModSettings.dependency", "threatDetectorEnabled")
    public let threatDetectorShowsInCodex: Bool = true;
    
    // Turrets
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Turrets")
	@runtimeProperty("ModSettings.category.order", "250")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "Allows Enemies to place down HMG turrets. (*Restart Required)")
    public let turretsEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Turrets")
	@runtimeProperty("ModSettings.category.order", "250")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    @runtimeProperty("ModSettings.dependency", "turretsEnabled")
    public let turretsShowsInCodex: Bool = true;

    // Voodoo
    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Voodoo")
	@runtimeProperty("ModSettings.category.order", "260")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "Allows enemies, to transform into CyberPsychos, when low hp, gaining additional stats and abilities, but also attacking their allies. (*Restart Required)")
    public let voodooEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    @runtimeProperty("ModSettings.category", "Voodoo")
	@runtimeProperty("ModSettings.category.order", "260")
    @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    @runtimeProperty("ModSettings.dependency", "turretsEnabled")
    public let voodooShowsInCodex: Bool = true;

    // // Vanila Abilities
    // @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    // @runtimeProperty("ModSettings.category", "Vanila Abilities")
	// @runtimeProperty("ModSettings.category.order", "26")
    // @runtimeProperty("ModSettings.displayName", "Enabled")
    // @runtimeProperty("ModSettings.description", "Allows Enemies to place down HMG turrets. (*Restart Required)")
    // public let voodooEnabled: Bool = true;

    // @runtimeProperty("ModSettings.mod", "Cyber Enemies")
    // @runtimeProperty("ModSettings.category", "Vanila Abilities")
	// @runtimeProperty("ModSettings.category.order", "26")
    // @runtimeProperty("ModSettings.displayName", "Show When Scanning")
    // @runtimeProperty("ModSettings.description", "Show ability on enemy, when scanning. (*Restart Required)")
    // @runtimeProperty("ModSettings.dependency", "turretsEnabled")
    // public let voodooShowsInCodex: Bool = true;
}