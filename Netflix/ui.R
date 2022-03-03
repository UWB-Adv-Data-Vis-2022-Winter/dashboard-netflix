library(shiny)
library("DT")
library(lubridate)


navbarPage(
  "Netflix Tv Shows and Movies", 
  tabPanel(
    "Dashboard",
    fluidPage(
      
      selectInput("select_content_type", label = h3(" Select Content"), 
                  choices = content_list, selected  = NULL), 
     
      
      selectInput("select_genre", label = h3(" Select Genre"),
      choices = genre_list, multiple = TRUE, selected  = "Dramas"),
      textOutput("result"),
      plotOutput("netflix_bar_graph"),
      DTOutput("content_table")
)
)
)




