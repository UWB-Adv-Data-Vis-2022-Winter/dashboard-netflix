library(shiny)
library("DT")
library(lubridate)


navbarPage(
  "Netflix Tv Shows and Movies", 
  tabPanel(
    "Dashboard",
    fluidPage(
      
#      actionButton("botton", "An action botton"),
#      actionLink("botton", "https://www.google.com/"),
      
      # Attempt to create a url to data source      
      uiOutput("tab"), 
      
      selectInput("select_content_type", label = h3(" Select Content"), 
                  choices = content_list, selected  = NULL), 
     
      
      selectInput("select_genre", label = h3(" Select Genre"),
      choices = genre_list, multiple = TRUE, selected  = "Dramas"), 
      

# populates a graph to count shows per year 
# populates a data table of the TV Shows 
      
      plotOutput("netflix_bar_graph"),
      DTOutput("content_table")
)
)
)





