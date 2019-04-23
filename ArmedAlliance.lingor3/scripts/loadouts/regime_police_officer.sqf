_soldier = this select 0;


comment "Exported from Arsenal by Morthon";

comment "Remove existing items";
removeAllWeapons _soldier;
removeAllItems _soldier;
removeAllAssignedItems _soldier;
removeUniform _soldier;
removeVest _soldier;
removeBackpack _soldier;
removeHeadgear _soldier;
removeGoggles _soldier;

comment "Add containers";
_soldier forceAddUniform "rhsgref_uniform_olive";
_soldier addVest "rhs_vest_pistol_holster";
for "_i" from 1 to 3 do {_soldier addItemToVest "rhsusf_mag_7x45acp_MHP";};
_soldier addHeadgear "rhs_8point_marpatwd";

comment "Add weapons";
_soldier addWeapon "rhsusf_weap_m1911a1";

comment "Add items";
_soldier linkItem "ItemWatch";
_soldier linkItem "ItemRadio";
