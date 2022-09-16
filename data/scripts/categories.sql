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