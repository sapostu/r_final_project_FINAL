library(shiny)
library(plotly)
library(dplyr)

data_plot_q1_StSt_function <- function(input, output, session, excel_data) {
  output$data_plot_q1_StComparison <- renderPlotly({
    req(excel_data())
    state_1 <- input$state_filter_1
    state_2 <- input$state_filter_2
    
    data_state_1 <- excel_data() %>%
      filter(
        MeasureName == "Number of days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard" &
          StateName == state_1
      ) %>%
      group_by(ReportYear) %>%
      summarize(
        mean_value = mean(Value, na.rm = TRUE),
        sd_value = sd(Value, na.rm = TRUE)
      )
    
    data_state_2 <- excel_data() %>%
      filter(
        MeasureName == "Number of days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard" &
          StateName == state_2
      ) %>%
      group_by(ReportYear) %>%
      summarize(
        mean_value = mean(Value, na.rm = TRUE),
        sd_value = sd(Value, na.rm = TRUE)
      )
    
    plot <- plot_ly() %>%
      add_trace(
        data = data_state_1,
        x = ~ReportYear,
        y = ~mean_value,
        type = 'scatter',
        mode = 'lines',
        name = state_1,
        line = list(color = 'blue')
      ) %>%
      add_trace(
        data = data_state_2,
        x = ~ReportYear,
        y = ~mean_value,
        type = 'scatter',
        mode = 'lines',
        name = state_2,
        line = list(color = 'red')
      ) %>%
      layout(
        title = paste("Comparison of", state_1, "and", state_2, "Ozone Data"),
        xaxis = list(title = "Report Year"),
        yaxis = list(title = "Mean Value")
      )
    
    plot
  })
}
