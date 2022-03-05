library(shiny)
library("DT")
library(lubridate)
library(tidyverse)

shinyServer(function(input, output, session) {
#load data and lists  
  content_list <- unique(netflix_titles3$type)
  netflix_titles3$genre <- strsplit(netflix_titles3$listed_in, ", ")
  names(netflix_titles3$genre) <- netflix_titles3$show_id

  genre_list <- unlist(netflix_titles3$genre) %>%
    unique()

  output$genre <- renderUI({
    selectInput("select_genre_tv_show", label = h3(" Select Genre"),
                choices = genre_list, multiple = TRUE, selected  = "Dramas")
  })
  output$type <- renderUI({
    selectInput("select_content_type", label = h3(" Select Content"), 
                            choices = content_list, selected  = NULL)
  })
  
  # Filtered data
  selected_genre <- reactive({
    netflix_titles3%>%
      select(genre) %>%
      unlist(recursive = FALSE) %>% 
      enframe() %>% 
      mutate(name = netflix_titles3$show_id) %>%
      unnest(value) %>%
      filter(value %in% input$type)%>%
      `colnames<-`(c("show_id", "singlegenre"))
  })
  
  data_filtered <- reactive({
    netflix_titles3 %>% 
    filter(genre %in% selected_genre(),
           type %in% type())
  })
  
  # Get filters from inputs
  # genre <- reactive({
  #   if (is.null(input$genre)) unique(netflix_titles3$genre) else input$genre
  # })
  
  # type <- reactive({
  #   if (is.null(input$type)) unique(df$type) else input$type
  # })
    
# bar graph of tv shows count per year    
output$result <- renderText({
  paste(unlist(input$select_genre_tv_show, recursive = FALSE))
})

output$netflix_bar_graph <- renderPlot({
  
  # data_filtered() %>%
  #   group_by(date_year) %>%
  #   summarize(n = n()) %>% 
  #   drop_na() %>%
  selected_genre() %>% 
    group_by(single_genre) %>%
    summarize(n = n()) %>% 
    drop_na() %>%
     ggplot() + 
       geom_col(aes(x = singlegenre, y = n))  
 
})
  
# Data table of the tv shows  
  
  output$shows <- renderDT({
    titles <- netflix_titles3 %>% 
      filter(type %in% input$type) %>%
      filter(genre %in% (input$genre)) %>%
    select(title, genre, date_added, duration, rating, show_id) 
    
    #selected_genre%>%
    #  left_join(selected_genre, titles) %>% 
     # unique()
      #select(title, genre, date_added, duration, rating)
    
    #subset(show_id %in% selected_genre()$name) %>%
    #select(title, genre, date_added, duration, rating) 
    
  })
  
})
  







