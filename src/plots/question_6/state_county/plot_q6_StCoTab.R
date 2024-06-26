library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

data_plot_q6_StCoTab_function <- function(input, output, session, excel_data) {
  county_ready <- reactive({
    req(input$county_filter_tab2)
    input$county_filter_tab2
  })
  
  create_plot_q6_StCoTab <- function(selected_state, selected_county, excel_data) {
    data_subset <- excel_data %>%
      filter(
        MeasureName == "Percent of days with PM2.5 levels over the National Ambient Air Quality Standard (monitor and modeled data)" &
          StateName == selected_state &
          CountyName == selected_county
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
        title = paste("Mean Value Over Time for State:", selected_state, "County:", selected_county),
        x = "Report Year",
        y = "Mean Value"
      ) +
      theme_minimal()
    
    return(ggplotly(plot) %>% layout(hoverlabel = list(bgcolor = "white", bordercolor = "black")))
  }
  
  output$data_plot_q6_StCoTab <- renderPlotly({
    req(excel_data())
    selected_state <- input$state_filter_tab2
    selected_county <- county_ready()
    plotly_plot <- create_plot_q6_StCoTab(selected_state, selected_county, excel_data())
    plotly_plot
  })
}
