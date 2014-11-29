/*
	Author: Shentoza
	File: fn_removedBuildings.sqf
	
	Description:
	Removes (hides) an amount of buildings at loading
*/
_remove = 
[
"1:-1226584936", //Kavalla Barracks on market
"1:-1243390316" //HQ smallFactory
];

{
	_building = objectFromNetId _x;
	hideObjectGlobal _building;
	_building allowDamage false;
	_building enableSimulation false;
}forEach _remove;

//Invulnerable
_inv=
[
	"1:-961500001" // Zentralbank
];
{
	_building = objectFromNetId _x;
	_building allowDamage false;
}forEach _inv;