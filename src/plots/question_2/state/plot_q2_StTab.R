library(dplyr)
library(ggplot2)
library(plotly)
library(scales)

data_plot_q2_StBar_function <- function(input, output, session, excel_data) {
  create_plot_PersonDays_PM25 <- function(excel_data, report_year) {
    data_subset <- excel_data() %>%
      filter(
        MeasureName == "Person-days with PM2.5 over the National Ambient Air Quality Standard",
        ReportYear == report_year
      ) %>%
      group_by(StateName) %>%
      summarize(mean_value = mean(Value, na.rm = TRUE)) %>%
      top_n(15, wt = mean_value)
    
    ggplot(data_subset, aes(x = reorder(StateName, -mean_value), y = mean_value)) +
      geom_bar(stat = "identity", fill = "#82c3f0") +
      labs(
        x = "State",
        y = "Average Person-days with PM2.5",
        title = paste("Top 15 States with too high PM2.5 in", report_year)
      ) +
      theme_minimal() +
      scale_y_continuous(labels = comma_format()) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  }
  
  output$plot_PersonDays_PM25 <- renderPlot({
    req(input$report_year_filter)
    create_plot_PersonDays_PM25(excel_data(), input$report_year_filter)
  })
}
