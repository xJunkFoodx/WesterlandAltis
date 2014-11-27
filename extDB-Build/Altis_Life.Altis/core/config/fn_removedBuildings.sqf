/*
	Author: Shentoza
	File: fn_removedBuildings.sqf
	
	Description:
	Removes (hides) an amount of buildings at loading
*/
_remove = 
[
[3654.56,13196.9,-0.31782], //Kavalla Barracks on market
[3231.31,12958.4,0.0354576] //HQ smallFactory
];

{
_building = nearestBuilding _x;
hideObjectGlobal _building;
_building allowDamage false;
_building enableSimulation false;
}forEach _remove;

//Invulnerable
_inv=
[
[16042.4,16955.6,0.00146294] // Zentralbank
];
{
	_building = nearestBuilding _x;
	_building allowDamage false;
}forEach _inv;