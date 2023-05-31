
/*evropska tabulka*/
CREATE OR REPLACE TABLE t_misa_peslova_project_SQL_secondary_final AS (
SELECT
	c.country,
	c.continent,
	e.year,
	e.GDP,
	e.gini,
	e.taxes
FROM countries c 
JOIN economies e 
    on c.country = e.country 
    and c.independence_date <= e.year
	and continent = 'Europe'
	AND e.YEAR BETWEEN 2006 AND 2018
GROUP BY c.country,
	c.continent,
	e.year,
	e.GDP,
	e.gini,
	e.taxes
)
;

SELECT*
FROM t_misa_peslova_project_SQL_secondary_final 
;