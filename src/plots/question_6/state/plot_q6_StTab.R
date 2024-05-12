library(dplyr)
library(ggplot2)
library(plotly)

data_plot_q6_StTab_function <- function(input, output, session, excel_data) {
  create_plot_q6_StTab <- function(selected_state, excel_data) {
    data_subset <- excel_data() %>%
      filter(
        MeasureName == "Percent of days with PM2.5 levels over the National Ambient Air Quality Standard (monitor and modeled data)" &
          StateName == selected_state
      ) %>%
      group_by(ReportYear) %>%
      summarize(mean_value = mean(Value, na.rm = TRUE))
    
    if (nrow(data_subset) == 0) {
      return(ggplotly(ggplot() + theme_void() + labs(title = "No data available")))
    }
    
    plot <- ggplot(data_subset, aes(x = ReportYear, y = mean_value)) +
      geom_line(color = "#FF7300") +
      geom_point(color = "#008CFF") +
      labs(
        title = paste("Mean Value Over Time for State:", selected_state),
        x = "Report Year",
        y = "Mean Value"
      ) +
      theme_minimal()
    
    return(ggplotly(plot) %>% layout(hoverlabel = list(bgcolor = "white", bordercolor = "black")))
  }
  
  output$data_plot_q6_StTab <- renderPlotly({
    req(excel_data())
    selected_state <- input$state_filter
    plotly_plot <- create_plot_q6_StTab(selected_state, excel_data)
    plotly_plot
  })
}
