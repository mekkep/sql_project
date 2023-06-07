CREATE OR REPLACE TABLE t_misa_peslova_project_SQL_primary_final AS (
SELECT
	 	cpay.payroll_year, 
	 	cpay.payroll_quarter,
	 	AVG(cpay.value) AS avg_wages,
	  	cpay.industry_branch_code,
	  	cpc.code AS food_category_code,
	  	ROUND(AVG(cp.value),2) AS avg_price
FROM czechia_price AS cp
JOIN czechia_payroll AS cpay
	ON YEAR(cp.date_from) = cpay.payroll_year 
	AND cpay.value_type_code = 5958 
	AND cp.region_code IS NULL
	AND cpay.unit_code = 200
JOIN czechia_price_category cpc 
	ON cp.category_code = cpc.code
JOIN czechia_payroll_industry_branch cpib
	ON cpay.industry_branch_code = cpib.code
JOIN czechia_payroll_value_type a
    ON value_type_code=a.code
    AND cpay.value_type_code = 5958
    AND cpay.calculation_code = 100 
WHERE cpay.value IS NOT NULL 
GROUP BY 
	cpay.payroll_year, 
	cpay.payroll_quarter,
	cpay.industry_branch_code,
	food_category_code 
)  	
;
SELECT *
FROM t_misa_peslova_project_SQL_primary_final 
;
