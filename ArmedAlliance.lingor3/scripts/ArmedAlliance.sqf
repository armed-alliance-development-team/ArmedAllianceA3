if (!isServer) exitWith {};

// SHOW SPLASH SCREEN

// INITIALIZE VARIABLES
DEBUG = 1;
SORT_ZONES = false;

_mapCenter = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");
_markerName = format["marker_%1",(random 10000)];
mapCenter = createMarker [_markerName,_mapCenter];
mapCenter setMarkerShape "ICON";
mapCenter setMarkerType "Empty";
mapCenter setmarkersize [0,0];

vehicleSlots = [];
armorSlots = [];
planeSlots = [];



slotContainsLightArmor = [];
slotContainsMediumArmor = [];
slotContainsHeavyArmor = [];
slotContainsCars = [];
slotContainsArmedCars = [];
slotContainsTrucks = [];
slotContainsAPCs = [];
slotContainsHelicopter = [];
slotContainsGunship = [];
slotsContainsPlane = [];

VEHICLESLOTS_INITIALIZED = 0;
TOWNS_INITIALIZED = 0;
GAMEMODE_INITIALIZED = 0;

// AI VARIABLES
REGIME_STARTING_EQUIPMENT_PERCENTAGE = 40;
_regimeEquipmentRatio = REGIME_STARTING_EQUIPMENT_PERCENTAGE / 100;
REGIME_ENLISTED_MEN = round (3500 + random 500);
REGIME_OFFICERS = round (REGIME_ENLISTED_MEN * 0.125);
REGIME_CAR_STOCKPILE = ceil (((REGIME_ENLISTED_MEN / 5) * 0.35) * _regimeEquipmentRatio);
REGIME_TRUCK_STOCKPILE = ceil (((REGIME_ENLISTED_MEN / 20) * 0.6) * _regimeEquipmentRatio);
REGIME_APC_STOCKPILE = 120;
REGIME_LIGHT_ARMOR_STOCKPILE = 40;
REGIME_MEDIUM_ARMOR_STOCKPILE = 30;
REGIME_HEAVY_ARMOR_STOCKPILE = 15;
REGIME_HELICOPTER_STOCKPILE = 24;
REGIME_PLANE_STOCKPILE = 16;
REGIME_ARTILLERY_STOCKPILE = REGIME_TRUCK_STOCKPILE * 0.6;
REGIME_TOTAL_MANPOWER = REGIME_ENLISTED_MEN + REGIME_OFFICERS;

REGIME_CONTROLLED_TOWNS = [];
REGIME_CONTROLLED_BASES = [];
REGIME_CONTROLLED_INDUSTRY = [];
REGIME_CONTROLLED_AIRPORTS = [];
REGIME_CONTROLLED_AGRICULTURE = [];
REGIME_CONTROLLED_HARBORS = [];
REGIME_CONTROLLED_COMMERCE = [];

REGIME_TOWN_BIAS = 1;
REGIME_MILITARY_BIAS = 3;
REGIME_AGRICULTURE_BIAS = 0;
REGIME_INDUSTRIAL_BIAS = 0;
REGIME_COMMERCIAL_BIAS = 0;
REGIME_AIRPORTS_BIAS = 2;
REGIME_HARBOR_BIAS = 3;


REGIME_ELIGIBLE_GENERALS = [];
REGIME_GENERAL = [];
REGIME_MAX_GENERAL_SKILL = 5;
REGIME_GENERAL_SKILL = ceil (random REGIME_MAX_GENERAL_SKILL);
REGIME_MAXIMUM_ACTIVE_TASKS = 8;

// INFANTRY CLASSES
REGIME_INFANTRY_SOLDIER = ["rhsgref_hidf_rifleman", 1];
REGIME_INFANTRY_ASSAULT = [];
REGIME_INFANTRY_MG = [];
REGIME_INFANTRY_AT = [];
REGIME_INFANTRY_AA = [];
REGIME_INFANTRY_NCO = [];
REGIME_OFFICER = [];
REGIME_SNIPER = [];
REGIME_ELITE_SOLDIER = [];
REGIME_ELITE_ASSAULT = [];
REGIME_ELITE_MG = [];
REGIME_ELITE_AT = [];
REGIME_ELITE_AA = [];
REGIME_ELITE_NCO = [];

CAR_CLASSES = ["rhsgref_hidf_m1025",1,"rhsgref_hidf_m1025_m2",0.8,"rhsgref_hidf_m1025_mk19",0.4];
TRANSPORT_CLASSES = ["rhs_kamaz5350_open_msv",0.8,"rhs_kamaz5350_msv",1];
APC_CLASSES = [];

LIGHT_ARTILLERY_CLASSES = [];
HEAVY_ARTILLERY_CLASSES = [];

LIGHT_ARMOR_CLASSES = [];
MEDIUM_ARMOR_CLASSES = [];
HEAVY_ARMOR_CLASSES = [];

// SELECTS WHAT VEHICLE WILL SPAWN (Might be unneccessary)
VEHICLE_TYPE_LIST = [CAR_CLASSES,1.2,TRANSPORT_CLASSES,1];
ARMOR_TYPE_LIST = [APC_CLASSES,1.2,MEDIUM_ARMOR_CLASSES,1];

URBAN_ZONES = [];
MILITARY_ZONES = [];
AGRICULTURAL_ZONES = [];
INDUSTRIAL_ZONES = [];
COMMERCIAL_ZONES = [];
AIRPORT_ZONES = [];
HARBOR_ZONES = [];

ZONE_SELECTOR = []; // Array that contains currently-selected zone.

EastHQ = createCenter east;
WestHQ = createCenter west;
ResistanceHQ = createCenter resistance;

// FUNCTIONS
// fnc_AssignGeneral = compile preprocessfilelinenumbers "scripts\functions\fnc_AssignGeneral.sqf";
// fillVehicleSlot = compile preprocessFileLineNumbers "scripts\functions\fn_fillVehicleSlot.sqf";
fetchAreaData = compile preprocessFileLineNumbers "scripts\functions\fn_fetchAreaData.sqf";
findTargetArea = compile preprocessFileLineNumbers "scripts\functions\fn_findTargetArea.sqf";
taskDeployReinforcements = compile preprocessFileLineNumbers "scripts\functions\fn_taskDeployReinforcements.sqf";

// SET-UP GAME MODE
call compile preprocessfilelinenumbers "scripts\map\generateVehicleSlots.sqf";
//waitUntil {VEHICLESLOTS_INITIALIZED == 1};
call compile preprocessfilelinenumbers "scripts\map\generateMapAreas.sqf";
//waitUntil {URBAN_ZONES_INITIALIZED == 1};

// POPULATE MAP
// call compile preprocessfilelinenumbers "scripts\populate\generateCivilians.sqf";

// LOAD SAVED GAME

// BEGIN AI SYSTEMS
[] execVM "scripts\AI\regimeHQ.sqf";

// SET UP PLAYERS