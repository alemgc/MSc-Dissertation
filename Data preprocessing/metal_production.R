              #####################################################
              
              #       METAL PRODUCTION IN PERU 2008-2019          #
              
              #####################################################

# In this script I systematize the mining production information. 
# The aim is to build a dataset that contains the annual production in USD of the main matals in Peru between 2008 and 2019, 
# which are iron, copper, lead, tin, zinc, gold and silver. 

# Load the necessary libraries

library('readxl')
library('haven')

# Set the directory
              
data_dir <- "/Users/alejandramontoya/Library/CloudStorage/GoogleDrive-montoya.a@pucp.edu.pe/Mi unidad/MSc Development Studies and Policy - Manchester/Dissertation/Data"

#################################
## 1. METALS - COMPILED DATASETS
#################################

# In this part, I compile the multiple excel files that were download from the Ministry of Energy's webpage.
# Each file shows the information of the monthly production of one metal in one year by mining company.
# The aim is to generate a joint database the contains the annual production (in quantities) of the metals for all the years of analysis.

# Define the metals that are produced in each year or set of years

metals2008 <- c("CADMIO", "COBRE", "ESTA", "HIERRO", "MOLIBDENO", "ORO", "PLATA", "PLOMO", "ZINC")
metals2009_2015 <- c("CADMIO", "COBRE", "ESTA", "HIERRO", "MOLIBDENO", "ORO", "PLATA", "PLOMO", "ZINC", "TUNGSTENO")
metals2016_2017 <- c("BISMUTO", "ARSENICO", "CADMIO", "COBRE", "ESTA", "HIERRO", "MOLIBDENO", "ORO", "PLATA", "PLOMO", "ZINC", "TUNGSTENO")
metals2018_2019 <- c("BISMUTO", "ARSENICO", "CADMIO", "COBRE", "ESTA", "HIERRO", "MOLIBDENO", "ORO", "PLATA", "PLOMO", "ZINC")

# Define the column names of the datasets

column_names  <- c("Ley", "Stage", "Process", "Class", "Name_Titular", "Unit", 
                   "Region", "Province", "District", "Jan", "Feb", "Mar", "Apr", 
                   "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec", "Total")

# Define the column names that are meant to be numeric

numeric_var <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec", "Total", "year")

# In the following lines I dynamically generate data frames for each combination of metal-year. As each year has different metals included,
# I do this for each group of years that include the same metals (which are specified in the lists above)

# 1) metals in 2008

variable_names_2008 <- list()
 
for (metal in metals2008) {
  
  var_name <- paste(metal,"2008", sep = "")
  file_path <- file.path(data_dir, "MINING", "2008", paste0(metal, ".XLS"))
  data <- readxl::read_excel(file_path)
  colnames(data) <- column_names
  data <- subset(data, grepl("Oro|Plata|%", Ley))
  data$year <- 2008
  data[numeric_var] <- lapply(data[numeric_var], as.numeric)
  assign(var_name,data)
  variable_names_2008 <- c(variable_names_2008,var_name)
  
}

# 2) metals in 2009-2010

years <- 2009:2010
variable_names_2009_2010 <- list()

for (j in years) {
  
  for (metal in metals2009_2015) {
    
    var_name <- paste(metal, j, sep = "")
    file_path <- file.path(data_dir, "MINING", j, paste0(metal, ".XLS"))
    data <- readxl::read_excel(file_path)
    colnames(data) <- column_names
    data <- subset(data, grepl("Oro|Plata|%", Ley))
    data$year <- j
    data[numeric_var] <- lapply(data[numeric_var], as.numeric)
    assign(var_name,data)
    variable_names_2009_2010 <- c(variable_names_2009_2010,var_name)
    
  }
  
}

# 3) metals in 2011-2015

years <- 2011:2015
variable_names_2011_2015 <- list()

for (j in years) {
  
  for (metal in metals2009_2015) {
    
    var_name <- paste(metal, j, sep = "")
    file_path <- file.path(data_dir, "MINING", j, paste0(metal, ".xlsx"))
    data <- readxl::read_excel(file_path)
    colnames(data) <- column_names
    data <- subset(data, grepl("Oro|Plata|%", Ley))
    data$year <- j
    data[numeric_var] <- lapply(data[numeric_var], as.numeric)
    assign(var_name,data)
    variable_names_2011_2015 <- c(variable_names_2011_2015,var_name)
    
  }
  
}

# 4) metals in 2016-2017

years <- 2016:2017
variable_names_2016_2017 <- list()

