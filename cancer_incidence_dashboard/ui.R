library(shiny)
library(shinydashboard)
library(dashboardthemes)
library(tidyverse)
library(janitor)
library(here)

source("global.R")


ui <- dashboardPage(
    
    dashboardHeader(title = "Cancer Incidence"),
    ## Sidebar content
    dashboardSidebar(
        sidebarMenu(
            menuItem("Temporal", tabName = "cancer_incidence_area"),
            menuItem("Cancer Sites", tabName = "cancer_site_tab"),
            menuItem("Crude Rates", tabName = "crude_rate_tab"),
            menuItem("About", tabName = "about")
        )
    ),
    
    ## Body content
    dashboardBody(
        shinyDashboardThemes(theme = "blue_gradient"),
        tabItems(
            # First tab content
            tabItem(tabName = "cancer_incidence_area",
                    h2("Cancer Incidence"),
                    
                    fluidRow(
                        box(width = 12,
                            background = "light-blue",
                            column(width = 6, 
                                   selectInput(inputId = "hb_name",
                                               label = "Area",
                                               choices = sort(unique(cancer_geo$hb_name)),
                                               selected = "NHS Ayrshire and Arran"
                                   )
                            ),
                        
                            column(width = 6, 
                                   align = "center",
                                   radioButtons(inputId = "sex",
                                                label = "Sex",
                                                choices = unique(cancer_geo$sex),
                                                selected = "All",
                                                inline = TRUE) 
                            )
                        )
                    ),
                        
                    fluidRow(
                        
                        box(
                            title = "By Area & Gender", 
                            solidHeader = TRUE,
                            status = "primary",
                            plotOutput("incidence_output", height = 250)
                        )
                    )
                    ), 
                        
            
            # Second tab - Cancer site content
            tabItem(tabName = "cancer_site_tab",
                    h2("Cancer Incidence"),
                    
                    fluidRow(
                        box(width = 12,
                            background = "light-blue",
                            column(width = 6, 
                                   selectInput(inputId = "hb_name_two",
                                               label = "Area",
                                               choices = sort(unique(cancer_geo$hb_name)),
                                               selected = "NHS Ayrshire and Arran")
                            ),
                            
                            column(width = 6, 
                                   align = "center",
                                   selectInput(inputId = "cancer_site_two",
                                               label = "Cancer Site",
                                               choices = unique(cancer_geo$cancer_site),
                                               selected = "All cancer types") 
                                   
                            ),
                            
                            column(width = 6, 
                                   align = "center",
                                   radioButtons(inputId = "sex_two",
                                                label = "Sex",
                                                choices = unique(cancer_geo$sex),
                                                selected = "All",
                                                inline = TRUE) 
                            )
                        )
                    ),
                    
                    fluidRow(
                        
                        box(
                            title = "By Cancer Site & Gender", 
                            solidHeader = TRUE,
                            status = "primary",
                            plotOutput("site_output", height = 250)
                        )
                    )
            ), 
            
            
            # Third tab - Crude rate content
            tabItem(tabName = "crude_rate_tab",
                    h2("Crude Rates"),
                    
                    fluidRow(
                        box(width = 12,
                            background = "light-blue",
                            column(width = 6, 
                                   selectInput(inputId = "hb_name_three",
                                               label = "Area",
                                               choices = sort(unique(cancer_geo$hb_name)),
                                               selected = "NHS Ayrshire and Arran")
                            ),
                            
                            column(width = 6, 
                                   align = "center",
                                   selectInput(inputId = "cancer_site_three",
                                               label = "Cancer Site",
                                               choices = unique(cancer_geo$cancer_site),
                                               selected = "All cancer types") 
                                   
                            ),
                            
                            column(width = 6, 
                                   align = "center",
                                   radioButtons(inputId = "sex_three",
                                                label = "Sex",
                                                choices = unique(cancer_geo$sex),
                                                selected = "All",
                                                inline = TRUE) 
                            )
                        )
                    ),
                    
                    fluidRow(
                        
                        box(
                            title = "Crude Rates by Area & Gender", 
                            solidHeader = TRUE,
                            status = "primary",
                            plotOutput("crude_rate_output", height = 250)
                        )
                    )
            ), 
            
            
            
            # About tab content
            tabItem(tabName = "about",
                    h1("About"),
                    fluidRow(
                        box(title = "Data Sources", solidHeader = TRUE, status = "primary",
                            h5(strong("NHS Scotland")),
                            
                            tags$a(href="https://www.opendata.nhs.scot/dataset/annual-cancer-incidence", 
                                   "Cancer Incidence Data"),
                            br(),
                            tags$a(href="https://www.opendata.nhs.scot/dataset/9f942fdb-e59e-44f5-b534-d6e17229cc7b/resource/652ff726-e676-4a20-abda-435b98dd7bdc/download/geography_codes_and_labels_hb2014_01042019.csv", 
                                   "Geography Health Board Labels Lookup")
                    )
                    )
            )
        )
    )
)