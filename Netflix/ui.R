library(shiny)
library("DT")
library(lubridate, warn.conflicts = FALSE)
library(shinythemes)

navbarPage(("Netflix Tv Shows and Movies"),
  tabPanel(
    "Introduction ", 
    fluidPage(
      h4("This is the nexflix dashboard inspired by the netflix dataset posted on Kaggle. The purpose of this project is to analyze the Netflix TV shows and movies data set to derive value so that we can visualize the content to our stakeholders in a shiny app. The data set contains 12 unique columns by 8000+ rows of observation data of TV shows and movies. After the data wrangling process, the data set was left was 5332 rows of observations which will be used for in-depth analysis and visualization. The shiny app Dashboard that I created will allow the user to select values from two pull-down lists to filter the data set. After the user selection, the dashboard will be visualizing a column graph that shows the user when the content has been released on Netflix based on the years. The dashboard will also show a data table of the selected data to allow the stakeholder to comprehend what content is on Netflix based on the user selection. ")
    )),
  
tabPanel(
  "Dashboard", 
fluidPage(theme = shinytheme("lumen"),
  titlePanel("Netflix Tv Shows and Movies Dashboard"), 
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
     # h3("Data Table"),
      DTOutput("content_table")
    ))))
)


