clear
clear all
set more off

* In this dofile, I intend to merge the multiple subsets that the Peruvian National household survey contains per year and generate the relevant variables for my dissertation. In particular, I obtain the education and employment variables from here to then construct the outcomes I will include in my regressions. 

* Set the directories

global user "/Users/alejandramontoya/Library/CloudStorage/GoogleDrive-montoya.a@pucp.edu.pe/Mi unidad/"

global enaho "$user/Bases de datos/ENAHO"
global dissertation "$user/MSc Development Studies and Policy - Manchester/Dissertation/"

global data "$dissertation/Data"

cd "$data"

*	MERGE OF THE PERUVIAN NATIONAL HOUSEHOLD SURVEYS 
*  ==================================================

use "$enaho/ubigeos.dta", clear
gen ubigeo = UBIGEO1+ UBIGEO2+ UBIGEO3
tempfile ubigeo
save `ubigeo'

merge m:1 ubigeo using `ubigeo'

forvalues i=2008(1)2021 {

	use "$enaho/`i'/Modulo34/sumaria-`i'.dta", clear
	
	* Define expenditure and income per capita quantiles in one of the data subsets (sumaria)

	gen gasto_pc = gashog2d/mieperho
	gen ingreso_pc = inghog2d/mieperho

	xtile gastopc_d = gasto_pc, nq(10)
	xtile ingresopc_d = ingreso_pc, nq(10)

	xtile gastopc_q = gasto_pc, nq(5)
	xtile ingresopc_q = ingreso_pc, nq(5)

	xtile ingreso_d = inghog2d, nq(10)

	save sumaria_`i'_tmp, replace
	
	* Merge all the data subsets to generate an compiled dataframe. These subsets contain each information of personal characteristics of the members of the household and information of health, education and employment 
	
	use "$enaho/`i'/Modulo01/enaho01-`i'-100.dta", clear
	merge m:1 conglome vivienda hogar using sumaria_`i'_tmp
	drop _merge 

	merge 1:m conglome vivienda hogar using "$enaho/`i'/Modulo02/enaho01-`i'-200.dta"
	drop _merge

	merge 1:1 conglome vivienda hogar codperso using "$enaho/`i'/Modulo03/enaho01a-`i'-300.dta"
	drop _merge

	merge 1:1 conglome vivienda hogar codperso using "$enaho/`i'/Modulo05/enaho01a-`i'-500.dta"
	drop _merge

	merge m:1 ubigeo using `ubigeo'
	drop if _merge==2
	replace NOMBRE1="Junín" if ubigeo=="120699"
	drop _merge
	rename NOMBRE1 region
	rename NOMBRE2 provincia
	rename NOMBRE3 distrito

	foreach var of varlist region provincia distrito {
		
		replace `var' = strrtrim(`var')
		replace `var' = strltrim(`var')

	}
	
	* Generation of additional variables 
	
	replace region = "Lima Metropolitana" if provincia=="Lima" & region=="Lima"
	gen rural = ((estrato == 6 | estrato == 7 | estrato == 8) & !missing(estrato))

	gen gestion = 1 if p301d ==1 // pública
	replace gestion = 0 if p301d ==2
	
	gen lengua = "CASTELLANO" if p300a==4
	replace lengua = "LENGUAS ORIGINARIAS" if (p300a>=1 & p300a<=3) | (p300a>=10 & p300a<=15)
	
	gen year = `i'
	
	save enaho_`i', replace

}

* Merging all

forvalues i=2008(1)2021 {

use enaho_`i', clear
destring *, replace
save enaho_`i', replace

}

use enaho_2011, clear
replace latitud = subinstr(latitud,"*","",.) 
destring latitud, replace
save enaho_2011, replace

use enaho_2016, clear
replace p110i = subinstr(p110i,"*","",.) 
destring p110i, replace
save enaho_2016, replace

use enaho_2008, clear
append using enaho_2009
save enaho_append, replace

forvalues i=2010(1)2021 {

use enaho_append, clear
append using enaho_`i'
save enaho_append, replace

}

compress 
save enaho_append, replace

