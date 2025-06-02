SELECT 
    s.date, 
    s.product_code, 
    p.product, 
    p.variant, 
    SUM(s.sold_quantity) AS total_quantity_sold, 
    MIN(g.gross_price) AS gross_price_per_item, 
    SUM(g.gross_price * s.sold_quantity) AS gross_price_total
FROM 
    gdb041.fact_sales_monthly s
JOIN 
    gdb056.gross_price g 
    ON g.product_code = s.product_code 
    AND g.fiscal_year = get_fiscal_year(s.date)
JOIN 
    dim_customer c 
    ON c.customer_code = s.customer_code
JOIN 
    dim_product p 
    ON p.product_code = s.product_code
WHERE 
    s.customer_code IN (90002016, 90002008) 
    AND c.market = 'India' 
    AND get_fiscal_year(s.date) = 2021
GROUP BY 
    s.date, s.product_code, p.product, p.variant
ORDER BY 
    s.date ASC;