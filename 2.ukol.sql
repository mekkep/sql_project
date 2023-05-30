
/* priklad 2*/
/*prvni obdobi*/ -- 1.q.2006
SELECT MIN(date_from)
FROM czechia_price cp 

;
/*posledni obdobi*/ -- 4.q.2018
SELECT MAX (date_to)
FROM czechia_price cp 

;

SELECT 
	v1.payroll_year,
	avg(v1.average_wages) AS avg_wages_all_branches,
	cp.category_code,
	round(AVG(cp.value),2) AS price_CZK,
	FLOOR(v1.average_wages/avg(cp.value)) AS amount_in_units
FROM t_m_p_1 AS v1
LEFT JOIN czechia_price AS cp 
	ON v1.payroll_year = YEAR (cp.date_from)
WHERE cp.category_code IN ('111301', '114201')
	AND v1.payroll_year IN (2006,2018)
	AND v1.payroll_year in(
		SELECT v1.payroll_year
		FROM t_m_p_1 v1
		INTERSECT
		SELECT YEAR(cp.date_from)
		FROM czechia_price cp 
		)
GROUP BY 
	v1.payroll_year,	
	cp.category_code
;
