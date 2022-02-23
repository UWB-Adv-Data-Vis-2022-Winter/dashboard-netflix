library(shiny)
library("DT")


navbarPage(
  "Netflix Tv Shows and Movies", 
  tabPanel(
    "Tv Show",
    fluidPage(
      
      plotOutput("tv_shows_graph"),
      DTOutput("tv_shows")
    )
  ),
    tabPanel(
      "Movie",
      fluidPage(
        DTOutput("movies")
      )
    )
)


