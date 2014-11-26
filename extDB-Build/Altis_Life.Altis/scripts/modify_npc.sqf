private["_unit"];
_unit= _this select 0;
//Funkioniert irgend wie nicht
//if(Side _unit != civilian) then{
removeHeadgear _unit;
//};
_unit unassignItem "NVGoggles";
_unit removeItem "NVGoggles";
_unit removeItem "NVGoggles_OPFOR";
_unit unassignItem "NVGoggles_OPFOR";
_unit removeItem "NVGoggles_INDEP";
_unit unassignItem "NVGoggles_INDEP";
 removeVest _unit;
 removeBackpack _unit;
 removeAllWeapons _unit;
 _unit switchmove "";
 _unit enableSimulation false;
_unit allowDamage false;