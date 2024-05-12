library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(plotly)

source("src/core/cards_ui.R")
source("src/core/main_ui.R")

ui <- fluidPage(
  uiOutput("main_ui")
)

server <- function(input, output, session) {
  options(shiny.maxRequestSize = 100 * 1024^2)
  current_page <- reactiveVal("home")
  
  excel_data <- reactive({
    dataset_excel <- read.csv("/Users/silapostu/Coding/Courses/cosc-spring2024/final_project/Air_Quality.csv", stringsAsFactors = FALSE)
    assign("final_project_viewdata", dataset_excel, envir = .GlobalEnv)
    dataset_excel
  })
  
  observe({
    excel_data()
  })
  
  cards_ui_impl(input, output, session, excel_data)
  
  main_ui_impl(input, output, session, current_page, excel_data)
  
  observeEvent(input$go_to_Stat1_AvgOzn, {
    current_page("Stat1_AvgOzn")
  })
  
  observeEvent(input$go_to_Stat2_PersonDays_PM2.5, {
    current_page("Stat2_PersonDays_PM2.5")
  })
  
  observeEvent(input$go_to_Stat3_AvgAmb, {
    current_page("Stat3_AvgAmb")
  })
  
  observeEvent(input$go_to_Stat4_OznConcen, {
    current_page("Stat4_OznConcen")
  })
  observeEvent(input$go_to_Stat5_NAAQS, {
    current_page("Stat5_NAAQS")
  })
  observeEvent(input$go_to_Stat6_MonitModel, {
    current_page("Stat6_MonitModel")
  })
  
  
  
  observeEvent(input$back_to_home_Stat1_AvgOzn, {
    current_page("home")
  })
  
  observeEvent(input$back_to_home_Stat2_PersonDays_PM2.5, {
    current_page("home")
  })
  observeEvent(input$back_to_home_Stat3_AvgAmb, {
    current_page("home")
  })
  observeEvent(input$back_to_home_Stat4_OznConcen, {
    current_page("home")
  })
  observeEvent(input$back_to_home_Stat5_NAAQS, {
    current_page("home")
  })
  observeEvent(input$back_to_home_Stat6_MonitModel, {
    current_page("home")
  })
  
  
  
  
  
}

shinyApp(ui = ui, server = server)
