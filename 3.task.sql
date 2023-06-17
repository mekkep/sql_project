/*task 3*/
SELECT  
	food_category_code,
	ROUND((((price_CZK)-(price_prev_CZK))/(price_prev_CZK))*100,2) AS growth
FROM (
	SELECT 
		m1.payroll_year, 
		m2.payroll_year AS Year_prev,
		m1.food_category_code,
		ROUND(AVG(m1.avg_price),2) AS price_CZK,
		ROUND(AVG(m2.avg_price),2) AS price_prev_CZK
	FROM t_misa_peslova_project_sql_primary_final AS m1
	JOIN t_misa_peslova_project_sql_primary_final AS m2
		ON m1.payroll_year = m2.payroll_year +1
		AND m1.food_category_code = m2.food_category_code
	GROUP BY 
		m1.food_category_code,
		m1.payroll_year, 
		m2.payroll_year
	) g
HAVING growth >0 AND growth <1
ORDER BY growth	
LIMIT 1
;