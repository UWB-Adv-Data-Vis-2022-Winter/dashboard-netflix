library(shiny)
library("DT")
library(lubridate, warn.conflicts = FALSE)


fluidPage(
  titlePanel("Netflix Tv Shows and Movies"), 
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
      DTOutput("content_table")
    ))
  
)



