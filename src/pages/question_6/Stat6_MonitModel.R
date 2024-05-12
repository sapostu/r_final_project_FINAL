library(shiny)
library(plotly)
library(dplyr)

source("src/plots/question_6/state/plot_q6_StTab.R")
source("src/plots/question_6/state_county/plot_q6_StCoTab.R")
source("src/plots/question_6/state_state/plot_q6_StStTab.R")

Stat6_MonitModel_page <- function(input, output, session, excel_data) {
  data_plot_q6_StTab_function(input, output, session, excel_data)
  data_plot_q6_StCoTab_function(input, output, session, excel_data)
  data_plot_q6_StSt_function(input, output, session, excel_data)
  
  fluidPage(
    titlePanel("Percent of days with PM2.5 levels over the National Ambient Air Quality Standard (monitor and modeled data)"),
    
    tabsetPanel(
      id = "q6_tabs",
      tabPanel(
        "States",
        selectInput(
          inputId = "state_filter",
          label = "Select a State:",
          choices = unique(excel_data()$StateName),
          selected = unique(excel_data()$StateName)[1]
        ),
        plotlyOutput("data_plot_q6_StTab")
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
        plotlyOutput("data_plot_q6_StCoTab")
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
        plotlyOutput("data_plot_q6_StComparison")
      )
    ),
    
    actionButton("back_to_home_Stat6_MonitModel", "Back to Home")
  )
}
