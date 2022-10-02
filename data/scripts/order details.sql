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