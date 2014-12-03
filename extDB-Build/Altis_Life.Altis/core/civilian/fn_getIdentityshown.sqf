/*
	Author: DONARfr aka. Cheng
	
	Description:
	get identity card shown
*/
#define Btn1 37450
#define Btn2 37451
#define Btn3 37452
#define Btn4 37453
#define Btn5 37454
#define Btn6 37455
#define Btn7 37456
#define Btn8 37457
#define Title 37401

private["_player", "_title"];
_player = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
_salutation = [_this,1,0] call BIS_fnc_param;
if(isNull _player) exitWith {}; //NO

if(!dialog) then {
	createDialog "pInteraction_Menu";
};
disableSerialization;
_display = findDisplay 37400;
_title = _display displayCtrl Title;
_Btn1 = _display displayCtrl Btn1;
_Btn2 = _display displayCtrl Btn2;
_Btn3 = _display displayCtrl Btn3;
_Btn4 = _display displayCtrl Btn4;
_Btn5 = _display displayCtrl Btn5;
_Btn6 = _display displayCtrl Btn6;
_Btn7 = _display displayCtrl Btn7;

_Btn1 ctrlEnable false;
_Btn2 ctrlEnable false;
_Btn3 ctrlEnable false;
_Btn4 ctrlEnable false;
_Btn5 ctrlEnable false;
_Btn6 ctrlEnable false;
_Btn7 ctrlEnable false;

_title ctrlSetText localize "STR_pAct_Identity_document";

_Btn1 ctrlSetText (_player getVariable "realname");
//Farhzeuglizenz
if(license_civ_driver) then {
_Btn2 ctrlSetText (localize "STR_License_Driver" + ": " + localize "STR_Global_Yes" );
}
else{
_Btn2 ctrlSetText (localize "STR_License_Driver" + ": " + localize "STR_Global_No");
};
_Btn3 ctrlEnable false;
//Truck
if(license_civ_truck) then {
_Btn3 ctrlSetText ("LKW: " + localize "STR_Global_Yes" );
}
else{
_Btn3 ctrlSetText ("LKW: " + localize "STR_Global_No");
};
//Heli
if(license_civ_air) then {
_Btn4 ctrlSetText (localize "STR_License_Pilot" + ": " + localize "STR_Global_Yes" );
}
else{
_Btn4 ctrlSetText (localize "STR_License_Pilot" + ": " + localize "STR_Global_No");
};
//Boot
if(license_civ_boat) then {
_Btn5 ctrlSetText (localize "STR_License_Boat" + ": " + localize "STR_Global_Yes" );
}
else{
_Btn5 ctrlSetText (localize "STR_License_Boat" + ": " + localize "STR_Global_No");
};
//Admin
switch (_salutation) do
{
    case 0:
    {
     _salutation="Bürger";
	};
    case 1:
    {
     _salutation="Hilfsbursche";
    };
    case 2:
    {
    _salutation="Hilfsbursche";    
    };
    case 3:
    {
     _salutation="Stadtrad";    
    };
    case 4:
    {
     _salutation="Abgeordneter";    
    };
    case 5:
    {
     _salutation="NSA";    
    };
};
_Btn6 ctrlSetText _salutation;

_Btn7 ctrlShow false;