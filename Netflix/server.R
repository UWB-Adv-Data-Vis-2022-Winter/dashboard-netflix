library(shiny)
library("DT")
library(lubridate)

shinyServer(function(input, output, session) {
  
  #netflix_titles3<- read_csv("processed_netflix.csv")
  netflix <- netflix_titles3
  
  content_list <- unique(netflix_titles3$type)
  
  # create new column for genre
  netflix_titles3$genre <- strsplit(netflix_titles3$listed_in, ", ")
  netflix_titles3$genre <- names(netflix_titles3$show_id)
  
  # return unique genre values 
  genre_list <- unlist(netflix_titles3$genre) %>%
    unique()
  
updateSelectInput(session, inputId = "select_content_type", choices = content_list)

updateSelectInput(inputId = "select_genre_tv_show", 
                  choices = genre_list)

reactive({selected_genre <- netflix_titles3%>%
  select(genre) %>%
    unlist(recursive = FALSE) %>% 
    enframe() %>% 
  mutate(name = netflix_titles3$show_id) %>%
    unnest() %>%
  filter(value %in% input$selected_genre_tv_show)
  })

    
# bar graph of tv shows count per year    
output$result <- renderText({
  paste("You chose", input$select_genre_tv_show)
})
output$netflix_bar_graph <- renderPlot({
  netflix_titles3 %>% 
    filter(type %in% input$select_content_type) %>%
    filter(show_id %in% selected_genre$name) %>%
    group_by(date_year) %>%
    summarize(n = n()) %>% 
    drop_na() %>%
    ggplot() + 
      geom_col(aes(x = date_year, y = n))  
 
})
  
# Data table of the tv shows  
  output$content_table <- renderDT({
    netflix_titles3 %>% 
       filter(type %in% input$select_content_type) %>%
      filter(show_id %in% (selected_genre$name))
      select(title, genre, date_added, duration, rating) 
      
  })
  
  output$shows <- renderDT({
    
    colnames(selected_genre) <- c("show_id", "singlegenre")
    titles <- netflix_titles3 %>% 
      #filter(type %in% input$select_content_type) %>%
      filter(show_id %in% (selected_genre$show_id)) %>%
    select(title, genre, date_added, duration, rating, show_id) 
    
    #selected_genre%>%
    #  left_join(selected_genre, titles) %>% 
     # unique()
      #select(title, genre, date_added, duration, rating)
    
    #subset(show_id %in% selected_genre()$name) %>%
    #select(title, genre, date_added, duration, rating) 
    
  })
  
})
  





