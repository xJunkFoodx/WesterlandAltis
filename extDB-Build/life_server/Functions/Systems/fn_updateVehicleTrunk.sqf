/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Updates the storage for a vehicle
*/
private["_house"];
_vehicle = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
if(isNull _vehicle) exitWith {};

_trunkData = _vehicle getVariable["Trunk",[[],0]];
_vehicleID = _vehicle getVariable["veh_id",-1];

if(_vehicleID == -1) exitWith {}; //Dafuq?

_trunkData = [_trunkData] call DB_fnc_mresArray;
_query = format["UPDATE vehicles SET inventory='%1' WHERE id='%2'",_trunkData,_vehicleID];
waitUntil{!DB_Async_Active};
[_query,1] call DB_fnc_asyncCall;