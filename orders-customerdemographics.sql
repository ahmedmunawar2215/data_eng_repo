CREATE TEMP TABLE orders_custdemo as 
select
ShipCity,
COUNT(orders.OrderID),  
Avg(orders.Freight),
max(Orders.Freight),
min(orders.Freight),
count(CustomerDemographics.CustomerTypeID)
from Orders, CustomerDemographics 
group by shipcity

union 
orders.OrderID, 
CustomerDemographics.CustomerTypeID
from Orders, CustomerDemographics ;

--cost of Freight 
CREATE TEMP TABLE orders_Freight_cost_by_city as 
select Freight,OrderID,ShipCity,
CASE 
	when Freight >= 1008 then "high cost"
	when Freight <= 79 then "low cost"
	else "normal cost"
END as Freight_cost 
FROM Orders 
group by ShipCity ;
group by orders.shipcity ;