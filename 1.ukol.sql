/*priklad 1*/
;
CREATE OR REPLACE TABLE t_m_p_1 AS (
SELECT
        cpay.id,
        cpay.payroll_year,
        cpay.payroll_quarter,
        c.name AS Industry_branch,
        cpay.value AS average_wages,
        b.name AS currency,
        d.name AS 'F/P',
        c.code
FROM czechia_payroll cpay
JOIN czechia_payroll_value_type a
     ON value_type_code=a.code
     AND cpay.value_type_code = 5958
     AND cpay.calculation_code = 100 
JOIN czechia_payroll_unit b 
     ON cpay.unit_code=b.code
JOIN czechia_payroll_industry_branch c
     ON cpay.industry_branch_code=c.code
JOIN czechia_payroll_calculation d 
     ON cpay.calculation_code=d.code
GROUP BY c.code,cpay.payroll_year)

;
SELECT*
FROM t_m_p_1
;

SELECT 
		v2.payroll_year AS year_previous,
		v1.payroll_year,
		v1.code,
		v2.average_wages AS avg_wages_prev,
		v1.average_wages AS avg_wages,
			CASE 
			WHEN (v2.average_wages - v1.average_wages) < 0 THEN 1 
			ELSE 0
		END AS '1 narust/0 pokles'
FROM t_m_p_1 AS v1
JOIN t_m_p_1 AS v2
	ON v1.payroll_year = v2.payroll_year+1
	AND v1.code = v2.code
;