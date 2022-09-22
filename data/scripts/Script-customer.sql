SELECT CustomerID, COUNT(CustomerID), ContactName, City, Country
FROM Customers c 
Group by Country, City
