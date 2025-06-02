CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_n_customers_by_net_sales`(
	in_market varchar(45),
    in_fiscal_year INT,
    in_top_n INT
)
BEGIN
	select 
		c.customer,
		ROUND(Sum(net_sales)/1000000,2) as net_sales_mln 
	from gdb041.net_sales ns
	join dim_customer c
	on c.customer_code = ns.customer_code
	where fiscal_year = in_fiscal_year and ns.market = in_market
	group by c.customer
	order by net_sales_mln desc
	limit in_top_n ;
END