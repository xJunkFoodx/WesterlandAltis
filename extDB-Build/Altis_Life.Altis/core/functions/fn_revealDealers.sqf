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
	_markers = ["dealer_marker_1","dealer_marker_2","dealer_marker_3","dealer_marker_4","dealer_marker_5","dealer_marker_6","dealer_marker_7","dealer_marker_8","dealer_marker_9","dealer_marker_10"];
	{
		_marker = _x getVariable ["marker",""];
		if(_marker == "") exitWith {_error = true;};
		_marker setMarkerTextLocal "Drogendealer";
		_markers = _markers - [_marker];
	}forEach _dealers;
	{
		deleteMarkerLocal _x;
	}forEach _markers;
	
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