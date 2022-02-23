library(shiny)
library("DT")



shinyServer(function(input, output) {
  netflix <- netflix_titles3
  
  output$tv_shows_graph <- renderPlot({
    
    netflix_graph_filtered <- netflix %>% 
      filter(
        type == "TV Show"
      ) %>%
      group_by(date_year) %>%
      summarize(n = n())
      
    ggplot(netflix_graph_filtered) + 
      geom_col(aes(x = date_year, y = n ))
      
  }) 
  
  output$tv_shows <- renderDT({
    netflix %>% 
      filter(
        type == "TV Show"
      )  %>%
      select(title, genre, date_added, duration, rating) 
      
  })
  
  output$movies <- renderDT({
    netflix %>% 
      filter(
        type == "Movie"
      )  %>%
      select(title, genre, date_added, duration, rating) 
  })

  
})

