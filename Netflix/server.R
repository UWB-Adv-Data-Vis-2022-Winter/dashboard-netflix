library(shiny)
library("DT")



shinyServer(function(input, output) {
  netflix <- netflix_titles3
# bar graph of tv shows count per year 
  output$tv_shows_graph <- renderPlot({
    
    netflix_tv_show_graph_filtered <- netflix %>% 
      filter(
        type == "TV Show"
      ) %>%
      group_by(date_year) %>%
      summarize(n = n()) %>% 
      drop_na()
      
    ggplot(netflix_tv_show_graph_filtered) + 
      geom_col(aes(x = date_year, y = n ))
      
  }) 
# Data table of the tv shows  
  output$tv_shows <- renderDT({
    netflix %>% 
      filter(
        type == "TV Show"
      )  %>%
      select(title, genre, date_added, duration, rating) 
      
  })
# bar graph of movie count per year   
  output$movies_graph <- renderPlot({
    
    netflix_movies_graph_filtered <- netflix %>% 
      filter(
        type == "Movie"
      ) %>%
      group_by(date_year) %>%
      summarize(n = n())
    
    ggplot(netflix_movies_graph_filtered) + 
      geom_col(aes(x = date_year, y = n ))
    
  })
# data table for movies 
  output$movies <- renderDT({
    netflix %>% 
      filter(
        type == "Movie"
      )  %>%
      select(title, genre, date_added, duration, rating) 
  })

  
})

