library(shiny)
library("DT")
library(lubridate)
library(tidyverse)
library(reactlog)

shinyServer(function(input, output, session) {
  
  data <- netflix_titles3
  
#load data and lists  
  content_list <- unique(netflix_titles3$type)
  netflix_titles3$genre <- strsplit(netflix_titles3$listed_in, ", ")
  names(netflix_titles3$genre) <- netflix_titles3$show_id
  
  # Select Content widget 
  output$type_ui <- renderUI({
    selectInput("select_content_type", label = h3(" Select Content"), 
                choices = content_list, selected  = content_list[1])
  })
  
  # Select Genre Widget
  output$genre_ui <- renderUI({
    selectInput("select_genre_tv_show", label = h3(" Select Genre"),
                choices = genre(), multiple = TRUE, selected  = netflix_titles3$genre[6])
  })

#  genre_list <- unlist(netflix_titles3$genre) %>%
  #  unique()
  
  checkTV <- function(i) ({
    if (grepl("TV", i) || grepl("Stand-Up", i) || grepl("Series", i)) {
      i
    } else {
      NULL
    }
  })
  
  #checkMovie <- function(i) {
  #  if (grepl("TV", i)) {
  #    NULL
  #  } else {
  #    i
  #  }
  #}
  
  uniqueGenreList <- unlist(netflix_titles3$genre) %>% unique()
  
  
  genre <- reactive({
    if(input$select_content_type == "TV Show") {
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
  
  #tvGenresWithNulls <- reactive({lapply(uniqueGenreList, checkTV)})
  #movieGenresWithNulls <- reactive({lapply(uniqueGenreList, checkMovie)})
  
  #nonNullTVGenres <- reactive({which(!sapply(tvGenresWithNulls, is.null))})
  #nonNullMovieGenres <- reactive({which(sapply(tvGenresWithNulls, is.null))})
  
  #tvGenres <- reactive({uniqueGenreList[nonNullTVGenres]})
  #movieGenres <- reactive({uniqueGenreList[nonNullMovieGenres]})
  
  #genres <- reactive({
  #  if(output$type == "TV Show") { tvGenres } else { movieGenres }
  #})

 
  
  #var_type_list <- reactive({
  #  file <- output
  #  as.list(unique(file$type))
  #})
  
  #var_genre_list <- reactive({
  #  file <- data
  #  if(output$type == "TV Show") {filter(data, grepl("TV", output$genre))}
  #})  
  
  # # Filtered data
  # selected_genre <- reactive({
  #   netflix_titles3 %>%
  #     select(genre) %>%
  #     unlist(recursive = FALSE) %>% 
  #     enframe() %>% 
  #     mutate(name = netflix_titles3$show_id) %>%
  #     unnest(value) %>%
  #     filter(value %in% input$type)%>%
  #     `colnames<-`(c("show_id", "singlegenre"))
  # })
  
  # data_filtered <- reactive({
  #   netflix_titles3 %>% 
  #   filter(genre %in% selected_genre(),
  #          type %in% type())
  # })
  
  # Get filters from inputs
  # genre <- reactive({
  #   if (is.null(input$genre)) unique(netflix_titles3$genre) else input$genre
  # })
  
  # type <- reactive({
  #   if (is.null(input$type)) unique(df$type) else input$type
  # })
    

#   output$result <- renderText({
#   paste(unlist(input$select_genre_tv_show, recursive = FALSE))
# })

# bar graph of tv shows count per year   
# output$netflix_bar_graph <- renderPlot({
#   
#   # data_filtered() %>%
#   #   group_by(date_year) %>%
#   #   summarize(n = n()) %>% 
#   #   drop_na() %>%
#   
#   selected_genre() %>% 
#     group_by(single_genre) %>%
#     summarize(n = n()) %>% 
#     drop_na() %>%
#      ggplot() + 
#        geom_col(aes(x = singlegenre, y = n))  
#  
# })
  
# Data table of the tv shows  
  
  # output$shows <- renderDT({
  #   titles <- netflix_titles3 %>%
  #     filter(type %in% input$type) %>%
  #     filter(genre %in% (input$genre)) %>%
  #   select(title, genre, date_added, duration, rating, show_id)
    
    #selected_genre %>%
    #  left_join(selected_genre, titles) %>% 
     # unique()
      #select(title, genre, date_added, duration, rating)
    
    #subset(show_id %in% selected_genre()$name) %>%
    #select(title, genre, date_added, duration, rating) 
    
 # })
  
  # observe(input$select_genre_tv_show,
  #   {
  #     # netflix_tv_show_graph_filtered <- netflix_titles3 %>%
  #     #        filter(
  #     #          type %in% input$select_content_type) %>%
  #     #         #grepl(input$select_genre, uniqueGenreList)) %>%
  #     #       group_by(date_year) %>%
  #     #       summarize(n = n()) %>%
  #     #       drop_na()
  #     # netflix_tv_show_graph_filtered
  #   })

  # bar graph of tv shows count per year
  output$netflix_bar_graph <- renderPlot({

    netflix_tv_show_graph_filtered <- netflix_titles3 %>%
      filter(
        type == input$select_content_type) %>%
       # str_count(genre, input$select_genre)) %>%
      group_by(date_year) %>%
      summarize(n = n()) %>%
      drop_na()

  #   out <- netflix_titles3 %>% filter(type == input$select_content_type)
  #   netflix_tv_show_graph_filtered <- str_count(out$genre, "Dramas")
  # 
    ggplot(netflix_tv_show_graph_filtered) +
      geom_col(aes(x = date_year, y = n))
  #   # +
  #   #   labs(title = ('Netflix content added' ),
  #   #        subtitle = ('This plot shows the count of content based on the genre the user selects'),
  #   #        x = NULL, y = NULL)
  # 
   })
  
  # Data table of the tv shows
  output$content_table <- renderDT({
    netflix_titles3 %>%
      filter(
        type %in% input$select_content_type) %>% #, grepl(input$select_genre, genre)) %>%
      select(title, genre, date_added, duration, rating)

  }) 
  
 })







