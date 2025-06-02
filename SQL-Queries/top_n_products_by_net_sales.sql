CREATE DEFINER=`root`@`localhost` PROCEDURE `top_n_product_by_net_sales`(
	in_fiscal_year INT,
    in_top_n INT
)
BEGIN
	select p.product, ROUND(Sum(net_sales)/1000000,2) as net_sales_mln 
	from net_sales ns
	join dim_product p
	on ns.product_code = p.product_code
	where ns.fiscal_year = in_fiscal_year
	group by p.product
	order by net_sales_mln desc 
	limit in_top_n;
END