library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(plotly)

main_ui_impl <- function(input, output, session, current_page, excel_data) {
  
  source("src/pages/question_1/Stat1_AvgOzn.R")
  source("src/pages/question_2/Stat2_PersonDays_PM2.5.R")
  source("src/pages/question_3/Stat3_AvgAmb.R")
  source("src/pages/question_4/Stat4_OznConcen.R")
  source("src/pages/question_5/Stat5_NAAQS.R")
  source("src/pages/question_6/Stat6_MonitModel.R")
  
  output$main_ui <- renderUI({
    if (current_page() == "home") {
      fluidPage(
        titlePanel("Home Page"),
        uiOutput("cards_ui")
      )
    } else if (current_page() == "Stat1_AvgOzn") {
      output$Stat1_AvgOzn_page_ui <- renderUI({
        Stat1_AvgOzn_page(input, output, session, excel_data)
      })
      uiOutput("Stat1_AvgOzn_page_ui")
      
    } else if (current_page() == "Stat2_PersonDays_PM2.5") {
      
      output$Stat2_PersonDays_PM2.5_page_ui <- renderUI({
        Stat2_PersonDays_PM2.5_page(input, output, session, excel_data)
      })
      uiOutput("Stat2_PersonDays_PM2.5_page_ui")
      
    } else if (current_page() == "Stat3_AvgAmb") {
      
      output$Stat3_AvgAmb_page_ui <- renderUI({
        Stat3_AvgAmb_page(input, output, session, excel_data)
      })
      uiOutput("Stat3_AvgAmb_page_ui")
      
    } else if (current_page() == "Stat4_OznConcen") {
      output$Stat4_OznConcen_page_ui <- renderUI({
        Stat4_OznConcen_page(input, output, session, excel_data)
      })
      uiOutput("Stat4_OznConcen_page_ui")
    } else if (current_page() == "Stat5_NAAQS") {
      output$Stat5_NAAQS_page_ui <- renderUI({
        Stat5_NAAQS_page(input, output, session, excel_data)
      })
      uiOutput("Stat5_NAAQS_page_ui")
    }
    else if (current_page() == "Stat6_MonitModel") {
      output$Stat6_MonitModel_page_ui <- renderUI({
        Stat6_MonitModel_page(input, output, session, excel_data)
      })
      uiOutput("Stat6_MonitModel_page_ui")
    }
    
    
    
    
  })
  
  output$county_filter_ui_tab2 <- renderUI({
    selected_state <- input$state_filter_tab2
    state_data <- excel_data() %>%
      filter(StateName == selected_state)
    counties <- unique(state_data$CountyName)
    selectInput(
      inputId = "county_filter_tab2",
      label = "Select a County:",
      choices = counties,
      selected = counties[1]
    )
  })
}
