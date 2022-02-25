library(shiny)
library("DT")


navbarPage(
  "Netflix Tv Shows and Movies", 
  tabPanel(
    "Tv Show",
    fluidPage(
      
      selectInput("select_content_type", h3(" Select Content"), choice = content_list), 
      
      selectInput("select_genre_tv_show", h3(" Select Genre"),
      choice = genre_list, multiple = TRUE), 

# populates a graph to count shows per year 
# populates a data table of the TV Shows 
      
      plotOutput("tv_shows_graph"),
      DTOutput("tv_shows")

    )
  ),
    tabPanel(
      "Movie",
      fluidPage(
        
        plotOutput("movies_graph"),
        DTOutput("movies")
      )
    )
)


