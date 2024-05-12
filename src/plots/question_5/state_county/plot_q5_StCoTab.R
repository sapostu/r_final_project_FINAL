library(dplyr)
library(ggplot2)
library(plotly)
library(scales)

data_plot_q5_CountyBar_function <- function(input, output, session, excel_data) {
  create_plot_County_Stat5_NAAQS <- function(excel_data, report_year, selected_state) {
    data_subset <- excel_data() %>%
      filter(
        MeasureName == "Percent of days with PM2.5 levels over the National Ambient Air Quality Standard (NAAQS)",
        ReportYear == report_year,
        StateName == selected_state
      ) %>%
      group_by(CountyName) %>%
      summarize(mean_value = mean(Value, na.rm = TRUE)) %>%
      top_n(10, wt = mean_value)  
    
    ggplot(data_subset, aes(x = reorder(CountyName, -mean_value), y = mean_value)) +
      geom_bar(stat = "identity", fill = "#DEFFA4") +
      labs(
        x = "County",
        y = "Average Person-days with PM2.5",
        title = paste("Top 10 Counties with PM2.5 over NAAQS in", report_year, "(", selected_state, ")")
      ) +
      theme_minimal() +
      scale_y_continuous(labels = scales::comma_format()) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  }
  
  output$plot_County_Stat5_NAAQS <- renderPlot({
    req(input$county_report_year_filter, input$county_state_filter)
    create_plot_County_Stat5_NAAQS(excel_data(), input$county_report_year_filter, input$county_state_filter)
  })
}
