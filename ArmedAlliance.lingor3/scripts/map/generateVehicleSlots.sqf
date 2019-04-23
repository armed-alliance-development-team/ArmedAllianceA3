// INITIALIZE VEHICLE SLOTS

// 1. Select all vehicles.

_findVehicleSlots = nearestObjects [getmarkerpos mapCenter, ["B_Truck_01_covered_F"],5100];
_findArmorSlots = nearestObjects [getmarkerpos mapCenter, ["B_MBT_01_cannon_F"],5100];
_findPlaneSlots = nearestObjects [getmarkerpos mapCenter, ["B_Plane_CAS_01_dynamicLoadout_F"],5100];
_findAllSlots = [];

// 2. Replace placeholder vehicles with Slots.

{
	_vehicleSlotPos = getPos _x;
	_vehicleSlotRot = getDir _x;
	deleteVehicle _x;
	_createVehicleSlot = createVehicle ["Sign_Arrow_Direction_F", _vehicleSlotPos, [], 0, "CAN_COLLIDE"];
	_createVehicleSlot setDir _vehicleSlotRot;
	_createVehicleSlot setVariable ["slotType", "VEHICLE"];
	_createVehicleSlot setVariable ["isOccupiedBy","Empty"];
	_createVehicleSlot setVariable ["slotOccupied", "NO"];
	_createVehicleSlot enableSimulationGlobal false;
	vehicleSlots append [_createVehicleSlot];
} forEach _findVehicleSlots;

{
	_armorSlotPos = getPos _x;
	_armorSlotRot = getDir _x;
	deleteVehicle _x;
	_createArmorSlot = createVehicle ["Sign_Arrow_Direction_Blue_F", _armorSlotPos, [], 0, "CAN_COLLIDE"];
	_createArmorSlot setDir _armorSlotRot;
	_createArmorSlot enableSimulationGlobal false;
	_createArmorSlot setVariable ["slotType", "ARMOR"];
	_createArmorSlot setVariable ["isOccupiedBy","Empty"];
	_createArmorSlot setVariable ["slotOccupied", "NO"];
	_createArmorSlot enableSimulationGlobal false;
	armorSlots append [_createArmorSlot];
} forEach _findArmorSlots;

{
	_planeSlotPos = getPos _x;
	_planeSlotRot = getDir _x;
	deleteVehicle _x;
	_createPlaneSlot = createVehicle ["Sign_Arrow_Direction_Green_F", _planeSlotPos, [], 0, "CAN_COLLIDE"];
	_createPlaneSlot setDir _planeSlotRot;
	_createplaneSlot setVariable ["slotType", "PLANE"];
	_createplaneSlot setVariable ["isOccupiedBy","Empty"];
	_createplaneSlot setVariable ["slotOccupied", "NO"];
	_createplaneSlot enableSimulationGlobal false;
	planeSlots append [_createPlaneSlot];
} forEach _findPlaneSlots;

if (DEBUG == 0) then {
	{_x hideObjectGlobal true}forEach vehicleSlots;
	{_x hideObjectGlobal true}forEach armorSlots;
	{_x hideObjectGlobal true}forEach planeSlots;
};

VEHICLESLOTS_INITIALIZED = 1;
