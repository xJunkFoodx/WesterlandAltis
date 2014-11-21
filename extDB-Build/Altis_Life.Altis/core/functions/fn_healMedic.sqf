/*
	File: fn_healMedic.sqf
	Author: DONARfr aka Cheng
	
	Description:
	Allows Medics to heal Players
*/
private ['_medic', '_player', '_damage'];
_medic = this select 0; // _this    this ist bei initialisierung von Mapobjekten, _this ist die Parameter Variable von Funktionen
_player = this select 1;
_damage = _player damage;

if(!(_player iskindof "man")) exitWith{}; //eventuell mit 'isPlayer' prüfen ob Spieler, sonst könnten NPCs geheilt werden
if(player distance cursorTarget > 3) exitWith {
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
//Kneel over person, lay both hands over body 
player playMove "AinvPknlMstpSnonWrflDnon_medic";
sleep 0.7;
_player setDamage 0;
 }; 
default { titleText ["Nicht verletzt", "PLAIN"]; };
 };
