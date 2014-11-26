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
hideObjectGlobal nearestBuilding _x;
_x allowDamage false;
_x enableSimulation false;
}forEach _remove;