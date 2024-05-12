library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(plotly)

create_card <- function(input_id, button_label, p_text) {
  actionButton(
    inputId = input_id,
    label = NULL,
    class = "btn-box",
    icon = NULL,
    width = 300,
    style = "display: flex; align-items: center; justify-content: center; width: 30%; margin: 0 10px; padding: 15px; text-align: center; background-color: #f0f8ff; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); transition: box-shadow 0.3s ease;",
    div(
      style = "flex: 1; display: flex; align-items: center; justify-content: center; overflow-y: auto; max-height: 150px; text-align: center; white-space: normal;",
      p(p_text, style = "margin: 0; padding: 0;")
    )
  )
}

cards_ui_impl <- function(input, output, session, excel_data) {
  output$cards_ui <- renderUI({
    req(excel_data())
    
    card_list <- list()
    
    # CARDS 1-3 --------------------------------
    card_list$Stat1_AvgOzn <- create_card(
      "go_to_Stat1_AvgOzn",
      NULL,
      "#1) Number of days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard"
    )
    
    card_list$Stat2_PersonDays_PM2.5 <- create_card(
      "go_to_Stat2_PersonDays_PM2.5",
      NULL,
      "#2) Person-days with PM2.5 over the National Ambient Air Quality Standard"
    )
    
    card_list$Stat3_AvgAmb <- create_card(
      "go_to_Stat3_AvgAmb",
      NULL,
      "#3) Annual average ambient concentrations of PM 2.5 in micrograms per cubic meter, based on seasonal averages and daily measurement (monitor and modeled data)"
    )
    #-------------------------------------------
    
    # CARDS 4-6 --------------------------------
    card_list$Stat4_OznConcen <- create_card(
      "go_to_Stat4_OznConcen",
      NULL,
      "#4) Number of person-days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard"
    )
    
    card_list$Stat5_NAAQS <- create_card(
      "go_to_Stat5_NAAQS",
      NULL,
      "#5) Percent of days with PM2.5 levels over the National Ambient Air Quality Standard (NAAQS)"
    )
    
    card_list$Stat6_MonitModel <- create_card(
      "go_to_Stat6_MonitModel",
      NULL,
      "#6) Percent of days with PM2.5 levels over the National Ambient Air Quality Standard (monitor and modeled data)"
    )
    
    #-------------------------------------------
    
    
    
    fluidRow(
      fluidRow(
        style = "display: flex; margin-bottom: 10px;",
        card_list$Stat1_AvgOzn,
        card_list$Stat2_PersonDays_PM2.5,
        card_list$Stat3_AvgAmb
      ),
      fluidRow(
        style = "display: flex; margin-top: 25px;",
        card_list$Stat4_OznConcen,
        card_list$Stat5_NAAQS,
        card_list$Stat6_MonitModel
      )
      
    )
    
  })
}
