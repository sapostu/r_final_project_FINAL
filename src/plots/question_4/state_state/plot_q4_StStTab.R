library(dplyr)
library(ggplot2)
library(plotly)
library(scales)

data_plot_q4_StStBox_function <- function(input, output, session, excel_data) {
  
  create_q4_StSt_plot <- function(excel_data, selected_year, selected_state1, selected_state2) {
    tryCatch(
      {
        data_state_1 <- excel_data() %>%
          filter(MeasureName == "Number of person-days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard",
                 ReportYear == selected_year,
                 StateName == selected_state1)
        
        data_state_2 <- excel_data() %>%
          filter(MeasureName == "Number of person-days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard",
                 ReportYear == selected_year,
                 StateName == selected_state2)
        
        if (nrow(data_state_1) == 0 && nrow(data_state_2) == 0) {
          p <- ggplot() +
            annotate("text", x = 0.5, y = 0.5, label = "No data available. Try selecting something else", size = 5) +
            theme_void()
        } else {
          p <- ggplot() +
            geom_boxplot(data = data_state_1, aes(x = as.factor(StateName), y = Value, fill = StateName), position = position_dodge(width = 0.8)) +
            geom_boxplot(data = data_state_2, aes(x = as.factor(StateName), y = Value, fill = StateName), position = position_dodge(width = 0.8)) +
            labs(
              x = "State",
              y = "Value",
              title = paste(selected_year, "Box Plot of ozone concentration for", selected_state1, "and", selected_state2)
            ) +
            theme_minimal() +
            theme(axis.text.x = element_text(angle = 45, hjust = 1))  +
            scale_fill_manual(values = c("#7C7DFF", "#FFFD7C")) +
            scale_y_continuous(labels = scales::comma)
        }
        
        return(p)
      },
      error = function(e) {
        p <- ggplot() +
          annotate("text", x = 0.5, y = 0.5, label = "Data Combination not possible. Try selecting something else", size = 5) +
          theme_void()
        return(p)
      }
    )
  }
  
  output$q4_stst_box_plot <- renderPlotly({
    req(input$state_filter1, input$state_filter2, input$year_filter)
    p <- create_q4_StSt_plot(excel_data(), input$year_filter, input$state_filter1, input$state_filter2)
    ggplotly(p)
  })
}
