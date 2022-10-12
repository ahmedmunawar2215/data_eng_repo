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