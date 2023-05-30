SELECT*
FROM (
		SELECT
		c.YEAR,
		round(avg(c.price_growth),2)AS price_growth,
		round(avg(m.wages_growth),2)AS wages_growth		
	FROM t_m_p_ceny_narust c
	JOIN t_m_p_mzdy_narust m
		ON c.YEAR = m.payroll_year
	GROUP BY c.YEAR) pw
	JOIN (
		SELECT 
			round( ( e.GDP - e2.GDP ) / e2.GDP * 100, 2 ) as GDP_growth,
			e.YEAR		   
		FROM economies e 
		JOIN economies e2 
		    ON e.country = e2.country 
		    AND e.year = e2.year + 1
		    AND e.country = 'Czech Republic'
		  )G_growth
	ON pw.YEAR = G_growth.Year
 ;   