CREATE TEMP TABLE IF NOT EXISTS customer_by_city AS
SELECT Country, City, COUNT(CustomerID)
FROM Customers c 
Group by Country, City

SELECT * from customer_by_city