/* task 2*/
/*the first period*/ -- 1st.q.2006
SELECT MIN(date_from)
FROM czechia_price cp 

;
/*the last period*/ -- 4th.q.2018
SELECT MAX (date_to)
FROM czechia_price cp 

;

SELECT 
	payroll_year, 
	food_category_code,
	ROUND(avg_price,2) AS price,
	ROUND(AVG(avg_wages),2) AS avg_wages_all_branches,
	FLOOR(avg_wages/avg(avg_price)) AS amount_in_units
FROM t_misa_peslova_project_sql_primary_final AS v1
WHERE food_category_code IN (111301, 114201)
	AND payroll_year IN (2006,2018)
GROUP BY 
	payroll_year, 
	food_category_code,
	avg_price
;
