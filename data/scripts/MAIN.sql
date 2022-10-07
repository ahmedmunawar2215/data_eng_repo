-- CATEGORIES
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
create temp table categories_temp as

select 
categories.CategoryID as ID, 
categories.CategoryName as categories,
count(products.ProductName) as total_products, 
sum(products.UnitPrice) as total_worth, 
sum(products.UnitsInStock) as In_stocks, 
sum(products.Discontinued) as Discontinued,
min(products.UnitPrice) as cheapest, 
max(products.UnitPrice) as most_expensive, 
round(avg(products.UnitPrice), 2) as average

from Categories 
join Products on products.CategoryID = categories.CategoryID
group by categories.CategoryID ;


------------------------------------------------------------------------------
CREATE temp TABLE avg_table AS 

SELECT 
products.ProductName as product, 
categories.CategoryName as categories, 
products.UnitPrice as unit_price,
categories_temp.average as average ,
case
when products.UnitPrice > categories_temp.average
then "Above average"
when products.UnitPrice < categories_temp.average
then "Below avrerage"
when products.UnitPrice = categories_temp.average
then "Equal to average"
end

from Products 
cross join Categories on Products.CategoryID = categories.CategoryID
cross join categories_temp on products.CategoryID = categories_temp.ID;


------------------------------------------------------------------------------------
select * from categories_temp;
select * from avg_table;
SELECT * FROM categories;
select * from Products;
drop table Categories_temp;
drop table avg_table;





-----------------------------------------------------------------------------
-----------------------------------------------------------------------------


-- Script-employee
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
SELECT  * FROM  Employees e;

--

CREATE TEMP TABLE employees_age_temp AS
SELECT EmployeeID,
City AS employee_city, 
TitleOfCourtesy ||' '||LastName AS employee_name,
ROUND((JULIANDAY('now') - JULIANDAY(BirthDate))/360.25)  AS employee_age, 
ROUND((JULIANDAY('now') - JULIANDAY(HireDate))/360.25) AS working_year
FROM Employees e;


-- Age and Seniority Calculations of Employees by City

CREATE TEMP TABLE employees_calculation_temp AS
SELECT  employee_city, COUNT(EmployeeID),
MAX(employee_age), MIN(employee_age), ROUND(AVG(employee_age)), 
MAX(working_year), MIN(working_year), ROUND(AVG(working_year))
FROM employees_age_temp
GROUP BY employee_city;


-- Employees Seniorty and Retaire Status

CREATE TEMP TABLE employees_status_temp AS
SELECT  EmployeeID, employee_name, ROUND(employee_age) AS Employee_Age, ROUND(working_year) AS Working_Year,
CASE 
	WHEN working_year >= 30 THEN "Senior Staff"
	WHEN working_year < 30 AND  working_year >20 THEN "Medior Staff"
	ELSE "Junior Staff"
END AS Seniorty_Status, 
CASE 
	WHEN employee_age > 65 THEN "Can Retaire"
	ELSE "Can't Retaire"
END Retaire_Status
FROM employees_age_temp
GROUP BY EmployeeID;

--

SELECT * FROM employees_age_temp;
SELECT * FROM employees_calculation_temp;
SELECT * FROM employees_status_temp;


DROP TABLE employees_age_temp;
DROP TABLE employees_calculation_temp;
DROP TABLE employees_status_temp;








-----------------------------------------------------------------------------
-----------------------------------------------------------------------------


-- duration_of_employment
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------





-----------------------------------------------------------------------------
-----------------------------------------------------------------------------


-- territories
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
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





-----------------------------------------------------------------------------
-----------------------------------------------------------------------------


-- order details
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
CREATE temp table ord_dt  as
select MIN(UnitPrice) as 'Minimum price',MAX(UnitPrice) as 'Maximum price',round(AVG(Quantity),2) as 'Average Quantity' 
from "Order Details"
having 1;
left join ord_dt using(ProductID);

SELECT *, 
CASE 
	when discount != 0 then 'Include Discount'
	else 'No discount'
END 'Check discount',
(select count(1) from  "Order Details" where Discount != 0 ) as 'Total order discounted',
COUNT(ProductID) as 'Number of product per order',SUM(UnitPrice) as 'Sum of price per order',SUM(Quantity) as 'Sum of quantity per order'
from "Order Details",ord_dt
group by 1;





-----------------------------------------------------------------------------
-----------------------------------------------------------------------------


-- orders-customerdemographics
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
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





-----------------------------------------------------------------------------
-----------------------------------------------------------------------------


-- Script-customer
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
SELECT * FROM Customers c 

--

CREATE TEMP TABLE customer_by_city AS
SELECT Country, City, COUNT(CustomerID)
FROM Customers c 
Group by Country, City

SELECT * FROM customer_by_city
