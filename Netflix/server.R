library(shiny)
library("DT")
library(lubridate)
library(tidyverse)

shinyServer(function(input, output, session) {
  
  content_list <- unique(netflix_titles3$type)
  netflix_titles3$genre <- strsplit(netflix_titles3$listed_in, ", ")
  netflix_titles3$genre <- names(netflix_titles3$show_id)

  genre_list <- unlist(netflix_titles3$genre) %>%
    unique()
  
updateSelectInput(session, inputId = "select_content_type", choices = content_list)

updateSelectInput(inputId = "select_genre_tv_show", 
                  choices = genre_list)

selected_genre <- reactive({netflix_titles3%>%
  select(genre) %>%
    unlist(recursive = FALSE) %>% 
    enframe() %>% 
  mutate(name = netflix_titles3$show_id) %>%
    unnest() %>%
  filter(value %in% input$selected_genre_tv_show)%>%
    `colnames<-`(c("show_id", "singlegenre"))
  })


    
# bar graph of tv shows count per year    
output$result <- renderText({
  paste(unlist(input$select_genre_tv_show, recursive = FALSE))
})

output$netflix_bar_graph <- renderPlot({
  netflix_titles3 %>% 
    #filter(type %in% input$select_content_type) %>%
    #filter(show_id %in% selected_genre$name) %>%
    group_by(date_year) %>%
    summarize(n = n()) %>% 
    drop_na() %>%
    ggplot() + 
      geom_col(aes(x = date_year, y = n))  
 
})
  
# Data table of the tv shows  
  output$content_table <- renderDT({
    netflix_titles3 %>% 
      #filter(type %in% input$select_content_type) %>%
      #filter(show_id %in% (selected_genre$name)) %>%
      select(title, genre, date_added, duration, rating) 
      
  })
  
  output$shows <- renderDT({
    
    
    titles <- netflix_titles3 %>% 
      #filter(type %in% input$select_content_type) %>%
      #filter(show_id %in% (selected_genre$show_id)) %>%
    select(title, genre, date_added, duration, rating, show_id) 
    
    #selected_genre%>%
    #  left_join(selected_genre, titles) %>% 
     # unique()
      #select(title, genre, date_added, duration, rating)
    
    #subset(show_id %in% selected_genre()$name) %>%
    #select(title, genre, date_added, duration, rating) 
    
  })
  
})
  





