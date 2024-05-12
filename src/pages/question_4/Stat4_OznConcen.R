library(shiny)
library(plotly)
library(dplyr)

source("src/plots/question_4/state/plot_q4_StTab.R")
source("src/plots/question_4/state_state/plot_q4_StStTab.R")

Stat4_OznConcen_page <- function(input, output, session, excel_data) {
  
  data_plot_q4_StBox_function(input, output, session, excel_data)
  data_plot_q4_StStBox_function(input, output, session, excel_data)
  
  fluidPage(
    titlePanel("Number of person-days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard"),
    
    tabsetPanel(
      id = "q4_tabs",
      
      tabPanel(
        "State",
        selectInput(
          inputId = "state_filter",
          label = "Select a State:",
          choices = sort(unique(excel_data()$StateName)),
          selected = sort(unique(excel_data()$StateName))[1]
        ),
        plotlyOutput("Stat4_OznConcen_state_plot"),
      ),
      tabPanel(
        "State by State",
        sidebarLayout(
          sidebarPanel(
            selectInput(
              inputId = "state_filter1",
              label = "Select the First State:",
              choices = sort(unique(excel_data()$StateName)),
              selected = sort(unique(excel_data()$StateName))[1]
            ),
            selectInput(
              inputId = "state_filter2",
              label = "Select the Second State:",
              choices = sort(unique(excel_data()$StateName)),
              selected = sort(unique(excel_data()$StateName))[4]
            ),
            selectInput(
              inputId = "year_filter",
              label = "Select a Year:",
              choices = sort(unique(excel_data()$ReportYear))[-c(1, 2, length(unique(excel_data()$ReportYear)) - 1, length(unique(excel_data()$ReportYear)))],
              selected = sort(unique(excel_data()$ReportYear))[3]
            )
          ),
          mainPanel(
            plotlyOutput("q4_stst_box_plot")
          )
        )
      )
    ),
    actionButton("back_to_home_Stat4_OznConcen", "Back to Home")
  )
}
