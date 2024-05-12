library(dplyr)
library(ggplot2)
library(plotly)
library(scales)

data_plot_q2_CountyBar_function <- function(input, output, session, excel_data) {
  create_plot_County_PersonDays_PM25 <- function(excel_data, report_year, selected_state) {
    data_subset <- excel_data() %>%
      filter(
        MeasureName == "Person-days with PM2.5 over the National Ambient Air Quality Standard",
        ReportYear == report_year,
        StateName == selected_state
      ) %>%
      group_by(CountyName) %>%
      summarize(mean_value = mean(Value, na.rm = TRUE)) %>%
      top_n(10, wt = mean_value)
    
    ggplot(data_subset, aes(x = reorder(CountyName, -mean_value), y = mean_value)) +
      geom_bar(stat = "identity", fill = "#f9eba6") +
      labs(
        x = "County",
        y = "Average Person-days with PM2.5",
        title = paste("Top 10 Counties with too high PM2.5 in", report_year, "(", selected_state, ")")
      ) +
      theme_minimal() +
      scale_y_continuous(labels = scales::comma_format()) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  }
  
  output$plot_County_PersonDays_PM25 <- renderPlot({
    req(input$county_report_year_filter, input$county_state_filter)
    create_plot_County_PersonDays_PM25(excel_data(), input$county_report_year_filter, input$county_state_filter)
  })
}
