if (DEBUG == 1) then {
    systemChat format ["Generating Zones!"];
};
private ["_areaMarkers","_vehicleSlots","_armorSlots","_planeSlots"];

_areaMarkers = allMapMarkers;
_vehicleSlots = vehicleSlots;
_armorSlots = armorSlots;
_planeSlots = planeSlots;

// Define area types.

// Military zones act as staging areas from which the Regime does raids and assaults. They are also the point of origin for QRFs.
{
	if (markerColor _x == "colorRED") then {
		_x setMarkerAlpha 0;
		_areaPos = getMarkerPos _x;
		private _grp = createGroup sideLogic;
		_arealogic = "LocationBase_F" createUnit [_areaPos,_grp];
		_areaLogic setVariable ["OWNER",_x];
		_areaRot = MarkerDir _x;
		_areaShape = markerShape _x;
		_areaType = 1;
		_controllingSide = 0; // 0 = Regime, 1 = Loyalists, 2 = Rebels, 3 = Civilian
		_strategicValue = REGIME_MILITARY_BIAS; // Will dynamically change based on factors.
		
		private _area = _x;
		_vehicleSlotsInArea = _vehicleSlots inAreaArray _x;
		{_x setVariable ["OWNER",_area]} forEach _vehicleSlotsInArea;
		_numberOfVehicleSlots = count _vehicleSlotsInArea;
		_vehicleSlots = _vehicleSlots - _vehicleSlotsInArea;

		_armorSlotsInArea = _armorSlots inAreaArray _x;
		{_x setVariable ["OWNER",_area]} forEach _armorSlotsInArea;
		_numberOfArmorSlots = count _armorSlotsInArea;
		_armorSlots = _armorSlots - _armorSlotsInArea;
		
		_array = [[[_x,_areaType],_areaPos,_areaRot,_areaShape,_controllingSide,_strategicValue,_vehicleSlotsInArea,_numberOfVehicleSlots]];
		
		MILITARY_ZONES append _array;
		
		if (NewGame) then {REGIME_CONTROLLED_BASES append [_x]};
		
		_areaMarkers = _areaMarkers - [_x];
	}
} forEach _areaMarkers;

// Harbor zones act as staging areas from which the Regime does raids and assaults. They are also the point of origin for QRFs.
{
	if (markerColor _x == "ColorBlue") then {
		_x setMarkerAlpha 0;
		_areaPos = getMarkerPos _x;
		_areaLogic = "LocationArea_F" createUnit [_areaPos, EastHQ];
		_areaLogic setVariable ["OWNER",_x];
		_areaRot = MarkerDir _x;
		_areaShape = markerShape _x;
		_controllingSide = 0; // 0 = Regime, 1 = Loyalists, 2 = Rebels, 3 = Civilian
		_strategicValue = REGIME_HARBOR_BIAS; // Will dynamically change based on factors.
		
		private _area = _x;
		_vehicleSlotsInArea = _vehicleSlots inAreaArray _x;
		{_x setVariable ["OWNER",_area]} forEach _vehicleSlotsInArea;
		_numberOfVehicleSlots = count _vehicleSlotsInArea;
		_vehicleSlots = _vehicleSlots - _vehicleSlotsInArea;

		_armorSlotsInArea = _armorSlots inAreaArray _x;
		{_x setVariable ["OWNER",_area]} forEach _armorSlotsInArea;
		_numberOfArmorSlots = count _armorSlotsInArea;
		_armorSlots = _armorSlots - _armorSlotsInArea;
		
		_array = [[[_x,_areaType],_areaLogic,_areaPos,_areaRot,_areaShape,_controllingSide,_strategicValue,_vehicleSlotsInArea,_numberOfVehicleSlots]];
		
		HARBOR_ZONES append _array;
		
		if (NewGame) then {REGIME_CONTROLLED_HARBORS append [_x]};
		
		_areaMarkers = _areaMarkers - [_x];
	}
} forEach _areaMarkers;

if (DEBUG == 1) then {
    systemChat format ["%1 " + "Military Zones generated!",(count MILITARY_ZONES)];
};

