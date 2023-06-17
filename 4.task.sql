/*task 4*/
SELECT 
	payroll_year,
	(price_growth)-(wages_growth) AS growth_diff
FROM (
	SELECT
		v1.payroll_year,
		ROUND(((AVG(v1.avg_price) - AVG(v2.avg_price))/AVG(v2.avg_price))*100,2) AS price_growth,
		ROUND(((AVG(v1.avg_wages) - AVG(v2.avg_wages))/AVG(v2.avg_wages))*100,2) AS wages_growth
	FROM t_misa_peslova_project_sql_primary_final v1
	JOIN t_misa_peslova_project_sql_primary_final v2
		ON v1.payroll_year = v2.payroll_year+1
	GROUP BY v1.payroll_year
		) diff
;