for (j in years) {
  
  for (metal in metals2016_2017) {
    
    var_name <- paste(metal, j, sep = "")
    file_path <- file.path(data_dir, "MINING", j, paste0(metal, ".xlsx"))
    data <- readxl::read_excel(file_path)
    colnames(data) <- column_names
    data <- subset(data, grepl("Oro|Plata|%", Ley))
    data$year <- j
    data[numeric_var] <- lapply(data[numeric_var], as.numeric)
    assign(var_name,data)
    variable_names_2016_2017 <- c(variable_names_2016_2017,var_name)
    
  }
  
}

# 4) metals in 2018-2019

years <- 2018:2019
variable_names_2018_2019 <- list()

for (j in years) {
  
  for (metal in metals2018_2019) {
    
    var_name <- paste(metal, j, sep = "")
    file_path <- file.path(data_dir, "MINING", j, paste0(metal, ".xlsx"))
    data <- readxl::read_excel(file_path)
    colnames(data) <- column_names
    data <- subset(data, grepl("Oro|Plata|%", Ley))
    data$year <- j
    data[numeric_var] <- lapply(data[numeric_var], as.numeric)
    assign(var_name,data)
    variable_names_2018_2019 <- c(variable_names_2018_2019,var_name)
    
  }
  
}

# NOW WE APPEND THE DATASETS

## Append 2008 data

data_2008 <- data.frame()

for (var_name in variable_names_2008) {
  
  metal_data <- get(var_name)
  data_2008 <- rbind(data_2008,metal_data)
  
}

## Append 2009-2015 data

data_2009_2015 <- data.frame()

for (var_name in variable_names_2009_2010) {
  
  metal_data <- get(var_name)
  data_2009_2015 <- rbind(data_2009_2015,metal_data)
  
}

## Append 2016-2017 data

data_2016_2017 <- data.frame()

for (var_name in variable_names_2016_2017) {
  
  metal_data <- get(var_name)
  data_2016_2017 <- rbind(data_2016_2017,metal_data)
  
}

## Append 2018-2019 data

data_2018_2019 <- data.frame()

for (var_name in variable_names_2018_2019) {
  
  metal_data <- get(var_name)
  data_2018_2019 <- rbind(data_2018_2019,metal_data)
  
}

## Append the whole

metals_data <- rbind(data_2008, data_2009_2015, data_2016_2017, data_2018_2019)
saveRDS(compilado_metales, file.path(data_dir, "MINING", "COMPILADO", paste0("METALS_PERU.rds")))

#####################
# 2. PRICES
#####################

prices_excel <- "/Users/alejandramontoya/Library/CloudStorage/GoogleDrive-montoya.a@pucp.edu.pe/Mi unidad/MSc Development Studies and Policy - Manchester/Dissertation/Data/CMO-Historical-Data-Annual.xlsx"
prices_data <- read_excel(prices_excel, sheet = "Annual Prices (Real)", range = "A9:BW86")
colnames(prices_data)[colnames(prices_data) == "...1"] <- "year"
prices_data <- subset(prices_data, select = -c(year, KIRON_ORE, KCOPPER, KLEAD, KTin, KZinc, KGOLD, KSILVER))
prices_data <- subset(prices_data, !is.na(year))

prices_data$KGOLD_gr <- prices_data$KGOLD / 31.1034768
prices_data$KSILVER_kg <- prices_data$KSILVER / 0.03110348

#################################
# 3. PRODUCTION (QUANT) + PRICES
#################################

library(dplyr)

metals_data <- subset(metals_data, select = -c(Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sept, Oct, Nov, Dec))
colnames(metals_data)[colnames(metals_data) == "Ley"] <- "Product"
metals_clean <- aggregate(Total ~ Region + Province + District + Product + year, metals_data, sum)

# Merge the data frames by the 'year' variable
metal_production <- merge(metals_clean, prices_data, by = "year", all.x = TRUE)
metal_production <- filter(metal_production, !is.na(Region)) 

metal_production <- metal_production %>%
  mutate(TotalProdUSD = case_when(
    Product == "%Hierro" ~ Total * KIRON_ORE,
    Product == "%Cobre" ~ Total * KCOPPER,
    Product == "%Plomo" ~ Total * KLEAD,
    Product == "%Estaño" ~ Total * KTin,
    Product == "%Zinc" ~ Total * KZinc,
    Product == "Oro" ~ Total * KGOLD_gr,
    Product == "Plata" ~ Total * KSILVER_kg,
    TRUE ~ NA_real_ 
  ))

metal_production <- filter(metal_production, !is.na(TotalProdUSD)) 





