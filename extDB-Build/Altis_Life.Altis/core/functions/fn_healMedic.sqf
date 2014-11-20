/*
	File: fn_healHospital.sqf
	Author: DONARfr aka Cheng
	
	Description:
	Allows Medics to heal Players
*/
private ['_medic', '_player', '_damage'];
_medic = this select 0;
_player = this select 1;
_damage = _player damage;

if(!(_player iskindof "man")) exitWith{};
if(player distance cursorTarget > 5) exitWith {
titleText[localize "STR_NOTF_HS_ToFar","PLAIN"]
};
switch (true) 
do {
case (_damage >0.5): { titleText ["Pflaster aufkleben", "PLAIN"]; 
sleep 0.2;
_player setDamage 0;
}; 
case (_damage <0.5): {
titleText ["Behandle", "PLAIN"]; 
sleep 0.7;
//player playMove "";
_player setDamage 0;
 }; 
default { titleText ["Nicht verletzt", "PLAIN"]; };
 };
