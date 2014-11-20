#include <macro.h>
/*
	Author: Bryan "Tonic" Boardwine
	Edited: Shentoza
	Description:
	Handles various different ammo types being fired.
*/
private["_ammoType","_projectile","_weapon","_restricted"];
_ammoType = _this select 4; 
_weapon = _this select 1;
_projectile = _this select 6;

if(_ammoType == "GrenadeHand_stone") then {
	_projectile spawn {
		private["_position"];
		while {!isNull _this} do {
			_position = getPosATL _this;
			sleep 0.1;
		};
		[[_position],"life_fnc_flashbang",true,false] spawn life_fnc_MP;
	};
};
_restricted =
switch (side player) do 
{
	case independent: {[]};
	case east: {[]};
	case west: {[]};
	case civilian: {["arifle_TRG20_F","arifle_Katiba_F","srifle_DMR_01_F","LMG_Mk200_F","arifle_Mk20C_plain_F"]};
	default {[]};
};

switch (__GETC__(life_donator)) do
{
	case 0: 
	{
		_restricted set [count _restricted,"arifle_Mk20C_plain_F"];
		_restricted set [count _restricted,"LMG_Mk200_F"];
		_restricted set [count _restricted,"arifle_TRG21_F"];
		if(!license_cop_dea) then{
		_restricted set [count _restricted,"hgun_pistol_heavy_01_F"];};
	};
	case 1: 
	{
		_restricted set [count _restricted,"arifle_Mk20C_plain_F"];
		_restricted set [count _restricted,"LMG_Mk200_F"];
		_restricted set [count _restricted,"arifle_TRG21_F"];
		if(!license_cop_dea) then{
		_restricted set [count _restricted,"hgun_pistol_heavy_01_F"];};
	};
	case 2:
	{
		_restricted set [count _restricted,"arifle_Mk20C_plain_F"];
		_restricted set [count _restricted,"LMG_Mk200_F"];
		_restricted set [count _restricted,"arifle_TRG21_F"];
		if(!license_cop_dea) then{
		_restricted set [count _restricted,"hgun_pistol_heavy_01_F"];};
	};
	case 3: {};
	default
	{
		_restricted set [count _restricted,"arifle_Mk20C_plain_F"];
		_restricted set [count _restricted,"LMG_Mk200_F"];
		_restricted set [count _restricted,"arifle_TRG21_F"];
		if(!license_cop_dea) then{
		_restricted set [count _restricted,"hgun_pistol_heavy_01_F"];};
	};
};

if (_weapon in _restricted) then
{
	player removeWeaponGlobal _weapon;
	deleteVehicle _projectile;
	titleText["Du darfst diese Waffe nicht benutzen!","PLAIN"];
};