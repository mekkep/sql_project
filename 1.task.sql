/*task 1*/
SELECT 
	industry_branch_code,
	ROUND(AVG(growth),2)
FROM (
	SELECT 
		v1.payroll_year,
		v1.industry_branch_code,
		ROUND(v1.avg_wages,2) AS avg_wages,
		ROUND(AVG(v2.avg_wages),2) AS wages_prev,
		ROUND(((AVG(v1.avg_wages)-AVG(v2.avg_wages))/AVG(v2.avg_wages))*100,2) AS growth
	FROM t_misa_peslova_project_sql_primary_final AS v1
	JOIN t_misa_peslova_project_sql_primary_final AS v2
		ON v1.payroll_year = v2.payroll_year+1
		AND v1.industry_branch_code = v2.industry_branch_code
	GROUP BY 
		v1.payroll_year,
		v1.industry_branch_code	
	) a
GROUP BY industry_branch_code
;
/*subselect only - preview*/
SELECT 
	v1.payroll_year,
	v1.industry_branch_code,
	ROUND(v1.avg_wages,2) AS avg_wages,
	ROUND(AVG(v2.avg_wages),2) AS wages_prev,
	ROUND(((AVG(v1.avg_wages)-AVG(v2.avg_wages))/AVG(v2.avg_wages))*100,2) AS growth
FROM t_misa_peslova_project_sql_primary_final AS v1
JOIN t_misa_peslova_project_sql_primary_final AS v2
	ON v1.payroll_year = v2.payroll_year+1
	AND v1.industry_branch_code = v2.industry_branch_code
GROUP BY 
	v1.payroll_year,
	v1.industry_branch_code	
;
