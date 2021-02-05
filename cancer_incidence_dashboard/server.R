server <- function(input, output) {
    
    ##################First tab content
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
                title = "Cancer Incidence in NHS Borders",
                subtitle = "1994 - 2018"
            ) +
            scale_x_continuous(breaks = (min(cancer_geo$year):max(cancer_geo$year))) +
            theme(axis.text.x = element_text(angle=45,hjust=1)) 
        
    })
    
}
