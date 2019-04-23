{
	_areaName = _x;
	if (_x select 0 == _areaName) then {
		// Do something.
		_x execVM "createArea.sqf";
	};
} forEach MILITARY_ZONES;