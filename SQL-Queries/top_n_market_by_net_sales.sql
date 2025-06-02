CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_n_markets_by_net_sales`(
	in_fiscal_year INT,
    in_top_n INT
)
BEGIN
	select 
		market,
		ROUND(Sum(net_sales)/1000000,2) as net_sales_mln 
	from gdb041.net_sales ns
	where fiscal_year = in_fiscal_year
	group by market
	order by net_sales_mln desc
	limit in_top_n;
END