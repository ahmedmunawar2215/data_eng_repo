SELECT  * FROM  Employees e;

--

CREATE TEMP TABLE employees_age_temp AS
SELECT EmployeeID,
City AS employee_city, 
TitleOfCourtesy ||' '||LastName AS employee_name,
ROUND((JULIANDAY('now') - JULIANDAY(BirthDate))/360.25)  AS employee_age, 
ROUND((JULIANDAY('now') - JULIANDAY(HireDate))/360.25) AS working_year
FROM Employees e 
LEFT JOIN employees_age_temp USING(EmployeeID);


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
