_id=[1119892,1119897,1119904,1117336];
{
delh = [0,0,0] nearestObject _x;
deleteVehicle delh;
delh hideObject true;
}forEach _id;


//Zentralbank
_ids=[500895,1791561];
{
obj = [0,0,0] nearestObject _x;
obj allowdamage false;
}forEach _ids;