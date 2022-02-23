library(shiny)
library("DT")


navbarPage(
  "Netflix Tv Shows and Movies", 
  tabPanel(
    "Tv Show",
    fluidPage(
     # renderPlot("tv_show_graph"), 
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


