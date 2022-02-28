library(shiny)
library("DT")


navbarPage(
  "Netflix Tv Shows and Movies", 
  tabPanel(
    "Tv Show",
    fluidPage(
      
      selectInput("select_content_type", label = h3(" Select Content"), 
                  choices = content_list, selected  = NULL), 
     
      
      selectInput("select_genre", label = h3(" Select Genre"),
      choices = new_genre_list(), multiple = TRUE, selected  = new_genre_list()), 
      

# populates a graph to count shows per year 
# populates a data table of the TV Shows 
      
      plotOutput("netflix_bar_graph"),
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


