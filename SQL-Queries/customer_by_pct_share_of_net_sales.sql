with cte1 as (
select 
		c.customer,
		ROUND(Sum(net_sales)/1000000,2) as net_sales_mln
	from gdb041.net_sales ns
	join dim_customer c
	on c.customer_code = ns.customer_code
	where fiscal_year = 2021
	group by c.customer)
Select * , 
		net_sales_mln*100/sum(net_sales_mln) over () as pct
from cte1
order by net_sales_mln desc ;
    
