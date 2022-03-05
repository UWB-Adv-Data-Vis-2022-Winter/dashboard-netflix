library(shiny)
library("DT")
library(lubridate)


fluidPage(
  titlePanel("Netflix Tv Shows and Movies"), 
  sidebarLayout(
    sidebarPanel(
      uiOutput("genre"),
      uiOutput("type")
      ),
    mainPanel(
      textOutput("result"),
      DTOutput("shows"),
      plotOutput("netflix_bar_graph"),
      DTOutput("content_table")
      ))
      
)




