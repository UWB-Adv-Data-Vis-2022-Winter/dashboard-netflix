library(shiny)
library("DT")

navbarPage(
  "Netflix Tv Shows and Movies", 
  tabPanel(
    "Tv Show",
    fluidPage(
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


