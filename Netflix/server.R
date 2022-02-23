library(shiny)
library("DT")



shinyServer(function(input, output) {
  netflix <- netflix_titles3
  
  
  output$tv_shows <- renderDT({
    netflix %>% 
      select(title, genre, date_added, duration, rating)
      
  })
  
  output$movies <- renderDT({
    netflix %>% 
      select(title, genre, date_added, duration, rating)
  })

  
})