// No idea what food zones do.
{
	if (markerColor _x == "ColorBrown") then {
		_x setMarkerAlpha 0;
		_areaPos = getMarkerPos _x;
		_areaLogic = "LocationArea_F" createVehicle _areaPos;
		_areaLogic setVariable ["OWNER",_x];
		_areaRot = MarkerDir _x;
		_areaShape = markerShape _x;
		_controllingSide = 0; // 0 = Regime, 1 = Loyalists, 2 = Rebels, 3 = Civilian
		_strategicValue = REGIME_AGRICULTURE_BIAS; // Will dynamically change based on factors.
		_incomeValue = 10; // Determine income value based on type of zone and population.
		
		if !(count _vehicleSlots == 0) then {
			_area = _x;
			_vehicleSlotsInArea = _vehicleSlots inAreaArray _x;
			{_x setVariable ["OWNER",_area]} forEach _vehicleSlotsInArea;
			_numberOfVehicleSlots = count _vehicleSlotsInArea;
			_vehicleSlots = _vehicleSlots - _vehicleSlotsInArea;
		};
		
		if !(count _armorSlots == 0) then {
			private _area = _x;
			_armorSlotsInArea = _armorSlots inAreaArray _x;
			{_x setVariable ["OWNER",_area]} forEach _armorSlotsInArea;
			_numberOfArmorSlots = count _armorSlotsInArea;
			_armorSlots = _armorSlots - _armorSlotsInArea;
		};
		
		_array = [[[_x,_areaType],_areaPos,_areaRot,_areaShape,_controllingSide,_strategicValue,_incomeValue]];
		
		AGRICULTURAL_ZONES append _array;
		if (NewGame) then {REGIME_CONTROLLED_AGRICULTURE append [_x]};
		_areaMarkers = _areaMarkers - [_x];
	}
} forEach _areaMarkers;

if (DEBUG == 1) then {
    systemChat format ["%1 " + "Agricultural Zones generated!",(count AGRICULTURAL_ZONES)];
};

// Industrial zones give unique raw resources to build things with.
{
	if (markerColor _x == "ColorPink") then {
		_x setMarkerAlpha 0;
		_areaPos = getMarkerPos _x;
		_areaLogic = "LocationArea_F" createVehicle _areaPos;
		_areaLogic setVariable ["OWNER",_x];
		_areaRot = MarkerDir _x;
		_areaShape = markerShape _x;
		_controllingSide = 0; // 0 = Regime, 1 = Loyalists, 2 = Rebels, 3 = Civilian
		_strategicValue = REGIME_INDUSTRIAL_BIAS; // Will dynamically change based on factors.
		_incomeValue = 10; // Determine income value based on type of zone and population.
		
		if !(count _vehicleSlots == 0) then {
			_area = _x;
			_vehicleSlotsInArea = _vehicleSlots inAreaArray _x;
			{_x setVariable ["OWNER",_area]} forEach _vehicleSlotsInArea;
			_numberOfVehicleSlots = count _vehicleSlotsInArea;
			_vehicleSlots = _vehicleSlots - _vehicleSlotsInArea;
		};
		
		if !(count _armorSlots == 0) then {
			private _area = _x;
			_armorSlotsInArea = _armorSlots inAreaArray _x;
			{_x setVariable ["OWNER",_area]} forEach _armorSlotsInArea;
			_numberOfArmorSlots = count _armorSlotsInArea;
			_armorSlots = _armorSlots - _armorSlotsInArea;
		};
		
		_array = [[[_x,_areaType],_areaPos,_areaRot,_areaShape,_controllingSide,_strategicValue,_incomeValue]];
		
		INDUSTRIAL_ZONES append _array;
		if (NewGame) then {REGIME_CONTROLLED_INDUSTRY append [_x]};
		_areaMarkers = _areaMarkers - [_x];
	}
} forEach _areaMarkers;

if (DEBUG == 1) then {
    systemChat format ["%1 " + "Industrial Zones generated!",(count INDUSTRIAL_ZONES)];
};

// Commercial zones provide a steady stream of income.
{
	if (markerColor _x == "ColorKhaki") then {
		_x setMarkerAlpha 0;
		_areaPos = getMarkerPos _x;
		_areaLogic = "LocationArea_F" createVehicle _areaPos;
		_areaLogic setVariable ["OWNER",_x];
		_areaRot = MarkerDir _x;
		_areaShape = markerShape _x;
		_controllingSide = 0; // 0 = Regime, 1 = Loyalists, 2 = Rebels, 3 = Civilian
		_strategicValue = REGIME_COMMERCIAL_BIAS; // Will dynamically change based on factors.
		_incomeValue = 10; // Determine income value based on type of zone and population.
				
		if !(count _vehicleSlots == 0) then {
			_area = _x;
			_vehicleSlotsInArea = _vehicleSlots inAreaArray _x;
			{_x setVariable ["OWNER",_area]} forEach _vehicleSlotsInArea;
			_numberOfVehicleSlots = count _vehicleSlotsInArea;
			_vehicleSlots = _vehicleSlots - _vehicleSlotsInArea;
		};
		
		if !(count _armorSlots == 0) then {
			private _area = _x;
			_armorSlotsInArea = _armorSlots inAreaArray _x;
			{_x setVariable ["OWNER",_area]} forEach _armorSlotsInArea;
			_numberOfArmorSlots = count _armorSlotsInArea;
			_armorSlots = _armorSlots - _armorSlotsInArea;
		};
		
		_array = [[[_x,_areaType],_areaPos,_areaRot,_areaShape,_controllingSide,_strategicValue,_incomeValue]];
		
		COMMERCIAL_ZONES append _array;
		if (NewGame) then {REGIME_CONTROLLED_COMMERCE append [_x]};
		_areaMarkers = _areaMarkers - [_x];
	}
} forEach _areaMarkers;

