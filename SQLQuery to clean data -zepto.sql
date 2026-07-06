SELECT TOP 100 * FROM zepto_v2;
select count (*) from zepto_v2;

--null value if any
select * from zepto_v2
where category is Null
or name is null
or mrp is null
or discountPercent is null
or availableQuantity is null
or discountedSellingPrice is null
or weightInGms is null
or outOfStock is null
or quantity is null

--different product catergories
select distinct Category from zepto_v2 order by Category

--product in  stock and out of stock

Select
outOfStock,
Count (availableQuantity) as count
from zepto_v2
group by outOfStock

--product name present multiple times

select
name,
count (availableQuantity) as "Number of Sku"
from zepto_v2
group by name
having count (availableQuantity)>1
order by count (availableQuantity) desc

--data cleaning
-- product with price zero
select * from zepto_v2
where mrp= 0 or discountedSellingPrice = 0
delete from zepto_v2
where mrp=0 

-- convert currency from paisa to rupees
update zepto_v2
set mrp=mrp/100,
discountedSellingPrice=discountedSellingPrice/100

select mrp , discountedSellingPrice from zepto_v2

-- Q1. Find the top 10 best-value products based on the discount percentage.
select * from zepto_v2

SELECT distinct TOP 10 
    name,
    mrp,
    discountPercent
FROM zepto_v2
ORDER BY discountPercent DESC;

--Q2.What are the Products with High MRP but Out of Stock

select distinct
name,
mrp
from zepto_v2
where outOfStock= 1 and mrp>300
order by mrp desc


--Q3.Calculate Estimated Revenue for each category
select
Category,
sum (availableQuantity * discountedSellingPrice) as Estimated_Revenue
from zepto_v2
group by Category
order by Estimated_Revenue

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.

select distinct
name,
discountPercent,
mrp
from zepto_v2
where mrp> 500 and discountPercent< 10
order by mrp desc , discountPercent desc


-- Q5. Identify the top 5 categories offering the highest average discount percentage.
select distinct top 5 
Category,
round (Avg (DiscountPercent),2) as Average_discount
from zepto_v2
group by category 
order by  Average_discount desc

-- Q6. Find the price per gram for products above 100g and sort by best value.

select distinct
name,
DiscountedSellingPrice,
weightInGms,
DiscountedSellingPrice/weightInGms as price_per_gram
from zepto_v2
where weightInGms> =100
order by price_per_gram desc

--Q7.Group the products into categories like Low, Medium, Bulk.
select distinct
name,
weightInGms,
case when weightInGms< 1000 then 'low'
     when weightInGms <5000 then 'medium'
     else  'bulk'
     end as weight_category
from zepto_v2

--Q8.What is the Total Inventory Weight Per Category 

SELECT 
    category,
    SUM(CAST(WeightInGms AS BIGINT) * CAST(availableQuantity AS BIGINT)) AS total_weight
FROM zepto_v2
GROUP BY category
ORDER BY total_weight DESC;


