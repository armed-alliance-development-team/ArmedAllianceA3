// GENERATE VEHICLE ON VEHICLE-SLOT FROM AREA MARKER.

_area = _this select 0; // Garrison area marker.
_amountVehicles = 4; // _this select 1; // Amount of vehicles to reinforce with.
_amountArmor = _this select 2; // Amount of vehicles to reinforce with.
_amountPlanes = _this select 3; // Amount of vehicles to reinforce with.
_spawned = 0;
//_selectedSlot = [];

// Find all slots.
_totalVehicleSlots = vehicleSlots inAreaArray _area;
_validArmorSlots = armorSlots inAreaArray _area;
_validPlaneSlots = planeSlots inAreaArray _area;
// _vehicle = VEHICLE_CLASSNAMES selectRandomWeighted VEHICLE_WEIGHTS;

// Filter overlapping slots.

{
_slotOccupied = _x getVariable "slotOccupied";
if (_slotOccupied == "YES") then {
_validVehicleSlots = _totalVehicleSlots - _x;
};
} forEach _totalVehicleSlots;

if (_amountVehicles > _validVehicleSlots) then {
	_amountDifference = _amountVehicles - _validVehicleSlots;
	_amountVehicles = _amountVehicles - _amountDifference;
};


while {_spawned < _amountVehicles} do {
	_selectedSlot = selectRandom _validVehicleSlots;

	_rng = random 1;
	_percentage = 50; 
	_slotOccupied = _selectedSlot getVariable "slotOccupied";
	if ((_rng > (_percentage / 100)) && (_slotOccupied == "NO")) then {
		_vehicleType = selectRandomWeighted VEHICLE_TYPE_LIST;
		_vehicle = selectRandomWeighted _vehicleType;
		_generatedVehicle = createVehicle [_vehicle, [getpos _selectedSlot select 0, (getpos _selectedSlot select 1), 10000 + (random 1000)], [], 0, "CAN_COLLIDE"];
		_generatedVehicle enableSimulationGlobal false;
		_generatedVehicle setVehicleLock "LOCKED";
		_generatedVehicle setDir (getDir _selectedSlot);
		_generatedVehicle setPos (getPos _selectedSlot);
		_generatedVehicle enableDynamicSimulation true;
		_generatedVehicle triggerDynamicSimulation false;
		_generatedVehicle enableSimulationGlobal true;
		_selectedSlot setVariable ["slotOccupied", "YES"];
		//_validVehicleSlots = _validVehicleSlots - _selectedSlot;
		_spawned = _spawned + 1;
		//hint ["%1 light vehicles spawned.",_spawned]; 
	};
};

