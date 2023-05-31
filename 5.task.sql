 
SELECT
	Year,
	GDP_growth,
	price_growth,
	wages_growth
FROM (
	SELECT 
		s1.Year,
		ROUND((s1.GDP - s2.GDP)/s2.GDP *100,2) as GDP_growth
	FROM t_misa_peslova_project_sql_secondary_final s1
	JOIN t_misa_peslova_project_sql_secondary_final s2
		ON s1.Year = s2.Year +1
		AND s1.country = s2.country 
		AND s1.country = 'Czech Republic'
		) gdp
	JOIN (
		SELECT
			v1.payroll_year,
			ROUND(((AVG(v1.avg_price) - AVG(v2.avg_price))/AVG(v2.avg_price))*100,2) AS price_growth,
			ROUND(((AVG(v1.average_wages) - AVG(v2.average_wages))/AVG(v2.average_wages))*100,2) AS wages_growth
		FROM t_misa_peslova_project_sql_primary_final v1
		JOIN t_misa_peslova_project_sql_primary_final v2
			ON v1.payroll_year = v2.payroll_year+1
		GROUP BY v1.payroll_year
		) pw
	ON gdp.Year = pw.payroll_year
ORDER BY Year ;
