SELECT * FROM Customers c 

--

CREATE TEMP TABLE customer_by_city AS
SELECT Country, City, COUNT(CustomerID)
FROM Customers c 
Group by Country, City

SELECT * FROM customer_by_city