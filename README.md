# sql_project
my sql project preview

Popis projektu

Projekt je finální práce Datové akademie od Engeta. Cílem tohoto projektu je odpovědět na definované otázky k problematice životní úrovně obyvatel v daném období. Výsledky vycházejí z datových sad obsahujících informace o mzdách, cenách a různých číselníků a kalkulací v rámci ČR, ale i ostatních zemí světa.  

Tvorba primární tabulky (t_misa_peslova_project_SQL_primary_final)

Jelikož podkladů a dat bylo velké množství, bylo nejprve nutné vytvořit primární tabulku, do které jsem vybrala nejdůležitější relevantní údaje, které k zodpovězení otázek potřebujeme. Primární tabulku jsem vytvořila spojením tabulky „Czechia price“ a „Czechia payroll“, které jsem ihned použitím podmínek (filtrace relevantních kategorií) redukovala. Následně jsem připojila tabulky „Czechia price category“, „Czechia payroll industry branch“ a „Czechia payroll value type“. Poslední zmíněnou tabulku jsem opět redukovala výběrem relevantních kategorií. Odstranila jsem prázdné hodnoty a vypsala jsem pouze sloupce „payroll_year“, „payroll_quarter“, „avg_wages“, „industry_branch_code“, „food_category_code“ a „avg_price“. 
Takto upravená data jsou dostačující pro první čtyři otázky. 

Tvorba sekundární tabulky (t_misa_peslova_project_SQL_secondary_final)

Pro zodpovězení poslední otázky pouze primární tabulka nestačí, proto bylo nutné vytvořit tabulku sekundární, obsahující světová ekonomická a demografická data. To jsem provedla spojením tabulky „Countries“ a „Economies“, kde jsem si zároveň vyfiltrovala pouze evropské státy a období srovnatelné s obdobím z otázek 1-4. Vypsala jsem opět pouze relevantní údaje „country“, „continent“, „year“, „GDP“, „gini“ a „taxes“.
Z takto vytvořených tabulek jsem vycházela pro zodpovězení následujících otázek. 

1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

Pro přehled nárůstů mezd nám pomůže spočítat meziroční nárůst. To nejlépe udělám spojením primární tabulky s její duplicitní variantou, avšak spojení přes „payroll_year“ vytvořím o jeden rok posunuté, abych získala přehled pro předchozí roky. Ve výsledné tabulce, kde jsou jednotlivé kategorie napříč roky, lze vidět, že mzdy celkově rostou, nejvyšší nárůst (4,86 %) byl za daná léta v kategorii „Q“, tedy Zdravotní a sociální péči. 
Pokud bychom chtěli zjistit nárůst/pokles v kategoriích za jednotlivé roky, můžeme si spustit pouze subselect, kde ve sloupečku „growth“ vidíme buď nárůst nebo v záporných hodnotách pokles. 
  
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

V první řadě jsem si zjistila, o jaká období se vlastně jedná, tedy jsem našla minimální a maximální hodnotu ze sloupce „date_from“, resp. „date_to“. 
Vybrala jsem také pouze kategorie 111301 a 114201 pro chléb a mléko, které nás pro tento úkol zajímají. Podílem mzdy a ceny jsem spočítala počet v daných jednotkách. 		
V prvním období, tedy v roce 2006 by bylo možné si ze mzdy koupit 778 kg chleba nebo 868 litru mléka. V roce 2018, posledním období, bylo možné koupit si 921 kg chleba nebo 1127 litru mléka.

3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

Spojením primární tabulky s duplicitní primární tabulkou si opět zjistíme meziroční nárůst cen pro jednotlivé kategorie. Hledám kategorii, která se v průběhu let zdražuje, vyloučila jsem tedy záporné hodnoty (zlevňování). Nastavením intervalu od 0 do 1 jsem vyfiltrovala jen kategorie s opravdu nejnižším nárůstem a seřazením podle sloupečku „growth“ a omezením výběru na jednu hodnotu jsem získala výslednou kategorii.
 Nejpomaleji tedy zdražuje kategorie 116103, tedy Banány žluté s meziročním nárůstem 0,56 %. 

4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

Nejprve jsem opět zjistila meziroční nárůsty mezd a cen potravin spojením primárních tabulek přes rok s jednoročním posunutím. 
Následné odečtení těchto nárůstů nám ukazuje, ze největší rozdíl nastal v roce 2013, s hodnotou 6,66 %.

5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

V tomto bodě došlo ke spojení primární a sekundární tabulky. Z té sekundární jsem zjistila meziroční nárůst HDP v České republice a z primární opět nárůsty cen a mezd. Jejich sloučením jsem dostala srovnávací přehled. 
Z toho vyplývá, že výraznější narůst HDP, přes 5 % nastal v letech 2007, 2015 a 2017. V letech 2007 a 2017 nastal i výraznější narůst cen a mezd v témže roce i v roce následujícím. V roce 2015 nebo následujícím roce se zvýšení HDP promítlo pouze do menšího nárůstu mezd (2,42 – 3,66 %), zatímco ceny potravin spíše poklesly. 




