### Průvodní zpráva - Michaela Pešlová ###

Projekt je finální práce Datové akademie od Engeta. Cílem tohoto projektu je odpovědět na definované otázky k problematice životní úrovně obyvatel v daném období. Výsledky vycházejí z datových sad obsahujících informace o mzdách, cenách a různých číselníků a kalkulací v rámci ČR, ale i ostatních zemí světa. 
## Zadání projektu ##
Na vašem analytickém oddělení nezávislé společnosti, která se zabývá životní úrovní občanů, jste se dohodli, že se pokusíte odpovědět na pár definovaných výzkumných otázek, které adresují dostupnost základních potravin široké veřejnosti. Kolegové již vydefinovali základní otázky, na které se pokusí odpovědět a poskytnout tuto informaci tiskovému oddělení. Toto oddělení bude výsledky prezentovat na následující konferenci zaměřené na tuto oblast.
Potřebují k tomu od vás připravit robustní datové podklady, ve kterých bude možné vidět porovnání dostupnosti potravin na základě průměrných příjmů za určité časové období.
Jako dodatečný materiál připravte i tabulku s HDP, GINI koeficientem a populací dalších evropských států ve stejném období, jako primární přehled pro ČR.
Datové sady, které je možné použít pro získání vhodného datového podkladu
### Primární tabulky: ###
1.	**czechia_payroll** – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
2.	**czechia_payroll_calculation** – Číselník kalkulací v tabulce mezd.
3.	**czechia_payroll_industry_branch** – Číselník odvětví v tabulce mezd.
4.	**czechia_payroll_unit** – Číselník jednotek hodnot v tabulce mezd.
5.	**czechia_payroll_value_type** – Číselník typů hodnot v tabulce mezd.
6.	**czechia_price** – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
7.	**czechia_price_category** – Číselník kategorií potravin, které se vyskytují v našem přehledu.
Číselníky sdílených informací o ČR:
1.	**czechia_region** – Číselník krajů České republiky dle normy CZ-NUTS 2.
2.	**czechia_district** – Číselník okresů České republiky dle normy LAU.
### Dodatečné tabulky: ###
1.	**countries** - Všemožné informace o zemích na světě, například hlavní město, měna, národní jídlo nebo průměrná výška populace.
2.	**economies** - HDP, GINI, daňová zátěž, atd. pro daný stát a rok.
### Výzkumné otázky ###
**1.	Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?**

**2.	Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?**

**3.	Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?**

**4.	Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?**

**5.	Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?**

### Výstup projektu ###
Pomozte kolegům s daným úkolem. Výstupem by měly být dvě tabulky v databázi, ze kterých se požadovaná data dají získat. Tabulky pojmenujte **t_{jmeno}_{prijmeni}_project_SQL_primary_final** (pro data mezd a cen potravin za Českou republiku sjednocených na totožné porovnatelné období – společné roky) a **t_{jmeno}_{prijmeni}_project_SQL_secondary_final** (pro dodatečná data o dalších evropských státech).
Dále připravte sadu SQL, které z vámi připravených tabulek získají datový podklad k odpovězení na vytyčené výzkumné otázky. Pozor, otázky/hypotézy mohou vaše výstupy podporovat i vyvracet! Záleží na tom, co říkají data.

## Popis projektu ##
 
