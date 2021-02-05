library(shiny)
library(shinydashboard)
library(dashboardthemes)
library(tidyverse)
library(janitor)
library(here)

cancer_incidence <- read_csv(here("clean_data/cancer_incidence_clean.csv")) 

geo_codes <- read_csv(here("clean_data/geography_codes_and_labels_hb2014_01042019.csv")) %>% 
  clean_names()

cancer_geo <- left_join(cancer_incidence, geo_codes, by = "hb")