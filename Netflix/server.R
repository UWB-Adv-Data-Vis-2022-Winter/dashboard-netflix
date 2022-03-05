library(shiny)
library("DT")
library(lubridate)

shinyServer(function(input, output, session) {
  
  netflix <- netflix_titles3
  
  content_list <- unique(netflix_titles3$type)
  
  # create new column for genre
  netflix_titles3$genre <- strsplit(netflix_titles3$listed_in, ", ")
  
  # return unique genre values 
  genre_list <- unlist(netflix_titles3$genre) %>%
    unique()

  
updateSelectInput(session,
                  "select_content_type", choices = content_list)

updateSelectInput(session,
                  "select_genre_tv_show", choices = genre_list)

observe(netflix_tv_show_graph_filtered <- netflix_titles3 %>% 
          filter(type %in% input$select_content_type) %>%
          subset(input$select_genre %in% genre) %>%
          group_by(date_year) %>%
          summarize(n = n()) %>% 
          drop_na()) 
    
# bar graph of tv shows count per year    
output$result <- renderText({
  paste("You chose", unlist(input$select_genre))
})
output$netflix_bar_graph <- renderPlot({
    
    netflix_tv_show_graph_filtered <- netflix_titles3 %>% 
      filter(type %in% input$select_content_type) %>%
      subset(input$select_genre %in% genre) %>%
      group_by(date_year) %>%
      summarize(n = n()) %>% 
      drop_na()
     
    ggplot(netflix_tv_show_graph_filtered) + 
      geom_col(aes(x = date_year, y = n))  
    
    netflix %>% select( )
 
})
  
# Data table of the tv shows  
  output$content_table <- renderDT({
    netflix_titles3 %>% 
      filter(type %in% input$select_content_type) %>%
      subset(input$select_genre %in% genre) %>%
      select(title, genre, date_added, duration, rating) 
      
  })
  
})
  





