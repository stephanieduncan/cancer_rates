#Loading the relevant libraries
library(tidyverse)
library(janitor)
library(here)

#Link to the raw data:-
#https://www.opendata.nhs.scot/dataset/annual-cancer-incidence/resource/3aef16b7-8af6-4ce0-a90b-8a29d6870014

#Reading in the raw data and cleaning the variable names
raw_data <- read_csv(here("raw_data/cancer_incidence_health_board.csv")) %>% 
  clean_names()

#Obtaining an overview of the data
dim(raw_data)
names(raw_data)
glimpse(raw_data)

#Removing irrelevant columns
clean_data <- raw_data %>% 
  select(-cancer_site_icd10code, -sex_qf, -easr_lower95pc_confidence_interval_qf, -easr_upper95pc_confidence_interval_qf, -wasr_lower95pc_confidence_interval_qf, -wasr_upper95pc_confidence_interval_qf)

#Removing world age standard columns
clean_data <- clean_data %>% 
select(-wasr, -wasr_lower95pc_confidence_interval,
       -wasr_upper95pc_confidence_interval)

#Checking for missing values across all columns
clean_data_missing <- clean_data %>% 
  summarise(across(.fns = ~sum(is.na(.x))))

#Checking for unique names in cancer site column
unique(clean_data$cancer_site)

#Writing to csv file
write_csv(clean_data, "clean_data/cancer_incidence_clean.csv")






