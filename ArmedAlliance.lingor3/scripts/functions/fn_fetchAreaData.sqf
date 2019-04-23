// FETCH RELEVANT ZONE DATA.
// Uses single string to fetch corresponding array data and returns it.

private ["_target","_array","return"];
_target = _this select 0; // STRING
_array = [];

if (isNil _array) then {
	{
	if (_target in _x select 0) then 
		{	
			_array append _x;
			exitWith {};
		};
	} forEach URBAN_ZONES;
};

if (isNil _array) then {
	{
	if (_target in _x select 0) then 
		{	
			_array append _x;
			exitWith {};
		};
	} forEach MILITARY_ZONES;
};

if (isNil _array) then {
	{
	if (_target in _x select 0) then 
		{	
			_array append _x;
			exitWith {};
		};
	} forEach AIRPORT_ZONES;
};

if (isNil _array) then {
	{
	if (_target in _x select 0) then 
		{	
			_array append _x;
			exitWith {};
		};
	} forEach AGRICULTURAL_ZONES;
};

if (isNil _array) then {
	{
	if (_target in _x select 0) then 
		{	
			_array append _x;
			exitWith {};
		};
	} forEach INDUSTRIAL_ZONES;
};

if (isNil _array) then {
	{
	if (_target in _x select 0) then 
		{	
			_array append _x;
			exitWith {};
		};
	} forEach COMMERCIAL_ZONES;
};

if (isNil _array) then {
	{
	if (_target in _x select 0) then 
		{	
			_array append _x;
			exitWith {};
		};
	} forEach HARBOR_ZONES;
};

if (isNil _array) then {
if (DEBUG == 1) then {hintSilent format ["ERROR: Could not find data for zone called '%1'! Aborting.", _target]};
exitWith {};
};

// Returns array.
_return = _array;