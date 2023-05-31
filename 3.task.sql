/*priklad 3*/

SELECT 
		food_category_code,
		ROUND(AVG(growth),2) AS growth
	FROM (
			SELECT 
				m1.payroll_year, 
				m2.payroll_year AS Year_prev,
				m1.food_category_code,
				m1.avg_price AS price_CZK,
				m2.avg_price AS Price_prev_CZK,
				ROUND(((m1.avg_price - m2.avg_price)/m2.avg_price)*100,2) AS growth
			FROM t_misa_peslova_project_sql_primary_final AS m1
			JOIN t_misa_peslova_project_sql_primary_final AS m2
				ON m1.payroll_year = m2.payroll_year +1
				AND m1.food_category_code = m2.food_category_code
				HAVING growth > 0 AND growth <1
			) AS g
	GROUP BY food_category_code
	ORDER BY AVG(growth)
	LIMIT 1
	;
	