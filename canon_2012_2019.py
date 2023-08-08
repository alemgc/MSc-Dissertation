# Titulo: Canon 2012-2019

import os
import time

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select

options = webdriver.ChromeOptions()
options.add_argument('--start-maximized')
options.add_argument('--disable-extensions')
options.add_experimental_option('prefs', {
        "download.prompt_for_download": False,
        "download.default_directory" : r"/Users/alejandramontoya/Documents/Dissertation/2012-2019",
        "savefile.default_directory": r"/Users/alejandramontoya/Documents/Dissertation/2012-2019"})
chromedriver =  r'/Users/alejandramontoya/Desktop/chromedriver'
os.environ["webdriver.chrome.driver"] = chromedriver

driver = webdriver.Chrome(chromedriver, chrome_options=options)
driver.get('https://apps5.mineco.gob.pe/transparencia/Navegador/default.aspx')
driver.switch_to.frame(0) 

#Especificar anios
for year in range(2012,2020):
        print(year)
        #Solo hay un frame
        #driver.switch_to.frame(0) 
        seleccionar = Select(driver.find_element_by_id('ctl00_CPH1_DrpYear'))
        seleccionar.select_by_value(str(year))

        #Nivel de gobierno
        driver.switch_to.parent_frame()
        driver.switch_to.frame(0)
        driver.find_element_by_xpath('/html/body/form/div[4]/div[3]/div[1]/table/tbody/tr[2]/td[1]/input').click()

        #Especificar nivel de gobierno
        driver.switch_to.parent_frame()
        driver.switch_to.frame(0)
        driver.find_element_by_xpath("//*[contains(text(), 'LOCALES')]").click()

        #Gob.Loc/Mancon.
        driver.switch_to.parent_frame()
        driver.switch_to.frame(0)
        driver.find_element_by_xpath("/html/body/form/div[4]/div[3]/div[1]/table/tbody/tr[2]/td[1]/input[2]").click()

        #Especificar departamento
        driver.switch_to.parent_frame()
        driver.switch_to.frame(0)
        driver.find_element_by_xpath("//*[contains(text(), 'MUNICIPALIDADES')]").click()

        #Fuente
        driver.switch_to.parent_frame()
        driver.switch_to.frame(0)
        driver.find_element_by_id('ctl00_CPH1_BtnFuenteAgregada').click()

        #Especificar fuente
        driver.switch_to.parent_frame()
        driver.switch_to.frame(0)
        driver.find_element_by_xpath("//*[contains(text(), 'DETERMINADOS')]").click()

        #Rubro
        driver.switch_to.parent_frame()
        driver.switch_to.frame(0)
        driver.find_element_by_id('ctl00_CPH1_BtnRubro').click()

        #Especificar rubro
        driver.switch_to.parent_frame()
        driver.switch_to.frame(0)
        driver.find_element_by_xpath("//*[contains(text(), 'CANON')]").click()

        #Tipo de recurso
        driver.switch_to.parent_frame()
        driver.switch_to.frame(0)
        driver.find_element_by_id('ctl00_CPH1_BtnTipoRecurso').click()

        #Especificar tipo de recurso 
        driver.switch_to.parent_frame()
        driver.switch_to.frame(0)
        driver.find_element_by_xpath("//*[contains(text(), '0: CANON')]").click()

        #Departamento
        driver.switch_to.parent_frame()
        driver.switch_to.frame(0)
        driver.find_element_by_xpath("/html/body/form/div[4]/div[3]/div[1]/table/tbody/tr[2]/td[1]/input[1]").click()

        #Contabilizacion de departamentos
        driver.switch_to.parent_frame()
        driver.switch_to.frame(0)
        tabla_dpto = driver.find_element_by_xpath('/html/body/form/div[4]/div[3]/div[3]/div/table[2]') ## para toda la tabla de dpto contabilizame cada uno de ellos
        departamentos = tabla_dpto.find_elements_by_tag_name('tr')
        for dpto in range(len(departamentos)):
                print(dpto)
                driver.switch_to.parent_frame()
                driver.switch_to.frame(0)
                driver.find_element_by_id('tr' + str(dpto)).click()

                driver.switch_to.parent_frame()
                driver.switch_to.frame(0)
                driver.find_element_by_xpath('/html/body/form/div[4]/div[3]/div[1]/table/tbody/tr[2]/td[1]/input[2]').click() ##Selecciona municipalidad

                #Exportar
                driver.switch_to.parent_frame()
                driver.switch_to.frame(0)
                driver.find_element_by_id('ctl00_CPH1_lbtnExportar').click()

                #Regresar a Departamento
                driver.switch_to.parent_frame()
                driver.switch_to.frame(0)
                driver.find_element_by_xpath('/html/body/form/div[4]/div[3]/div[2]/table/tbody/tr[7]/td[1]/img').click()