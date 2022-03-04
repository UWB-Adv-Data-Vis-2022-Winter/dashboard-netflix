library(shiny)
library("DT")
library(lubridate)


fluidPage(
  titlePanel("Netflix Tv Shows and Movies"), 
  sidebarLayout(
    sidebarPanel(selectInput("select_content_type", label = h3(" Select Content"), 
              choices = content_list, selected  = NULL), 
      selectInput("select_genre_tv_show", label = h3(" Select Genre"),
      choices = genre_list, multiple = TRUE, selected  = "Dramas")),
    mainPanel(
      textOutput("result"),
      DTOutput("shows"),
      plotOutput("netflix_bar_graph"),
      DTOutput("content_table")
      ))
      
)




