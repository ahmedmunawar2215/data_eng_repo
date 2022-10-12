--orders by city 
 CREATE TEMP TABLE orders_custdemo as 
 select
 OrderID,
 ShipCity as Ship_city,
 COUNT(orders.OrderID) as Number_of_orders,  
 Avg(orders.Freight) Avarage_Freight,
 max(Orders.Freight) Max_Freight,
 min(orders.Freight) Min_Freight
 from Orders 
 group by shipcity;


 --joining two tables orders and customerDemographics.
 SELECT *
 FROM Orders
 JOIN CustomerDemographics ON orders.OrderID  = CustomerDemographics.CustomerTypeID 
 WHERE CustomerDemographics.CustomerTypeID IS NULL; 

 --cost of Freight 
 CREATE TEMP TABLE orders_Freight_cost_by_city as 
 select OrderID,Freight,ShipCity as Ship_city,
 CASE 
 	when Freight >= (select max(Freight)) then "high cost"
 	when Freight <= (select MIN(Freight)) then "low cost"
 	else "normal cost"
 END as Freight_cost 
 FROM Orders 
 group by ShipCity ;

 --employees with highest number of orders. 
 CREATE TEMP TABLE employees_with_highest_orders as
 SELECT EmployeeID  , COUNT( OrderID) as orders
 FROM orders 
 GROUP BY EmployeeID  
 ORDER BY orders DESC limit 10;

 ---- processing and arrival of shipment by city.
 CREATE TEMP TABLE order_shipping as
 select orderID,shipCity as Ship_City ,OrderDate as order_date,ShippedDate as shipped_date,
 RequiredDate as arrival_date
 from Orders o 
 group by ShipCity; 
