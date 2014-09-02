#include <macro.h>
/*
	Author: Shentoza
	Show cop license to target player

*/

private["_target", "_message","_rank","_coplevel"];

_target = [_this,3,objNull,[objNull]] call BIS_fnc_param;
if(isNull _target) exitWith{};

if(playerSide != west) exitWith
{
	hint "Du bist kein Polizist!";
};
//Set rank
switch (__GETC__(life_coplevel)) do
{
	case 1: { _rank = "Rekrut"; };
	case 2: { _rank = "Beamter"; };
	case 3: { _rank = "Polizeimeister"; };
	case 4: { _rank = "Polizei Hauptmeister"; };
	case 5: { _rank = "Kommissar"; };
	case 6: { _rank = "Nicht erlaubter Rang"; };
	case 7: { _rank = "Polizeipräsident";};
	default {_rank =  "Ungültiger Rang";};
};



//Compose message
_message = format["<img size='10' color='#FFFFFF' image='bilder\police_gold.paa'/><br/><br/><t size='2.5'>%1</t><br/><t size='1.5'>%2</t><br/><t size='1'>Altis Polzeidirektion</t>", player getVariable["realname",name player], _rank];

//Show license to target player
[[player, _message],"life_fnc_copLicenseShown",_target,false] spawn life_fnc_MP;