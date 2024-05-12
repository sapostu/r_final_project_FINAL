library(shiny)
library(plotly)
library(dplyr)

source("src/plots/question_3/state/plot_q3_StTab.R")
source("src/plots/question_3/state_state/plot_q3_StStTab.R")

Stat3_AvgAmb_page <- function(input, output, session, excel_data) {
  
  data_plot_q3_StBox_function(input, output, session, excel_data)
  data_plot_q3_StStBox_function(input, output, session, excel_data)
  
  fluidPage(
    titlePanel("Annual average ambient concentrations of PM 2.5 in micrograms per cubic meter, based on seasonal averages and daily measurement (monitor and modeled data)"),
    
    tabsetPanel(
      id = "q3_tabs",
      
      tabPanel(
        "State",
        selectInput(
          inputId = "state_filter",
          label = "Select a State:",
          choices = sort(unique(excel_data()$StateName)),
          selected = sort(unique(excel_data()$StateName))[1]
        ),
        plotlyOutput("Stat3_AvgAmb_state_plot"),
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
            plotlyOutput("q3_stst_box_plot")
          )
        )
      )
    ),
    actionButton("back_to_home_Stat3_AvgAmb", "Back to Home")
  )
}
