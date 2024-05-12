library(shiny)
library(plotly)
library(dplyr)

source("src/plots/question_1/state/plot_q1_StTab.R")
source("src/plots/question_1/state_county/plot_q1_StCoTab.R")
source("src/plots/question_1/state_state/plot_q1_StStTab.R")

Stat1_AvgOzn_page <- function(input, output, session, excel_data) {
  data_plot_q1_StSt_function(input, output, session, excel_data)
  data_plot_q1_StCoTab_function(input, output, session, excel_data)
  data_plot_q1_StTab_function(input, output, session, excel_data)
  
  fluidPage(
    titlePanel("Number of Days with Maximum 8-hour Average Ozone Concentration Over the National Ambient Air Quality Standard"),
    
    tabsetPanel(
      id = "main_tabs",
      tabPanel(
        "States",
        selectInput(
          inputId = "state_filter",
          label = "Select a State:",
          choices = unique(excel_data()$StateName),
          selected = unique(excel_data()$StateName)[1]
        ),
        plotlyOutput("data_plot_q1_StTab")
      ),
      
      tabPanel(
        "States with County",
        fluidRow(
          column(
            width = 6,
            selectInput(
              inputId = "state_filter_tab2",
              label = "Select a State:",
              choices = unique(excel_data()$StateName),
              selected = unique(excel_data()$StateName)[1]
            )
          ),
          column(
            width = 6,
            uiOutput("county_filter_ui_tab2")
          )
        ),
        plotlyOutput("data_plot_q1_StCoTab")
      ),
      
      tabPanel(
        "Compare States",
        fluidRow(
          column(
            width = 6,
            selectInput(
              inputId = "state_filter_1",
              label = "Select the first State:",
              choices = unique(excel_data()$StateName),
              selected = unique(excel_data()$StateName)[1]
            )
          ),
          column(
            width = 6,
            selectInput(
              inputId = "state_filter_2",
              label = "Select the second State:",
              choices = unique(excel_data()$StateName),
              selected = unique(excel_data()$StateName)[2]
            )
          )
        ),
        plotlyOutput("data_plot_q1_StComparison")
      )
    ),
    
    actionButton("back_to_home_Stat1_AvgOzn", "Back to Home")
  )
}
