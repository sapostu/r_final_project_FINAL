library(shiny)
library(plotly)
library(dplyr)

source("src/plots/question_5/state/plot_q5_StTab.R")
source("src/plots/question_5/state_county/plot_q5_StCoTab.R")
source("src/plots/question_5/state_state/plot_q5_StStTab.R")

Stat5_NAAQS_page <- function(input, output, session, excel_data) {
  data_plot_q5_StBar_function(input, output, session, excel_data)
  data_plot_q5_CountyBar_function(input, output, session, excel_data)
  data_plot_q5_StateByState_function(input, output, session, excel_data)  
  
  fluidPage(
    titlePanel("Percent of days with PM2.5 levels over the National Ambient Air Quality Standard (NAAQS)"),
    
    tabsetPanel(
      tabPanel(
        "States",
        selectInput(
          inputId = "report_year_filter",
          label = "Select a Report Year:",
          choices = sort(unique(excel_data()$ReportYear)),
          selected = sort(unique(excel_data()$ReportYear))[1]
        ),
        plotOutput("plot_state_Stat5_NAAQS")
      ),
      tabPanel(
        "State + Counties",
        fluidRow(
          column(
            width = 6,
            selectInput(
              inputId = "county_report_year_filter",
              label = "Select a Report Year:",
              choices = sort(unique(excel_data()$ReportYear)),
              selected = sort(unique(excel_data()$ReportYear))[1]
            )
          ),
          column(
            width = 6,
            selectInput(
              inputId = "county_state_filter",
              label = "Select a State:",
              choices = sort(unique(excel_data()$StateName)),
              selected = sort(unique(excel_data()$StateName))[1]
            )
          )
        ),
        plotOutput("plot_County_Stat5_NAAQS"),
        
        tags$style(HTML("
          #plot_County_Stat5_NAAQS {
            margin-top: 20px;
          }
        "))
      ),
      tabPanel(
        "State by State",
        fluidRow(
          column(
            width = 4,
            selectInput(
              inputId = "state_by_state_year_filter",
              label = "Select a Report Year:",
              choices = sort(unique(excel_data()$ReportYear)),
              selected = sort(unique(excel_data()$ReportYear))[1]
            )
          ),
          column(
            width = 4,
            selectInput(
              inputId = "state_by_state_state1_filter",
              label = "Select State 1:",
              choices = sort(unique(excel_data()$StateName)),
              selected = sort(unique(excel_data()$StateName))[1]
            )
          ),
          column(
            width = 4,
            selectInput(
              inputId = "state_by_state_state2_filter",
              label = "Select State 2:",
              choices = sort(unique(excel_data()$StateName)),
              selected = sort(unique(excel_data()$StateName))[2]
            )
          ),
          plotOutput("plot_StateByState_Stat5_NAAQS"),
          tags$style(HTML("
          #plot_StateByState_Stat5_NAAQS {
            margin-top: 70px;
          }
        "))
        )
      )
    ),
    
    fluidRow(
      column(
        width = 12,
        actionButton("back_to_home_Stat5_NAAQS", "Back to Home")
      )
    )
  )
}
