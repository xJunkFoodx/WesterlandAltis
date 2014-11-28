/*
	File: fn_adacCarKey.sqf
	Author: Shentoza
	Edit: DONARfr aka. Cheng
	Description:
	Gives a copy of the key for the selected vehicle you.
*/
private["_vehicle"];
if(!(player call life_fnc_isADAC)) exitWith {closeDialog 0; hint localize "STR_ANOTF_ErrorLevel";};
_vehicle = [_this,0,objNull,[objNull]] call BIS_fnc_param;
if(isNull _vehicle) then {_vehicle = (position player) nearEntities [["Air", "Car", "Ship"], 5] select 0;};
if(isNull _vehicle) exitWith{ hint "Kein Fahrzeug ausgewählt!";};

_uid = getPlayerUID player;
_owners = _vehicle getVariable "vehicle_info_owners";
_index = [_uid,_owners] call TON_fnc_index;
if(_index != -1) exitWith {hint "Du besitzt den Schlüssel bereits.";};



//Setup our progress bar
_title = localize "STR_Admin_GettingKeys";
disableSerialization;
5 cutRsc ["life_progress","PLAIN"];
_ui = uiNamespace getVariable ["life_progress",displayNull];
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;
while {true} do
{
	if(animationState player != "AinvPknlMstpSnonWnonDnon_medic_1") then {
		[[player,"AinvPknlMstpSnonWnonDnon_medic_1"],"life_fnc_animSync",true,false] spawn life_fnc_MP;
		player playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1";
	};
	sleep 0.02;
	_cP = _cP + 0.01;
	_progressBar progressSetPosition _cP;
	_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
	if(_cP >= 1 OR !alive player) exitWith {};
	if(life_istazed) exitWith {}; //Tazed
	if(life_interrupted) exitWith {};
	if((player getVariable["restrained",false])) exitWith {};
	if(player distance _vehicle > 4) exitWith {};
	if([_uid,_owners] call TON_fnc_index != -1) exitWith {hint "Du besitzt den Schlüssel bereits.";};
};
5 cutText ["","PLAIN"];
player playActionNow "stop";
if(_cp < 1) exitWith {};


if(_index == -1) then 
{
	_owners set[count _owners,[_uid,player getVariable["realname",name player]]];
	_vehicle setVariable["vehicle_info_owners",_owners,true];
	life_vehicles pushBack _vehicle;
};

hint format["Du hast die Schlüssel zu dem %1 erhalten.",typeOf _vehicle];
