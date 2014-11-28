#include <macro.h>
/*
	Author: Shentoza
	Show cop license to target player

*/

private["_target", "_message","_rank","_coplevel"];

//_target = [_this,3,objNull,[objNull]] call BIS_fnc_param;
_target = cursorTarget;

if(isNull _target) exitWith{};

if(playerSide != west) exitWith
{
	hint "Du bist kein Polizist!";
};
//Set rank
switch (__GETC__(life_coplevel)) do
{
	case 1: { _rank = "Anwärter"; };
	case 2: { _rank = "Rekrut"; };
	case 3: { _rank = "Beamter"; };
	case 4: { _rank = "Meister"; };
	case 5: { _rank = "Obermeister"; };
	case 6: { _rank = "Hauptmeister"; };
	case 7: { _rank = "Kommissar";};
	case 8: { _rank = "Oberkommissar";};
	case 9: { _rank = "Hauptkommissar";};
	case 10: { _rank = "Polizeipräsident";};
	
	default {_rank =  "Ungültiger Rang";};
};
if (license_cop_dea) then { _rank = "DEA Beamter"; };
if (__GETC__(life_adminlevel) > 0 && (__GETC__(life_coplevel) == 10)) then { _rank = "N.S.A. Beamter"; };


//Compose message
_message = format["<img size='10' color='#FFFFFF' image='bilder\police_gold.paa'/><br/><br/><t size='2'>%1</t><br/><t size='1.5'>%2</t><br/><t size='1'>Altis Polizeidirektion</t>", player getVariable["realname",name player], _rank];

//Show license to target player
[[player, _message],"life_fnc_copLicenseShown",_target,false] spawn life_fnc_MP;