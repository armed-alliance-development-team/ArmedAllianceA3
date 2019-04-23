// GENERATE VEHICLE ON VEHICLE-SLOT.

_slot = _this select 0;
_slotType = _slot getVariable "slotType";

if (_slotType == "VEHICLE") then {
	{createVehicle ["Sign_Arrow_Large_F", _x, [], 0, "CAN_COLLIDE"];} forEach vehicleSlots;
	};

if (_slotType == "ARMOR") then {
	{createVehicle ["Sign_Arrow_Large_Blue_F", _x, [], 0, "CAN_COLLIDE"];} forEach armorSlots;
	};

if (_slotType == "PLANE") then {
	{createVehicle ["Sign_Arrow_Large_Green_F", _x, [], 0, "CAN_COLLIDE"];} forEach planeSlots;
	};