-- TABLES --
select * from sales_fact;
select * from category_dim;
select * from geography_dim;

-- 1. What is the highest sales amount in a day?

select Date, sum(Price * Quantity) as "sales" 
from sales_fact
group by Date order by sales desc;


-- 2. What is the total sales of the category ‘Dairy’?

select Category_desc, sum(Price*Quantity) as "total_sales"
from sales_fact as a 
inner join category_dim as b 
on a.Product_id = b.Product_id
group by Category_desc
having Category_desc = 'Dairy';


-- 3. Which city has the highest sales?

select City, sum(Price*Quantity) as "sales"
from sales_fact as a 
inner join geography_dim as b 
on a.Store_id = b.Store_id 
group by City
order by sales desc
limit 1;


-- 4. How many customers spent less than Rs. 3000?

select count(*)
from (select sum(Price*Quantity) as "sales"
from sales_fact
group by Customer_id
having sales < 3000) a;


-- 5. What is the sales of the category ‘Cereals’ in the city Bangalore?

select Category_desc, City, sum(Price*Quantity) as "sales"
from category_dim a
inner join sales_fact b
on a.Product_id = b.Product_id
inner join geography_dim c
on b.Store_id = c.Store_id
where Category_desc = 'Cereals'
and City = 'Bangalore'
group by 1,2;


-- 6. Which category is the top category in terms of sales for the location Mumbai?

select Category_desc , sum(Price*Quantity) as "sales"
from category_dim a
inner join sales_fact b
on a.Product_id = b.Product_id
inner join geography_dim c
on b.Store_id = c.Store_id
where City = 'Mumbai'
group by Category_desc
order by sales desc;


-- 7. What is the highest sales value of category Drinks and Beverages in a single transaction? 
--    Value should reflect only sales of the mentioned category.

select sum(Price*Quantity) as "sales"
from sales_fact a
inner join category_dim b
on a.Product_id = b.Product_id
where Category_desc = 'Drinks & Bevrages'
group by Transaction_id
order by sales desc
limit 1;


-- 8. What is the average amount spent per customer in Chennai?

select City, Customer_id, (sum(Price*Quantity)/count(distinct Customer_id)) as "avg_amount"
from sales_fact a
inner join geography_dim b
on a.Store_id = b.Store_id
where City = 'Chennai'
group by City, Customer_id;


-- 9. What is the sales amount of the lowest selling product in ‘Cereals’?

select Product_desc, sum(Price*Quantity) as "sales"
from sales_fact a
inner join category_dim b
on a.Product_id = b.Product_id
where Category_desc = 'Cereals'
group by 1
order by 2 asc
limit 1;


-- 10. What is the average revenue per customer in Maharashtra?

select State, (sum(Price*Quantity) / count(distinct Customer_id)) as "avg_revenue"
from sales_fact a
inner join geography_dim b
on a.Store_id = b.Store_id
where State = 'Maharashtra'
group by State;


-- 11. How many customers in Karnataka spent less than Rs 3000?

select count(*)
from(select Customer_id, sum(Price*Quantity) as "spent"
from sales_fact a
inner join geography_dim b
on a.Store_id = b.Store_id
where State = 'Karnataka'
Group by 1
having spent < 3000) a;


-- 12. How many cities have average revenue per customer lesser than Rs 3500?

select count(*)
from(select City, (sum(Price*Quantity) / count(distinct Customer_id)) as "avg_revenue"
from sales_fact a
inner join geography_dim b
on a.Store_id = b.Store_id
group by City
having avg_revenue < 3500) a;


-- 13. Which product was bought by the most number of customers?

select Product_desc, a.Product_id, count(distinct Customer_id) as "customers" 
from sales_fact a
inner join category_dim b
on a.Product_id = b.Product_id
group by 1, 2
limit 1;


-- 14. How many products were bought by at least 5 customers in Maharashtra?

select count(*)
from(select Product_id, count(distinct Customer_id) as "customers"
from sales_fact a
inner join geography_dim b
on a.Store_id = b.Store_id
where State = 'Maharashtra'
group by Product_id
having customers >= 5) a;

-- 15. What is the highest average amount spent per product by a customer?

select Customer_id, sum(Price*Quantity) / count(distinct Product_id) as "avg_amount_spent"
from sales_fact
group by Customer_id
order by avg_amount_spent desc
limit 1;



