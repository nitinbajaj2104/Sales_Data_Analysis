create database project ;

select * from sales_data ;

select distinct(status) from sales_data ;
select distinct(productline) from sales_data ;
select distinct(country) from sales_data ;
select distinct(territory) from sales_data ;
select distinct(dealsize) from sales_data ;

#1 Sales by product line
select productline , sum(sales) from sales_data group by productline order by sum(sales) desc  ;

#2 Sales by Year
select year_id,sum(sales) from sales_data group by year_id  order by sum(sales) desc;

#3 Sales by dealsize
select dealsize,sum(sales) from sales_data group by dealsize order by sum(sales) desc;

#4 Best Month for sale in each year
select month_id,year_id,sum(sales) from sales_data where year_id=2003 group by month_id,year_id order by sum(sales) desc limit 1 ;
select month_id,year_id,sum(sales) from sales_data where year_id=2004 group by month_id,year_id order by sum(sales) desc limit 1 ;
select month_id,year_id,sum(sales) from sales_data where year_id=2005 group by month_id,year_id order by sum(sales) desc limit 1 ;

#5 Top 3 Customers on the basis of Sales as per Productline
with
cte as
(select productline,customername,sum(sales) "total_sales"  from sales_data group by productline,customername)
select * from (select *,row_number() over(partition by productline order by total_sales  desc) "top3_customers" from cte) A
where top3_customers<=3;

#6 Top 3 Customers on the basis of total number of orders as per Productline
with 
cte1 as 
(select productline,customername,count(ordernumber) "frequency"  from sales_data group by productline,customername)
select * from (select *,row_number() over(partition by productline order by frequency  desc) "top3_customers" from cte1) B
where top3_customers<=3;






