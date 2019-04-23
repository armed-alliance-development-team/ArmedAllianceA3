// fn_taskDeployReinforcements.sqf
// REDEPLOY INFANTRY.

_targetType = ["TOWN","MILITARY"];

ZONE_SELECTOR = selectRandom REGIME_CONTROLLED_BASES;
_taskTargetLocation = [ZONE_SELECTOR,_targetType] call findTargetArea;

// Fetch relevant data.
_taskTargetData = [ZONE_SELECTOR] call fetchAreaData;
_taskOriginData = [_taskTargetLocation] call fetchAreaData;

{

_taskTargetLocation = getMarkerPos selectRandom REGIME_CONTROLLED_BASES;

/*
_findLocations = nearestObjects [_taskTargetLocation, "LocationResupplyPoint_F",5000]; 
_taskStartLocation = [0,0,0];


{

	if ((_x getVariable "OWNER") in REGIME_CONTROLLED_HARBORS) then {

		_taskStartLocation append [_x];

	}

} foreach _findLocations;
*/

// Select nearest Resupply point.
_taskStartLocation = getMarkerPos selectRandom REGIME_CONTROLLED_HARBORS;

// Prepare to spawn AI group. Like find safe place to spawn.

// How many Trucks do we need?
_supplyNeed = 100;
_trucksNeeded = ceil (_supplyNeed / 25);
_truckSpawned = 0;

_grp = createGroup west;
while {_truckSpawned < _trucksNeeded} do {
// Spawn Supply vehicle and driver.
_safePos = [_taskStartLocation,0,50,3,0] call BIS_fnc_findSafePos;
_supplyVehicle = selectRandomWeighted TRANSPORT_CLASSES createVehicle _safePos;
REGIME_TRUCK_STOCKPILE = REGIME_TRUCK_STOCKPILE - 1;
_supplyVehicle setVariable ["OWNER",""];

_driver = _grp createUnit [selectRandomWeighted REGIME_INFANTRY_SOLDIER, position player,[],0,"NONE"];
REGIME_ENLISTED_MEN = REGIME_ENLISTED_MEN - 1;
// removeAllWeapons _driver;
_driver assignAsDriver _supplyVehicle;
_driver moveinDriver _supplyVehicle;
_driver setVariable ["OWNER",""];
player moveinCargo _supplyVehicle;

_truckSpawned = _truckSpawned + 1;

sleep 1;
};

_truckSpawned = nil;

// Update variables and eventhandlers.

// Send the unit off.
_wp = _grp addWaypoint [_taskTargetLocation,0];
_wp setWaypointFormation "COLUMN";
_wp setWaypointType "MOVE";
_wp setWaypointCombatMode "GREEN";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointStatements ["true", "hint 'Supply mission completed! Execute function to end mission.';deleteVehicle vehicle this; deleteVehicle this;}"];

if (DEBUG == 1) then {
	hint format ["Beginning resupply mission."];
};