if (DEBUG == 1) then {
    systemChat format ["%1 " + "Commercial Zones generated!",(count COMMERCIAL_ZONES)];
};

// Airports act as staging areas for Regime Air Assaults and open the door for foreign resupplies.
{
	if (markerColor _x == "ColorYellow") then {
		_x setMarkerAlpha 0;
		_areaPos = getMarkerPos _x;
		_areaLogic = "LocationBase_F" createVehicle _areaPos;
		_areaLogic setVariable ["OWNER",_x];
		_areaRot = MarkerDir _x;
		_areaShape = markerShape _x;
		_controllingSide = 0; // 0 = Regime, 1 = Loyalists, 2 = Rebels, 3 = Civilian
		_strategicValue = REGIME_AIRPORTS_BIAS; // Will dynamically change based on factors.
		_supplyValue = 10; // Determine income value based on type of zone and population.
		
		if !(count _vehicleSlots == 0) then {
			_area = _x;
			_vehicleSlotsInArea = _vehicleSlots inAreaArray _x;
			{_x setVariable ["OWNER",_area]} forEach _vehicleSlotsInArea;
			_numberOfVehicleSlots = count _vehicleSlotsInArea;
			_vehicleSlots = _vehicleSlots - _vehicleSlotsInArea;
		};
		
		if !(count _armorSlots == 0) then {
			private _area = _x;
			_armorSlotsInArea = _armorSlots inAreaArray _x;
			{_x setVariable ["OWNER",_area]} forEach _armorSlotsInArea;
			_numberOfArmorSlots = count _armorSlotsInArea;
			_armorSlots = _armorSlots - _armorSlotsInArea;
		};
		
		_array = [[[_x,_areaType],_areaPos,_areaRot,_areaShape,_controllingSide,_strategicValue,_supplyValue]];
		
		AIRPORT_ZONES append _array;
		if (NewGame) then {REGIME_CONTROLLED_AIRPORTS append [_x]};
		_areaMarkers = _areaMarkers - [_x];
	}
} forEach _areaMarkers;

if (DEBUG == 1) then {
    systemChat format ["%1 " + "Airport Zones generated!",(count AIRPORT_ZONES)];
};

// Town zones are the main source of MANPOWER.
{
	if (markerColor _x == "colorCIV") then {
		_x setMarkerAlpha 0;
		
		_areaPos = getMarkerPos _x;
		_areaLogic = "LocationCity_F" createVehicle _areaPos;
		_areaLogic setVariable ["OWNER",_x];
		_areaRot = MarkerDir _x;
		_areaShape = markerShape _x;
		_controllingSide = 0; // 0 = Regime, 1 = Loyalists, 2 = Rebels, 3 = Civilian
		_strategicValue = REGIME_TOWN_BIAS; // Will dynamically change based on factors.
		_population = 100;
		_incomeValue = 10; // Determine income value based on type of zone and population.
		_manpowerValue = 5; // Determine manpower value based on population.
		
		if !(count _vehicleSlots == 0) then {
			_area = _x;
			_vehicleSlotsInArea = _vehicleSlots inAreaArray _x;
			{_x setVariable ["OWNER",_area]} forEach _vehicleSlotsInArea;
			_numberOfVehicleSlots = count _vehicleSlotsInArea;
			_vehicleSlots = _vehicleSlots - _vehicleSlotsInArea;
		};
		
		if !(count _armorSlots == 0) then {
			private _area = _x;
			_armorSlotsInArea = _armorSlots inAreaArray _x;
			{_x setVariable ["OWNER",_area]} forEach _armorSlotsInArea;
			_numberOfArmorSlots = count _armorSlotsInArea;
			_armorSlots = _armorSlots - _armorSlotsInArea;
		};
		
		_array = [[[_x,_areaType],_areaPos,_areaRot,_areaShape,_controllingSide,_strategicValue,_incomeValue,_manpowerValue]];

		URBAN_ZONES append [_array];
		
		if (NewGame) then {REGIME_CONTROLLED_TOWNS append [_x]};
		
		_areaMarkers = _areaMarkers - [_x];
	}
} forEach _areaMarkers;

if (DEBUG == 1) then {
   systemChat format ["%1 " + "Urban Zones generated!",(count URBAN_ZONES)];
};


if (SORT_ZONES) then {
	REGIME_CONTROLLED_TOWNS sort true;
	REGIME_CONTROLLED_BASES sort true;
	REGIME_CONTROLLED_INDUSTRY sort true;
	REGIME_CONTROLLED_AIRPORTS sort true;
	REGIME_CONTROLLED_AGRICULTURE sort true;
	REGIME_CONTROLLED_HARBORS sort true;
	REGIME_CONTROLLED_COMMERCE sort true;
};

URBAN_ZONES_INITIALIZED = 1;

/*
// Parse through array looking for corresponding data.
{
	_areaName = _x;

	if (_x select 0 == _areaName) then {
		// Do something.
		_x execVM "createArea.sqf";
	};
} foreach _markers;
*/