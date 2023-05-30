/*priklad 3*/
	/*ktera kategorie zdrazuje nejpomaleji - nejnizsi mezirocni narust*/

CREATE OR REPLACE TABLE t_misa_peslova_2 as( 
SELECT 
		v1.payroll_year AS `Year`,
		cp.category_code,
		round(avg(cp.value),2) AS price
FROM t_m_p_1 AS v1
JOIN czechia_price AS cp 
	ON v1.payroll_year = YEAR (cp.date_from)
GROUP BY `Year`,
		cp.category_code
	)
;
SELECT 
		category_code,
		avg(growth)
	FROM (
			SELECT 
				m1.`Year`, 
				m2.`Year` AS Year_prev,
				m1.category_code,
				m1.price AS price_CZK,
				m2.price AS Price_prev_CZK,
				round (((m1.price - m2.price)/m2.price)*100,2) AS growth
			FROM t_misa_peslova_2 AS m1
			JOIN t_misa_peslova_2  AS m2
				ON m1.YEAR = m2.YEAR+1
				AND m1.category_code = m2.category_code
				HAVING growth > 0 AND growth <1
				) AS g
	GROUP BY category_code
	ORDER BY avg(growth)
	
	;

