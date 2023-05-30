CREATE OR REPLACE TABLE t_m_p_ceny_narust AS (
SELECT 
	m1.`Year`, 
	m2.`Year` AS Year_prev,
	m1.category_code,
	m1.price AS price_CZK,
	m2.price AS Price_prev_CZK,
	round (((m1.price - m2.price)/m2.price)*100,2) AS price_growth
FROM t_misa_peslova_2 AS m1
JOIN t_misa_peslova_2  AS m2
	ON m1.YEAR = m2.YEAR+1
	AND m1.category_code = m2.category_code
)
;
SELECT*
FROM t_m_p_ceny_narust ;
/*narust mezd*/
CREATE OR REPLACE TABLE t_m_p_mzdy_narust AS (
SELECT 
		v1.payroll_year,
		avg (v1.average_wages) AS avg_wages,
		avg(v2.average_wages) AS avg_wages_prev,
		round (((v1.average_wages - v2.average_wages)/v2.average_wages)*100,2) AS wages_growth
FROM t_m_p_1 AS v1
JOIN t_m_p_1 AS v2
	ON v1.payroll_year = v2.payroll_year+1
	AND v1.code = v2.code
	AND v1.payroll_year BETWEEN 2006 AND 2018
GROUP BY v1.payroll_year
		
)
;
SELECT *
FROM t_m_p_mzdy_narust 
;
SELECT 	
	year,
	growth_diff
FROM (
	SELECT
		c.YEAR,
		round(avg(c.price_growth),2)AS price_growth,
		round(avg(m.wages_growth),2)AS wages_growth,
		avg(c.price_growth)-avg(m.wages_growth) AS growth_diff
	FROM t_m_p_ceny_narust c
	JOIN t_m_p_mzdy_narust m
		ON c.YEAR = m.payroll_year
	GROUP BY c.YEAR
	)diff
HAVING growth_diff > 2
;