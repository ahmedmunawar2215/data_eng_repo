-- CATEGORIES
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
create temp table categories_temp_1 as

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
group by categories.CategoryID;

create temp table categories_temp_2 as
select 
'Total', 
count(categories_temp_1.categories),
sum(categories_temp_1.total_products), 
sum(categories_temp_1.total_worth), 
sum(categories_temp_1.In_stocks), 
sum(categories_temp_1.Discontinued),
sum(categories_temp_1.cheapest), 
sum(categories_temp_1.most_expensive), 
sum(categories_temp_1.average)

from categories_temp_1;

create temp table categories_temp as

select * from categories_temp_1
UNION
select * from categories_temp_2;




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
end as Compare_with_Avg

from Products 
join Categories on Products.CategoryID = categories.CategoryID
join categories_temp on products.CategoryID = categories_temp.ID;


------------------------------------------------------------------------------------
select * from categories_temp;
select * from categories_temp_1;
select * from categories_temp_2;
select * from avg_table;
SELECT * FROM categories;
select * from Products;
drop table Categories_temp;
drop table Categories_temp_1;
drop table Categories_temp_2;
drop table avg_table;





-----------------------------------------------------------------------------
-----------------------------------------------------------------------------



-- territories
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
drop table territories_temp;


create temp table territories_temp as

select 
Territories.TerritoryID, 
Territories.TerritoryDescription , 
Regions.RegionDescription  
from Territories
join Regions on Territories.RegionID == Regions.RegionID 
;

select * from territories_temp;

select * from Territories;
select * from Regions;






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






-----------------------------------------------------------------------------
-----------------------------------------------------------------------------


-- First_Script
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-- Employees by Title
create temp table employees_by_title as
SELECT
	Title,
	COUNT(EmployeeID) as number_of_employee
  FROM
  Employees
  GROUP BY Title
  ORDER BY Title 

-------------------------------------------------------------------------------- 

 -- Employee Distribution by City
 create temp table number_of_employee_residing as
SELECT
       MAX(City) AS cities,
       COUNT(City) AS number_of_employee_residing 
FROM 
	Employees e 
GROUP BY 
	city 
ORDER BY 
	city 
	
--------------------------------------------------------------------------------
	
-- Employee Distribution by Country
 create temp table number_of_employee_by_country as
SELECT   
       MAX(Country) AS countries,
       COUNT(Country) AS number_of_employee_residing
FROM 
	Employees e 
GROUP BY 
	country
ORDER BY 
	country
	
--------------------------------------------------------------------------------

-- Contact Info of Employees
create temp table contact_info_temp as
SELECT 
	FirstName || ' ' || LastName ||' ' ||'can be reached at' ||' ' ||Extension AS Contactinfo
FROM 
	employees;

--------------------------------------------------------------------------------

-- Employees Sorted By Their Seniority
create temp table employee_seniority_temp as
SELECT 
	FirstName || ' ' || LastName AS FullName, 
	HireDate
FROM 
	Employees e 
ORDER BY 
	HireDate;

--------------------------------------------------------------------------------

-- Duration of employment
create temp table employment_duration_temp as
SELECT  
	hiredate,
	current_date,  
	(current_date - HireDate) AS duration_of_employment
from 
	Employees ;

--------------------------------------------------------------------------------

-- List of The Roles in The Company
create temp table list_of_roles_temp as
SELECT 
DISTINCT Title, 
COUNT(Title) 
FROM 
	Employees
GROUP BY 
	Title
	
--------------------------------------------------------------------------------
	
	
SELECT * FROM employee_statistics_temp;
SELECT * FROM contact_info_temp;
SELECT * FROM employee_seniority_temp;
SELECT * FROM employment_duration_temp;
SELECT * FROM list_of_roles_temp;


DROP TABLE employee_statistics_temp;
DROP TABLE contact_info_temp;
DROP TABLE employee_seniority_temp;
DROP TABLE employment_duration_temp;
DROP TABLE list_of_roles_temp;






-----------------------------------------------------------------------------
-----------------------------------------------------------------------------


-- Second_Script
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-- List of Employee Territories
create temp table list_of_employee_territories_temp as
SELECT * 
FROM 
	Territories t 
LEFT JOIN 
	EmployeeTerritories e 
ON 
	t.TerritoryID = e.TerritoryID

--------------------------------------------------------------------------------

-- Employees By Territories
create temp table employees_by_territory_temp as
SELECT  
	FirstName || ' ' || LastName as Name,
	et.TerritoryID ,
	t.TerritoryDescription  
FROM 
	EmployeeTerritories et 
LEFT JOIN 
	Employees e 
ON 
	et.EmployeeID = e.EmployeeID
LEFT JOIN
	Territories t
ON 
	t.TerritoryID =et.TerritoryID 
	
--------------------------------------------------------------------------------
	
-- Total Territory By Employee
create temp table total_territory_by_employee_temp as
SELECT 
	FirstName || ' ' || LastName as Name,
	COUNT(et.TerritoryID) as Total_Territory
FROM 
	EmployeeTerritories et 
LEFT JOIN 
	Employees e 
ON 
	et.EmployeeID = e.EmployeeID
GROUP BY 
	Name
ORDER BY	
	Total_Territory DESC

--------------------------------------------------------------------------------

-- Who Reports To Who? (First)
create temp table who_reports_who_temp as
SELECT 
	empa.employeeid, 
	empa.firstname, 
	empa.lastname, 
	empb.firstname AS 'Reports to Manager' 
FROM   
	employees empa 
INNER JOIN 
	employees empb 
ON 
	empa.reportsto = empb.employeeid  
	
-------------------------------------------------------------------------------

-- Who Reports To Who? (Second) 
create temp table who_reports_who_second_temp as
SELECT 
	a.EmployeeID,
	a.LastName || " " || a.FirstName as employee,
	b.LastName||" " || b.FirstName  as manager
FROM 
	employees a
LEFT JOIN 
	employees b
ON 
	b.EmployeeID = a.ReportsTo
ORDER BY 
	a.EmployeeID;
      
-------------------------------------------------------------------------------


SELECT * FROM list_of_employee_territories_temp;
SELECT * FROM employees_by_territory_temp;
SELECT * FROM total_territory_by_employee_temp;
SELECT * FROM who_reports_who_temp;
SELECT * FROM who_reports_who_second_temp;


DROP TABLE list_of_employee_territories_temp;
DROP TABLE employees_by_territory_temp;
DROP TABLE total_territory_by_employee_temp;
DROP TABLE who_reports_who_temp;
DROP TABLE who_reports_who_second_temp;