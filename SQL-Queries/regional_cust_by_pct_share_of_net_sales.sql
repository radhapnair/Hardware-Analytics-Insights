with cte1 as 
	( select c.customer, m.region, round(sum(ns.net_sales)/1000000,2) as net_sales_mln
	  from net_sales ns
      join dim_customer c
      on c.customer_code = ns.customer_code
      join dim_market m
      on ns.market = m.market
      where ns.fiscal_year = 2021
      group by customer, region )
select *,
		net_sales_mln*100/sum(net_sales_mln) over(partition by region)  as pct
from cte1
order by region, net_sales_mln desc ;