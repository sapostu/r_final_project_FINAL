library(dplyr)
library(ggplot2)
library(plotly)
library(scales)

# Function to create the box plot with top 10 states for a given year
data_plot_q3_StBox_function <- function(input, output, session, excel_data) {
  output$Stat3_AvgAmb_state_plot <- renderPlotly({
    req(input$state_filter)  # Ensure a state is selected
    
    data_subset <- excel_data() %>%
      filter(MeasureName == "Annual average ambient concentrations of PM 2.5 in micrograms per cubic meter, based on seasonal averages and daily measurement (monitor and modeled data)",
             StateName == input$state_filter)
    
    # Debug statement to check data_subset structure
    print(head(data_subset))
    
    # Create ggplot object
    p <- ggplot(data_subset, aes(x = as.factor(ReportYear), y = Value)) +
      geom_boxplot() +
      labs(
        x = "Year",
        y = "Value",
        title = paste("Monitor and modeled data for", input$state_filter)
      ) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
    # Convert ggplot object to plotly
    ggplotly(p)
  })
}
