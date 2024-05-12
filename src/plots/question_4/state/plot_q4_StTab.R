library(dplyr)
library(ggplot2)
library(plotly)
library(scales)

data_plot_q4_StBox_function <- function(input, output, session, excel_data) {
  output$Stat4_OznConcen_state_plot <- renderPlotly({
    req(input$state_filter)
    
    data_subset <- excel_data() %>%
      filter(MeasureName == "Number of person-days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard",
             StateName == input$state_filter)
    
    p <- ggplot(data_subset, aes(x = as.factor(ReportYear), y = Value)) +
      geom_boxplot() +
      labs(
        x = "Year",
        y = "Value",
        title = paste("Box Plot of ozone concentration for", input$state_filter)
      ) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      scale_y_continuous(labels = scales::comma)
    
    ggplotly(p)
  })
}
