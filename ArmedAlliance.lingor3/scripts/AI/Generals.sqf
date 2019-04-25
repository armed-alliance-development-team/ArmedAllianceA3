REGIME_ELIGIBLE_GENERALS = ["John", "Roger", "William"];
REGIME_GENERAL = "";
REGIME_MAX_GENERAL_SKILL = 5;
REGIME_GENERAL_SKILL, _choosenGeneralNr, _nbrAvailableGenerals,
_currentElement,
REGIME_MAXIMUM_ACTIVE_TASKS= "";


//set general
_nbrAvailableGenerals = count REGIME_ELIGIBLE_GENERALS -1;
_choosenGeneralNr = random _nbrAvailableGenerals;
REGIME_GENERAL = REGIME_ELIGIBLE_GENERAL[_choosenGeneralNr];

//remove general from available generals
REGIME_ELIGIBLE_GENERALS = REGIME_ELIGIBLE_GENERALS - [REGIME_GENERAL];

REGIME_GENERAL_SKILL = ceil (random REGIME_MAX_GENERAL_SKILL);
REGIME_MAXIMUM_ACTIVE_TASKS = 8;

//if no general
if (REGIME_GENERAL isNull) then {
  REGIME_MAXIMUM_ACTIVE_TASKS = 6;
  REGIME_GENERAL_SKILL isNull;
};

