library(shiny)
library(lubridate)
library(tidyverse)
library(reactlog)
library(data.table)

shinyServer(function(input, output, session) {
  
  #load data and lists  
  content_list <- unique(netflix_titles3$type)
  netflix_titles3$genre <- strsplit(netflix_titles3$listed_in, ", ")
  names(netflix_titles3$genre) <- netflix_titles3$show_id
  
  # Select Content widget 
  output$type_ui <- renderUI({
    selectInput("select_content_type", label = h3(" Select Content"), 
                choices = content_list, selected  = NULL)
  })
  
  # Select Genre Widget
  output$genre_ui <- renderUI({
    selectInput("select_genre", label = h3(" Select Genre"),
                choices = filter_genre(), multiple = TRUE, selected  = NULL)
  })
  
  #  genre_list <- unlist(netflix_titles3$genre) %>%
  #  unique()
  
  checkTV <- function(i) ({
    if (grepl("TV", i) || grepl("Stand-Up", i) || grepl("Series", i)) {
      i
    } else {
      c()
    }
  })
  
  uniqueGenreList <- unlist(netflix_titles3$genre) %>% unique()
  
  
  filter_genre <- reactive({
    if(!is.null(input$select_content_type) && input$select_content_type == "TV Show") {
      tvGenresWithNulls <- lapply(uniqueGenreList, checkTV)
      nonNullTVGenres <- which(!sapply(tvGenresWithNulls, is.null))
      res <- uniqueGenreList[nonNullTVGenres]
      res
    }
    else
    {
      tvGenresWithNulls <- lapply(uniqueGenreList, checkTV)
      nonNullTVGenres <- which(sapply(tvGenresWithNulls, is.null))
      res <- uniqueGenreList[nonNullTVGenres]
      res
    }
  })
  
  observeEvent(input$select_genre, {
    output$content_table <- renderDT({
      netflix_titles3 %>%
        filter(
          type %in% input$select_content_type, grepl(paste(input$select_genre, collapse="|"), genre)) %>%
        select(title, genre, date_added, duration, rating)
    })
    output$netflix_bar_graph <- renderPlot({
      netflix_titles3 %>%
        filter(
          type %in% input$select_content_type, grepl(paste(input$select_genre, collapse="|"), genre)) %>%
        group_by(date_year) %>%
        summarize(n = n()) %>%
        drop_na() %>%
        ggplot(.) +
        geom_col(aes(x = date_year, y = n))
    })
  })
})




