library(shiny)
library(shinydashboard)
library(dashboardthemes)
library(tidyverse)
library(janitor)
library(here)
library(rsconnect)

source("global.R")


ui <- dashboardPage(
    
    dashboardHeader(title = "Cancer Incidence"),
    ## Sidebar content
    dashboardSidebar(
        sidebarMenu(
            menuItem("Temporal", tabName = "cancer_incidence_area"),
            menuItem("Cancer Sites", tabName = "cancer_site_tab"),
            menuItem("Crude Rates", tabName = "crude_rate_tab"),
            menuItem("Most Prevalent", tabName = "prevalent_tab"),
            menuItem("About", tabName = "about")
        )
    ),
    
    ## Body content
    dashboardBody(
        shinyDashboardThemes(theme = "blue_gradient"),
        tabItems(
            # First tab content
            tabItem(tabName = "cancer_incidence_area",
                    h2("Overview of Cancer Incidence in Scotland"),
                    
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
                                                label = "Gender",
                                                choices = unique(cancer_geo$sex),
                                                selected = "All",
                                                inline = TRUE) 
                            )
                        )
                    ),
                        
                    fluidRow(
                        
                        box(
                            title = "Cancer Incidence by Area & Gender", 
                            solidHeader = TRUE,
                            status = "primary",
                            plotOutput("incidence_output", height = 250)
                        )
                    )
                    ), 
                        
            
            # Second tab - Cancer site content
            tabItem(tabName = "cancer_site_tab",
                    h2("Cancer Sites"),
                    
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
                                                label = "Gender",
                                                choices = unique(cancer_geo$sex),
                                                selected = "All",
                                                inline = TRUE) 
                            )
                        )
                    ),
                    
                    fluidRow(
                        
                        box(
                            title = "Cancer Incidence by Cancer Site, Area & Gender", 
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
                                                label = "Gender",
                                                choices = unique(cancer_geo$sex),
                                                selected = "All",
                                                inline = TRUE) 
                            )
                        )
                    ),
                    
                    fluidRow(
                        
                        box(
                            title = "Crude Rates by Cancer Site, Area & Gender", 
                            solidHeader = TRUE,
                            status = "primary",
                            plotOutput("crude_rate_output", height = 250)
                        )
                    )
            ), 
            
            
            # Fourth tab - Most prevalent cancer sites
            tabItem(tabName = "prevalent_tab",
                    h2("Most Prevalent Cancer Sites"),
                    
                    fluidRow(
                        box(width = 12,
                            background = "light-blue",
                            column(width = 6, 
                                   selectInput(inputId = "hb_name_four",
                                               label = "Area",
                                               choices = sort(unique(cancer_geo$hb_name)),
                                               selected = "NHS Ayrshire and Arran")
                            ),
                            
                            
                            column(width = 6, 
                                   align = "center",
                                   radioButtons(inputId = "sex_four",
                                                label = "Gender",
                                                choices = unique(cancer_geo$sex),
                                                selected = "All",
                                                inline = TRUE) 
                            )
                        )
                    ),
                    
                    fluidRow(
                        
                        box(
                            title = "Most Prevalent Cancer Site by Area & Gender", 
                            solidHeader = TRUE,
                            status = "primary",
                            plotOutput("prevalent_output", height = 350)
                        )
                    )
            ), 
            
            
            # About tab content
            tabItem(tabName = "about",
                    h1("About"),
                    h3("Author:", tags$a(href = "https://www.linkedin.com/in/stephanie-mpd/",
                                      "Stephanie Duncan")),
                    "This interactive dashboard gives insights and trends on cancer incidence in Scotland between 1994 - 2018. Cancer incidence is broken down by health board (area), cancer site and gender.",
                    br(),
                    "The code I wrote to produce this dashboard can be found on my ", tags$a(href = "https://github.com/stephanieduncan/cancer_rates/", "Github Repository"),
                    br(),
                    "The data used to carry out analysis for this dashboard is open source and can be found in the links below.",
                    br(),
                    br(),
                    fluidRow(
                        box(title = "Data Sources", solidHeader = TRUE, status = "primary",
                            h5(strong("NHS Scotland")),
                            
                            tags$a(href="https://www.opendata.nhs.scot/dataset/annual-cancer-incidence", 
                                   "Cancer Incidence Data"),
                            br(),
                            tags$a(href="https://www.opendata.nhs.scot/dataset/9f942fdb-e59e-44f5-b534-d6e17229cc7b/resource/652ff726-e676-4a20-abda-435b98dd7bdc", 
                                   "Geography Health Board Labels Lookup")
                    )
                    )
            )
        )
    )
)