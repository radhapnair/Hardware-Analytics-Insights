CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_n_market_per_region_by_gross_sales`(
	in_fiscal_year INT,
    in_top_n INT
)
BEGIN
	with cte1 as (	select m.market, m.region, round(sum(ns.gross_price_total)/1000000,2) as gross_sales_mln
			from net_sales ns
			join dim_market m
			on ns.market = m.market
			where ns.fiscal_year= in_fiscal_year
			group by m.region, m.market ),
		cte2 as ( select *,
					dense_rank() over( partition by region order by gross_sales_mln desc ) as drnk
				  from cte1 )
	select * from cte2
	where drnk <= in_top_n ;

END