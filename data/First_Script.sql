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
