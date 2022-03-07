library(shiny)
library("DT")
library(lubridate, warn.conflicts = FALSE)
library(shinythemes)

navbarPage(("Netflix Tv Shows and Movies"),
  tabPanel(
    "Introduction ", 
    fluidPage(
      h4("This is the nexflix dashboard inspired by the netflix dataset posted on Kaggle. ")
    )),
  
tabPanel(
  "Dashboard", 
fluidPage(theme = shinytheme("lumen"),
  titlePanel("Netflix Tv Shows and Movies Dashboard"), 
  sidebarLayout(
    sidebarPanel(
      # Attempt to create a url to data source 
      uiOutput("tab"), 
      uiOutput("type_ui"),
      uiOutput("genre_ui")
    ),
    mainPanel(
      
      textOutput("result"),
      plotOutput("netflix_bar_graph"),
      DTOutput("shows"),
     # h3("Data Table"),
      DTOutput("content_table")
    ))))
)


