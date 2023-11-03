
cd "/Users/alejandramontoya/Documents/Dissertation/2008-2011/"

forvalues i=1(1)100 {

    import excel "Archivo `i'.xlsx", sheet("Sheet1") clear

    gen tmp_region = A if _n==11
    replace tmp_region = substr(tmp_region,14,2)
    destring tmp_region, replace

    gen tmp_year = A if _n==4
    replace tmp_year = substr(tmp_year,21,4)
    destring tmp_year, replace

    gen uno=1

    bys uno: egen region= max(tmp_region)
    bys uno: egen year= max(tmp_year)

    drop uno
    drop tmp*

    rename A Municipality
    rename B PIA
    rename C PIM
    rename D Commitment
    rename E Devengado
    rename F Girado
    rename G Progress

    drop if _n<=13

    destring PIA PIM Commitment Devengado Girado Progress, replace

    save "dta/Archivo `i'.dta", replace
}

use "dta/Archivo 1.dta", clear
append using "dta/Archivo 2.dta"
save data2008_2011, replace

forvalues i=3(1)100 {
	
	use data2008_2011, clear 
	append using "dta/Archivo `i'.dta"
	save data2008_2011, replace

}

keep Municipality PIA Devengado region year
save data2008_2011, replace


cd "/Users/alejandramontoya/Documents/Dissertation/2012-2019/"

forvalues i=1(1)200 {

    import excel "Archivo `i'.xlsx", sheet("Sheet1") clear

    gen tmp_region = A if _n==12
    replace tmp_region = substr(tmp_region,14,2)
    destring tmp_region, replace

    gen tmp_year = A if _n==4
    replace tmp_year = substr(tmp_year,21,4)
    destring tmp_year, replace

    gen uno=1

    bys uno: egen region= max(tmp_region)
    bys uno: egen year= max(tmp_year)

    drop uno
    drop tmp*

    rename A Municipality
    rename B PIA
    rename C PIM
    rename D Certification
	rename E Commitment
    rename F Atencion
    rename G Devengado
    rename H Girado
	rename I Progress

    drop if _n<=14

    destring PIA PIM Certification Commitment Atencion Devengado Girado Progress, replace

    save "dta/Archivo `i'.dta", replace
}

use "dta/Archivo 1.dta", clear
append using "dta/Archivo 2.dta"
save data2012_2019, replace

forvalues i=3(1)200 {
	
	use data2012_2019, clear 
	append using "dta/Archivo `i'.dta"
	save data2012_2019, replace

}

keep Municipality PIA Devengado region year
save data2012_2019, replace

cd "/Users/alejandramontoya/Documents/Dissertation"

use "2008-2011/data2008_2011.dta", clear
append using "2012-2019/data2012_2019.dta"
gen ubigeo = substr(Municipality,1,6)
save "/Users/alejandramontoya/Library/CloudStorage/GoogleDrive-montoya.a@pucp.edu.pe/Mi unidad/MSc Development Studies and Policy - Manchester/Dissertation/Data/canon.dta", replace


levelsof ubigeo, local(ubigeo)

}