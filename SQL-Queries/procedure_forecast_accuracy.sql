CREATE DEFINER=`root`@`localhost` PROCEDURE `get_forecast_accuracy`(
	in_fiscal_year INT
)
BEGIN
	with forecast_err_table as (
		Select 
			s.customer_code, sum(s.sold_quantity) as sold_quantity, sum(s.forecast_quantity) as forecast_quantity,
			sum((forecast_quantity - sold_quantity)) as net_err,
			sum((forecast_quantity-sold_quantity))*100/sum(forecast_quantity) as net_err_pct,
			sum(abs(forecast_quantity-sold_quantity)) as abs_err,
			sum(abs(forecast_quantity-sold_quantity))*100/sum(forecast_quantity) as abs_err_pct
		from gdb041.fact_act_est s
		where s.fiscal_year = in_fiscal_year
		group by customer_code )
	select 
		   c.market, c.customer, e.*,
		   if (abs_err_pct > 100, 0, 100-abs_err_pct) as forecast_accuracy
	from forecast_err_table e
	join dim_customer c
	using (customer_code)
	order by forecast_accuracy desc ;
END