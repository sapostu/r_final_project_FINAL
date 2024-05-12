library(dplyr)
library(ggplot2)
library(plotly)
library(scales)

data_plot_q5_StateByState_function <- function(input, output, session, excel_data) {
  create_plot_StateByState_Stat5_NAAQS <- function(excel_data, report_year, state1, state2) {
    data_subset <- excel_data() %>%
      filter(
        MeasureName == "Percent of days with PM2.5 levels over the National Ambient Air Quality Standard (NAAQS)",
        ReportYear == report_year,
        StateName %in% c(state1, state2)
      ) %>%
      group_by(StateName, CountyName) %>%
      summarize(mean_value = mean(Value, na.rm = TRUE)) %>%
      group_by(StateName) %>%
      top_n(10, wt = mean_value)
    
    ggplot(data_subset, aes(x = reorder(CountyName, -mean_value), y = mean_value, fill = StateName)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(
        x = "County",
        y = "Average Person-days with PM2.5",
        title = paste("Top 10 Counties with PM2.5 over NAAQS in", report_year)
      ) +
      theme_minimal() +
      scale_fill_manual(values = c("#DEFFA4", "#C6A4FF")) +
      scale_y_continuous(labels = scales::comma_format()) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  }
  
  output$plot_StateByState_Stat5_NAAQS <- renderPlot({
    req(input$state_by_state_year_filter, input$state_by_state_state1_filter, input$state_by_state_state2_filter)
    create_plot_StateByState_Stat5_NAAQS(excel_data(), input$state_by_state_year_filter, input$state_by_state_state1_filter, input$state_by_state_state2_filter)
  })
}
