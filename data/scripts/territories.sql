drop table territories_temp;


create temp table territories_temp as

select 

Territories.TerritoryDescription, 
count(Territories.TerritoryID), 
count(Territories.RegionID),
min(Territories.TerritoryID),
max(Territories.TerritoryID),
avg(Territories.TerritoryID)

from Territories 
group by Territories.TerritoryDescription

UNION 

select "Total", count(Territories.TerritoryID), 
count(Territories.RegionID),
min(Territories.TerritoryID),
max(Territories.TerritoryID),
round(avg(Territories.TerritoryID), 2)
from Territories

order by 2
;

select * from territories_temp