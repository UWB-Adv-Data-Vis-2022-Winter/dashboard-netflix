library(shiny)
library("DT")

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



  
# bar graph of tv shows count per year 
  netflix_tv_show_graph_filtered <- netflix %>% 
    filter(
      type == "TV Show"
    ) %>%
    group_by(date_year) %>%
    summarize(n = n()) %>% 
    drop_na() 
      
    ggplot(netflix_tv_show_graph_filtered) + 
      geom_col(aes(x = date_year, y = n ))
   
      
 
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

