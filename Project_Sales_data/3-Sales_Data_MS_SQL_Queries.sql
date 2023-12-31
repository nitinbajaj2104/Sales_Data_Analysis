
select * from sales_data ;

select distinct(status) from sales_data ;
select distinct(productline) from sales_data ;
select distinct(country) from sales_data ;
select distinct(territory) from sales_data ;
select distinct(dealsize) from sales_data ;

-- Sales by product line
select productline , sum(sales) as 'Sum of Sales' from sales_data group by productline order by sum(sales) desc ;

-- Sales by Year
select year_id,sum(sales) as 'Sum of Sales' from sales_data group by year_id  order by sum(sales) desc;

-- Sales by dealsize
select dealsize,sum(sales) as 'Sum of Sales' from sales_data group by dealsize order by sum(sales) desc;

-- Best Month for sale in each year
select top 1 month_id,year_id,sum(sales) as 'Total_sales' from sales_data where year_id=2003 group by month_id,year_id order by sum(sales) desc ;
select top 1 month_id,year_id,sum(sales) as 'Total_sales' from sales_data where year_id=2004 group by month_id,year_id order by sum(sales) desc ;
select top 1 month_id,year_id,sum(sales) as 'Total_sales' from sales_data where year_id=2005 group by month_id,year_id order by sum(sales) desc ;

-- Top 3 Customers on the basis of Sales as per Productline
with
cte1 as
(select productline,customername,sum(sales) as 'Total_sales'  from sales_data group by productline,customername)
select * from (select *,row_number() over(partition by productline order by total_sales  desc) as 'top3_customers' from cte1) A
where top3_customers<=3;

-- Top 3 Customers on the basis of total number of orders as per Productline
with 
cte2 as 
(select productline,customername,count(ordernumber) as 'frequency' from sales_data group by productline,customername)
select * from (select *,row_number() over(partition by productline order by frequency  desc) as 'top3_customers' from cte2) B
where top3_customers<=3;