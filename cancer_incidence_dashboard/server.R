server <- function(input, output) {
    
    ##################First tab content - temporal
    incidence_output <- reactive({
        cancer_geo %>% 
            filter(hb_name == input$hb_name,
                   sex == input$sex)
        
    })
    
    output$incidence_output <- renderPlot({
        
        incidence_output() %>%
            filter(cancer_site == "All cancer types") %>% 
            group_by(year) %>% 
            summarise(total = sum(incidences_all_ages)) %>% 
            ggplot() +
            aes(x = year, y = total) +
            geom_line(colour = "red") +
            theme_minimal() +
            labs(
                x = "Year",
                y = "Total Incidence All Ages",
                title = "Cancer Incidence",
                subtitle = "1994 - 2018"
            ) +
            scale_x_continuous(breaks = (min(cancer_geo$year):max(cancer_geo$year))) +
            theme(axis.text.x = element_text(angle=45,hjust=1))
        
    })
        
        ##################Second tab content - cancer sites
        site_output <- reactive({
            cancer_geo %>% 
                filter(hb_name == input$hb_name_two,
                       cancer_site == input$cancer_site_two,
                       sex == input$sex_two)
            
        })
        
        output$site_output <- renderPlot({
            
            site_output() %>%
                group_by(year) %>% 
                summarise(total = sum(incidences_all_ages)) %>% 
                ggplot() +
                aes(x = year, y = total) +
                geom_line(colour = "red") +
                theme_minimal() +
                labs(
                    x = "Year",
                    y = "Total Incidence All Ages",
                    title = "Cancer Incidence by Site",
                    subtitle = "1994 - 2018"
                ) +
                scale_x_continuous(breaks = (min(cancer_geo$year):max(cancer_geo$year))) +
                theme(axis.text.x = element_text(angle=45,hjust=1)) 
            
        })
        
        
        ##################Third tab content - crude rates
        crude_rate_output <- reactive({
            cancer_geo %>% 
                filter(hb_name == input$hb_name_three,
                       cancer_site == input$cancer_site_three,
                       sex == input$sex_three)
            
        })
        
        output$crude_rate_output <- renderPlot({
            
            crude_rate_output() %>%
                ggplot() +
                aes(x = year, y = crude_rate) +
                geom_line(colour = "red") +
                geom_point(colour = "red") +
                geom_point(aes(y = crude_rate_lower95pc_confidence_interval, colour = "Lower 95 Confidence Interval")) +
                geom_point(aes(y = crude_rate_upper95pc_confidence_interval, color = "Higher 95 Confidence Interval")) +
                theme_minimal() +
                labs(
                    y = "Crude Rate",
                    x = "Year",
                    title = "Crude Rate by Cancer Site",
                    subtitle = "1994 - 2018",
                    colour = "Confidence Interval"
                ) +
                scale_x_continuous(breaks = c(1995, 2000, 2005, 2010, 2015, 2020)) +
                theme(axis.text.x = element_text(angle = 45, hjust = 1)) 
            
        })
    
    
}