### Tvorba Primary table (t_misa_peslova_project_SQL_primary_final) ###
Jelikož podkladů a dat bylo velké množství, bylo nejprve nutné vytvořit primární tabulku, do které jsem vybrala nejdůležitější relevantní údaje, které k zodpovězení otázek potřebujeme. Primární tabulku jsem vytvořila spojením tabulky **„Czechia price“** a **„Czechia payroll“**, které jsem ihned použitím podmínek (filtrace relevantních kategorií) redukovala. Následně jsem připojila tabulky **„Czechia price category“**, **„Czechia payroll industry branch“** a **„Czechia payroll value type“**. Poslední zmíněnou tabulku jsem opět redukovala výběrem relevantních kategorií. Odstranila jsem prázdné hodnoty a vypsala jsem pouze sloupce „payroll_year“, „payroll_quarter“, „avg_wages“, „industry_branch_code“, „food_category_code“ a „avg_price“. Takto upravená data jsou dostačující pro první čtyři otázky. 
### Tvorba Secondary table (t_misa_peslova_project_SQL_secondary_final) ###
Pro zodpovězení poslední otázky pouze primární tabulka nestačí, proto bylo nutné vytvořit tabulku sekundární, obsahující světová ekonomická a demografická data. To jsem provedla spojením tabulky **„Countries“** a **„Economies“**, kde jsem si zároveň vyfiltrovala pouze evropské státy a období srovnatelné s obdobím z otázek 1-4. Vypsala jsem opět pouze relevantní údaje „country“, „continent“, „year“, „GDP“, „gini“ a „taxes“. 
Z takto vytvořených tabulek jsem vycházela pro zodpovězení následujících otázek. 

**1.	Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?**

Pro přehled nárůstů mezd nám pomůže spočítat meziroční nárůst. To nejlépe udělám spojením primární tabulky s její duplicitní variantou, avšak spojení přes „payroll_year“ vytvořím o jeden rok posunuté, abych získala přehled pro předchozí roky. Ve výsledné tabulce, kde jsou jednotlivé kategorie napříč roky, lze vidět, že **mzdy celkově rostou, nejvyšší nárůst (4,86 %) byl za daná léta v kategorii „Q“, tedy Zdravotní a sociální péči.** 
Pokud bychom chtěli zjistit nárůst/pokles v kategoriích za jednotlivé roky, můžeme si spustit pouze subselect, kde ve sloupečku „growth“ vidíme buď nárůst nebo v záporných hodnotách pokles. 

**2.	Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?**

V první řadě jsem si zjistila, o jaká období se vlastně jedná, tedy jsem našla minimální a maximální hodnotu ze sloupce „date_from“, resp. „date_to“. Vybrala jsem také pouze kategorie **111301** a **114201** pro chléb a mléko, které nás pro tento úkol zajímají. Podílem mzdy a ceny jsem zjistila počet v daných jednotkách. V prvním období, tedy v roce **2006** by bylo možné si ze mzdy koupit **1261 kg chleba** nebo **1408 litrů mléka**. V roce **2018**, posledním období, bylo možné koupit si **1319 kg chleba** nebo **1613 litrů mléka**.

**3.	Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?**

Spojením primární tabulky s duplicitní primární tabulkou si opět zjistíme meziroční nárůst cen pro jednotlivé kategorie. Hledáme kategorii, která se v průběhu let zdražuje, vyloučíme tedy záporné hodnoty (zlevňování). Nastavením intervalu od 0 do 1 si vyfiltruji jen kategorie s opravdu nejnižším nárůstem a seřazením podle sloupečku „growth“ a omezením výběru na jednu hodnotu získáme výslednou kategorii. **Nejpomaleji tedy zdražuje kategorie 115201, tedy Rostlinný roztíratelný tuk s meziročním nárůstem 0,01 %**. 

**4.	Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?**

Nejprve jsem opět musela zjistit meziroční nárůsty mezd a cen potravin spojením primárních tabulek přes rok s jednoročním posunutím. Následné odečtení těchto nárůstů nám ukazuje, ze **největší rozdíl nastal v roce 2013, s hodnotou 6,66 %**.

**5.	Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?**

V tomto bodě došlo ke spojení primární a sekundární tabulky. Z té sekundární jsem zjistila meziroční nárůst HDP v České republice a z primární opět nárůsty cen a mezd. Jejich sloučením jsem získala srovnávací přehled. Z toho vyplývá, že **výraznější narůst HDP, přes 5 % nastal v letech 2007, 2015 a 2017**. **V letech 2007 a 2017 nastal i výraznější narůst cen a mezd v témže roce i v roce následujícím**. **V roce 2015 nebo následujícím roce se zvýšení HDP promítlo pouze do menšího nárůstu mezd (2,42 – 3,66 %), zatímco ceny potravin spíše poklesly.**



