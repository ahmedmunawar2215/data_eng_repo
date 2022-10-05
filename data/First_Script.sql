-- Employee Statistics
create temp table employee_statistics_temp as
SELECT
  COUNT(EmployeeID) as number_of_employee,
  COUNT(DISTINCT Title) as number_of_roles,
  MAX(Title) as max_role,
  COUNT(DISTINCT TitleOfCourtesy) as number_of_courtesy,
  MAX(TitleOfCourtesy) as max_courtesy,
  COUNT(DISTINCT City) as number_of_cities,
  MAX(City) as max_city,
  COUNT(DISTINCT Country) as number_of_country,
  MAX(Country)
FROM
  Employees;
	
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
