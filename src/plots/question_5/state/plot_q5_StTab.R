library(dplyr)
library(ggplot2)
library(plotly)
library(scales)

data_plot_q5_StBar_function <- function(input, output, session, excel_data) {
  create_plot_Stat5_NAAQS <- function(excel_data, report_year) {
    data_subset <- excel_data() %>%
      filter(
        MeasureName == "Percent of days with PM2.5 levels over the National Ambient Air Quality Standard (NAAQS)",
        ReportYear == report_year
      ) %>%
      group_by(StateName) %>%
      summarize(mean_value = mean(Value, na.rm = TRUE)) %>%
      top_n(15, wt = mean_value)  
    
    ggplot(data_subset, aes(x = reorder(StateName, -mean_value), y = mean_value)) +
      geom_bar(stat = "identity", fill = "#C6A4FF") +
      labs(
        x = "State",
        y = "Average Person-days with PM2.5",
        title = paste("Top 15 States with PM2.5 over NAAQS in", report_year)
      ) +
      theme_minimal() +
      scale_y_continuous(labels = scales::comma_format()) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  }
  
  output$plot_state_Stat5_NAAQS <- renderPlot({
    req(input$report_year_filter)
    create_plot_Stat5_NAAQS(excel_data(), input$report_year_filter)
  })
}
