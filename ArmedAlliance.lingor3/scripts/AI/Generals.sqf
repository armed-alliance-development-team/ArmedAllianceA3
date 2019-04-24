REGIME_ELIGIBLE_GENERALS = ["John", "Roger", "William"];
REGIME_GENERAL = "";
REGIME_MAX_GENERAL_SKILL = 5;
REGIME_GENERAL_SKILL, _choosenGeneralNr, _nbrAvailableGenerals,
_currentElement,
REGIME_MAXIMUM_ACTIVE_TASKS= "";
_newArray = [];

//set general
_nbrAvailableGenerals = count REGIME_ELIGIBLE_GENERALS -1;
_choosenGeneralNr = random _nbrAvailableGenerals;
REGIME_GENERAL = REGIME_ELIGIBLE_GENERAL[_choosenGeneralNr];

//remove general from available generals
for "_i" from 0 to _nbrAvailableGenerals do {
	_currentElement = REGIME_ELIGIBLE_GENERALS select _i;
	if (_currentElement =! REGIME_GENERAL) then {
	  _newArray = _newArray + [_currentElement]; 
	};
};
REGIME_ELIGIBLE_GENERALS = _newArray

REGIME_GENERAL_SKILL = ceil (random REGIME_MAX_GENERAL_SKILL);
REGIME_MAXIMUM_ACTIVE_TASKS = 8;

//if no general
if (REGIME_GENERAL isNull) then {
  REGIME_MAXIMUM_ACTIVE_TASKS = 6;
  REGIME_GENERAL_SKILL isNull;
};

