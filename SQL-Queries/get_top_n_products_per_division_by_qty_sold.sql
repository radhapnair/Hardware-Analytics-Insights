CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_n_products_per_division_by_qty_sold`(
	in_fiscal_year INT,
    in_top_n INT
)
BEGIN
	with cte1 as ( 
			select p.division, p.product, sum(s.sold_quantity) as total_qty
			from fact_sales_monthly s
			join dim_product p
				on s.product_code = p.product_code
			where s.fiscal_year = in_fiscal_year
			group by p.division, p.product ),
		cte2 as (
			select *,
				dense_rank() over(partition by division order by total_qty desc) as drnk
			from cte1 )
	select *
	from cte2
	where drnk<= in_top_n ;
END