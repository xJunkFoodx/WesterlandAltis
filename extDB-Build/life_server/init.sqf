#define __CONST__(var1,var2) var1 = compileFinal (if(typeName var2 == "STRING") then {var2} else {str(var2)})
DB_Async_Active = false;
DB_Async_ExtraLock = false;
life_server_isReady = false;
publicVariable "life_server_isReady";

[] execVM "\life_server\functions.sqf";
[] execVM "\life_server\eventhandlers.sqf";

//I am aiming to confuse people including myself, ignore the ui checks it's because I test locally.

_extDB = false;

//Only need to setup extDB once.
if(isNil {uiNamespace getVariable "life_sql_id"}) then {
	life_sql_id = round(random(9999));
	__CONST__(life_sql_id,life_sql_id);
	uiNamespace setVariable ["life_sql_id",life_sql_id];

	//extDB Version
	_result = "extDB" callExtension "9:VERSION";
	diag_log format ["extDB: Version: %1", _result];
	if(_result == "") exitWith {};
	if ((parseNumber _result) < 14) exitWith {diag_log "Error: extDB version 14 or Higher Required";};

	//Initialize the database
	_result = "extDB" callExtension "9:DATABASE:Database2";
	if(_result != "[1]") exitWith {diag_log "extDB: Error with Database Connection";};
	_result = "extDB" callExtension format["9:ADD:DB_RAW_V2:%1",(call life_sql_id)];
	if(_result != "[1]") exitWith {diag_log "extDB: Error with Database Connection";};
	"extDB" callExtension "9:LOCK";
	_extDB = true;
	diag_log "extDB: Connected to Database";
} else {
	life_sql_id = uiNamespace getVariable "life_sql_id";
	__CONST__(life_sql_id,life_sql_id);
	_extDB = true;
	diag_log "extDB: Still Connected to Database";
};

//Broadbase PV to Clients, to warn about extDB Error.
//	exitWith to stop trying to run rest of Server Code
if (!_extDB) exitWith {
	life_server_extDB_notLoaded = true;
	publicVariable "life_server_extDB_notLoaded";
	diag_log "extDB: Error checked extDB/logs for more info";
};

//Run procedures for SQL cleanup on mission start.
["CALL resetLifeVehicles",1] spawn DB_fnc_asyncCall;
["CALL deleteDeadVehicles",1] spawn DB_fnc_asyncCall;
["CALL deleteOldHouses",1] spawn DB_fnc_asyncCall;
["CALL deleteOldGangs",1] spawn DB_fnc_asyncCall; //Maybe delete old gangs

life_adminlevel = 0;
life_medicLevel = 0;
life_coplevel = 0;
life_reblevel = 0;

//Null out harmful things for the server.
__CONST__(JxMxE_PublishVehicle,"No");

//[] execVM "\life_server\fn_initHC.sqf";

life_radio_west = radioChannelCreate [[0, 0.95, 1, 0.8], "Side Channel", "%UNIT_NAME", []];
life_radio_civ = radioChannelCreate [[0, 0.95, 1, 0.8], "Side Channel", "%UNIT_NAME", []];
life_radio_indep = radioChannelCreate [[0, 0.95, 1, 0.8], "Side Channel", "%UNIT_NAME", []];

serv_sv_use = [];

fed_bank setVariable["safe",(count playableUnits),true];

//General cleanup for clients disconnecting.
addMissionEventHandler ["HandleDisconnect",{_this call TON_fnc_clientDisconnect; false;}]; //Do not second guess this, this can be stacked this way.

[] spawn TON_fnc_cleanup;
life_gang_list = [];
publicVariable "life_gang_list";
life_wanted_list = [];
client_session_list = [];
life_side_players = [];

[] execFSM "\life_server\cleanup.fsm";

[] spawn
{
	private["_logic","_queue"];
	while {true} do
	{
		sleep (30 * 60);
		_logic = missionnamespace getvariable ["bis_functions_mainscope",objnull];
		_queue = _logic getvariable "BIS_fnc_MP_queue";
		_logic setVariable["BIS_fnc_MP_queue",[],TRUE];
	};
};

[] spawn TON_fnc_federalUpdate;

[] spawn
{
	while {true} do
	{
		sleep (30 * 60);
		{
			_x setVariable["sellers",[],true];
		} foreach [dealer_1,dealer_2,dealer_3];
	};
};

