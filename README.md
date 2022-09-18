# data_eng_repo
Hello guys I hope you are doing well. I want to write what we talked on the latest project session. 
The latest aim is to create temporary tables which carries the aggregated data information (max,avg,min)
of a specific table by item/category wise and also you can add the case statements for those items/categories.
eg you have products table and you can check the products categories max discounts sales counts and save them in a 
temporary table after it according to the counts of sales by product/category case when count>1000 then 'Fast selling' 
when count>200 then 'Often selling' else 'Slow selling' end as sales_rate. This is just a small example with an abstract table. 
After it this temp table will be joined back to main table and we will have a bigger picture of the main table. 
Let me know if you have any questions