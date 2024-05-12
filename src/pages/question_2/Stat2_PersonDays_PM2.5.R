library(shiny)
library(plotly)
library(dplyr)

source("src/plots/question_2/state/plot_q2_StTab.R")
source("src/plots/question_2/state_county/plot_q2_StCoTab.R")
source("src/plots/question_2/state_state/plot_q2_StStTab.R")

Stat2_PersonDays_PM2.5_page <- function(input, output, session, excel_data) {
  data_plot_q2_StBar_function(input, output, session, excel_data)
  data_plot_q2_CountyBar_function(input, output, session, excel_data)
  data_plot_q2_StateByState_function(input, output, session, excel_data)
  
  fluidPage(
    titlePanel("Person-days with PM2.5 over the National Ambient Air Quality Standard"),
    
    tabsetPanel(
      tabPanel(
        "States",
        selectInput(
          inputId = "report_year_filter",
          label = "Select a Report Year:",
          choices = sort(unique(excel_data()$ReportYear)),
          selected = sort(unique(excel_data()$ReportYear))[1]
        ),
        plotOutput("plot_PersonDays_PM25")
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
        plotOutput("plot_County_PersonDays_PM25"),
        tags$style(HTML("
          #plot_County_PersonDays_PM25 {
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
          plotOutput("plot_StateByState_PersonDays_PM25"),
          tags$style(HTML("
          #plot_StateByState_PersonDays_PM25 {
            margin-top: 70px;
          }
        "))
        )
      ),
    ),
    fluidRow(
      column(
        width = 12,
        actionButton("back_to_home_Stat2_PersonDays_PM2.5", "Back to Home")
      )
    )
  )
}
