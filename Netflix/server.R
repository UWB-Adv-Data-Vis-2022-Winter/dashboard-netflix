library(shiny)
library("DT")



shinyServer(function(input, output) {
  netflix <- netflix_titles3
  
#  output$tv_shows_graph <- renderPlot({
#    netflix %>% 
#      filter(
#        type == "Tv Show"
#      )
#  }) 
  
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

