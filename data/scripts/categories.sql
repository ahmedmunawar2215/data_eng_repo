SELECT * FROM categories;
select * from Products;
drop table Categories_temp;

create temp table categories_temp as
select categories.CategoryID, 
categories.CategoryName,
count(products.ProductName), 
sum(products.UnitPrice), 
sum(products.UnitsInStock), 
sum(products.Discontinued),
min(products.UnitPrice), 
max(products.UnitPrice), 
round(avg(products.UnitPrice), 2), 
case when 
from Categories 
join Products on products.CategoryID = categories.CategoryID
group by categories.CategoryID ;

select * from categories_temp;