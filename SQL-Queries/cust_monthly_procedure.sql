CREATE DEFINER=`root`@`localhost` PROCEDURE `get_monthly_gross_sales_for_customer`(
	cust_code text
)
BEGIN
	SELECT 
		s.date,  round(Sum(g.gross_price*s.sold_quantity),2) as gross_price_total
	FROM gdb041.fact_sales_monthly s
	join gdb056.gross_price g
		on g.product_code= s.product_code and g.fiscal_year = get_fiscal_year(s.date)
	where 
		find_in_set(s.customer_code, cust_code)>0
	Group by 
		s.date
	order by 
		s.date asc ;
END