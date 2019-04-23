// fn_findTargetArea.sqf;
// Finds the nearest eligible task destinations and returns.

_targetArea = _this select 0;
_targetType = _this select 1;

// Check what type are needed.
if ("TOWN" in _targetType) then {
	_selectArray append REGIME_CONTROLLED_TOWNS;
};
if ("MILITARY" in _targetType) then {
	_selectArray append REGIME_CONTROLLED_MILITARY;
};
if ("AGRICULTURE" in _targetType) then {
	_selectArray append REGIME_CONTROLLED_AGRICULTURE;
};
if ("INDUSTRIAL" in _targetType) then {
	_selectArray append REGIME_CONTROLLED_INDUSTRIAL;
};
if ("COMMERCE" in _targetType) then {
	_selectArray append REGIME_CONTROLLED_COMMERCE;
};
if ("AIRPORT" in _targetType) then {
	_selectArray append REGIME_CONTROLLED_AIRPORTS;
};
if ("HARBOR" in _targetType) then {
	_selectArray append REGIME_CONTROLLED_HARBORS;
};

_nearestLocation = [_selectArray, _targetArea] call BIS_fnc_nearestPosition;

// Returns
_return = _nearestLocation;