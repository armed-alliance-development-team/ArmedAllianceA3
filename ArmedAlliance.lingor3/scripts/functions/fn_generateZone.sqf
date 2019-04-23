[]

private _zone = _this select 0;
_zoneType = _this select 1;
_color = _this select 2;
_strategicBias = _this select 3;
{
	if (markerColor _zone == "_color") then {
		if (DEBUG == 1) then {_zone setMarkerAlpha 0};
		_areaPos = getMarkerPos _zone;
		_areaRot = MarkerDir _zone;
		_areaShape = markerShape _zone;
		_controllingSide = 0; // 0 = Regime, 1 = Loyalists, 2 = Rebels, 3 = Civilian
		_strategicValue = _strategicBias; // Will dynamically change based on factors.
		
		if !(count _vehicleSlots == 0) then {
			_area = _zone;
			_vehicleSlotsInArea = _vehicleSlots inAreaArray _zone;
			{_x setVariable ["OWNER",_area]} forEach _vehicleSlotsInArea;
			_numberOfVehicleSlots = count _vehicleSlotsInArea;
			_vehicleSlots = _vehicleSlots - _vehicleSlotsInArea;
		};
		
		if !(count _armorSlots == 0) then {
			private _area = _zone;
			_armorSlotsInArea = _armorSlots inAreaArray _zone;
			{_x setVariable ["OWNER",_area]} forEach _armorSlotsInArea;
			_numberOfArmorSlots = count _armorSlotsInArea;
			_armorSlots = _armorSlots - _armorSlotsInArea;
		};
		
		if !(count _planeSlots == 0) then {
			private _area = _zone;
			_planeSlotsInArea = _planeSlots inAreaArray _zone;
			{_x setVariable ["OWNER",_area]} forEach _planeSlotsInArea;
			_numberOfArmorSlots = count _planeSlotsInArea;
			_planeSlots = _planeSlots - _planeSlotsInArea;
		};
		
		_array = [[_zone,_areaPos,_areaRot,_areaShape,_controllingSide,_strategicValue,_vehicleSlotsInArea,_numberOfVehicleSlots]];
		
		_zoneType append _array;
		
		if (NewGame) then {REGIME_CONTROLLED_BASES append [_zone]};
		
		_areaMarkers = _areaMarkers - [_zone];
	}
} forEach _areaMarkers;