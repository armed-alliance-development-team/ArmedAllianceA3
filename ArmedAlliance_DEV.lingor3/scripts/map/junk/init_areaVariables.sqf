// null = [this, ] execVM "map\initAreaVariables.sqf";

_arealogic = _this select 0;
_strategicValue = 1
_side = 1;
_production = 10;
_manpower = 10;
_threat = 0;


// Parse through array looking for corresponding data.
{
	_areaName = _x;

	if (_x select 0 == _areaName) then {
		// Do something.
	};
} foreach _markers;