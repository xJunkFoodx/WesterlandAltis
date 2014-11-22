/*
	File: fn_revealDealers.sqf
	Author: Shentoza
	Description: Reveals the dealer positions
*/
_action = [
	parseText format["Diese Information lasse ich mir einiges kosten!<br/>...125.000$"],
	"Zwielichtige Gestalt",
	localize "STR_Global_Yes",
	localize "STR_Global_No"
] call BIS_fnc_guiMessage;

if(_action) then {
	if(life_atmcash < 125000) exitWith {hint localize "STR_NOTF_NotEnoughFunds";}; 
	_error = false;
	_dealers = [dealer_1,dealer_2,dealer_3];
	{
		_marker = _x getVariable ["marker",""];
		if(_marker == "") exitWith {_error = true;};
		_marker setMarkerTextLocal "Drogendealer";
	}forEach _dealers;
	
	if(!_error) then {
		if (life_atmcash >= 125000) then 
			{
			life_atmcash = life_atmcash - 125000;
			[] call SOCK_fnc_updateRequest; //Silent Sync
		};
	};
	closeDialog 0;
} else {
	hint localize "STR_NOTF_ActionCancel";
	closeDialog 0;
};