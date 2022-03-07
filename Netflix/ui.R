library(shiny)
library(lubridate, warn.conflicts = FALSE)


fluidPage(
  titlePanel("Netflix Tv Shows and Movies"), 
  sidebarLayout(
    sidebarPanel(
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