//Strip NPC's of weapons
{
	if(!isPlayer _x) then {
		_npc = _x;
		{
			if(_x != "") then {
				_npc removeWeapon _x;
			};
		} foreach [primaryWeapon _npc,secondaryWeapon _npc,handgunWeapon _npc];
	};
} foreach allUnits;

[] spawn TON_fnc_initHouses;
[] spawn TON_fnc_betMonitor;

life_cratedrop_positions = [
	[4335,19740,"Suedwestlich des Kokainfelds"],
	[6679,19021,"Nordoestlich der Sandverarbeitung"],
	[7355,21293,"Beim Windpark Synneforos"],
	[11209,21442,"Im Norden von Altis"],
	[11776,19526,"Noerdlich von Koroni"],
	[14715,19993,"Suedlich von DP6"],
	[12042,17115,"Noerdlich von Lakka"],
	[16995,17294,"Oestlich der Zentralbank"],
	[17887,15727,"In der Naehe von Charkia"],
	[21916,16160,"In der Naehe von Kalochori"],
	[22273,19033,"Westlich der Almyra-Salzmine"],
	[25675,20427,"Suedlich Sofia"],
	[26182,23399,"In der Naehe von Molos"],
	[21474,13458,"Suedlich des Sumpfs"],
	[17786,10904,"Suedoestlich des Steinbruchs"],
	[19864,8571,"Westlich Panagia"],
	[9820,7119,"In der Naehe des Rebellendorfs"],
	[12060,7606,"Beim Windpark Skopos"],
	[11691,9424,"Bei Vikos"],
	[11022,10995,"Bei Drimea"],
	[11067,12767,"Zwischen Poliakko und Therisa"],
	[10473,14518,"Westlich von Alikampos"],
	[7105,14831,"Suedoestlich des Medikamentenhaendlers"],
	[5013,13355,"Oestlich von Kavala"],
	[4302,11000,"Westlich von DP8"],
	[7430,11295,"Bei Edessa"],
	[8212,12872,"In der Naehe der Kokainverarbeitung"],
	[10644,16014,"Zwischen DP11 und DP12"],
	[3073,13151,"In der Naehe der Burg Kavala"]
];
life_dealer_positions =
[
	["dealer_marker_1",[[15011.4,11160.4,0.00140953],309.248]], //Meeresarm
	["dealer_marker_2",[[17937,8773.14,0.00141907],142]], //darunter
	["dealer_marker_3",[[20566.1,8885.91,0.315102],265]], //DP 23
	["dealer_marker_4",[[17531.8,19065.6,4.08283],150.595]], // nördl Hafen
	["dealer_marker_5",[[9400.46,20319.2,1.95258],123.756]], //Über DP5
	["dealer_marker_6",[[4059.7,11746.1,3.06422],336.925]], // Neri
	["dealer_marker_7",[[3563.23,10244.7,3.63839],126.412]], //Knast
	["dealer_marker_8",[[3492.87,14146,0.00144577],177.525]], //Kavalla Basketballfeld
	["dealer_marker_9",[[14328.7,17436.4,0.0015583],218.683]], //Athira
	["dealer_marker_10",[[20894.8,14614.5,0.664073],316.866]] //Sumpf
];
life_dealer_npcs =
[dealer_1,dealer_2,dealer_3];
_announced = false;
{
	private ["_random","_marker","_position","_direction"];
	_randomInt = ( floor ( random ( count life_dealer_positions)));
	_random = life_dealer_positions select _randomInt;
	_marker = _random select 0;
	if(!_announced) then
	{
		_marker setMarkerText "Drogendealer";
		_announced = true;
	};
	_position = _random select 1 select 0;
	_direction = _random select 1 select 1;
	_x setPos [_position select 0,_position select 1,_position select 2];
	_x setDir _direction;
	_x setVariable ["marker",_marker,TRUE];
	life_dealer_positions deleteAt _randomInt;
}forEach life_dealer_npcs;

[] spawn TON_fnc_spawnParadrop;

//Lockup the dome
private["_dome","_rsb"];
_dome = nearestObject [[16019.5,16952.9,0],"Land_Dome_Big_F"];
_rsb = nearestObject [[16019.5,16952.9,0],"Land_Research_house_V1_F"];

for "_i" from 1 to 3 do {_dome setVariable[format["bis_disabled_Door_%1",_i],1,true]; _dome animate [format["Door_%1_rot",_i],0];};
_rsb setVariable["bis_disabled_Door_1",1,true];
_rsb allowDamage false;
_dome allowDamage false;
life_server_isReady = true;
publicVariable "life_server_isReady";
