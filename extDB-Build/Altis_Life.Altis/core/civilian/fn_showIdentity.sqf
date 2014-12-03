/*
	Author: DONARfr aka. Cheng
	
	Description:
	shows your identity card
*/
private["_unit"];
_unit = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
if(isNull _unit) exitWith {}; //NO
[[player, life_adminlevel],"life_fnc_getIdentityshown",_unit,false] spawn life_fnc_MP;
closeDialog 0;