# testing 
library(readr)
library(tidyverse)
library(dplyr)
library(lubridate, warn.conflicts = FALSE)


# View Dataset
netflix_titles <- read_csv("data/netflix_titles.csv")
View(netflix_titles)

# replace empty cells with "NA"
netflix_titles2 <- read.csv("data/netflix_titles.csv", header = TRUE, na.strings = "")
View(netflix_titles2)

# view distinct types of shows 
unique(netflix_titles2$type)

# view distinct type of countries 
unique(netflix_titles2$country)

# Show distinct count of countries 
netflix_titles2 %>% 
  as_tibble() %>%
  count(country) 

#count of type by distinct 
netflix_titles2 %>% count(type)

# remove na rows , return 5300 rows
netflix_titles3 <- netflix_titles2 %>% na.omit()
View(netflix_titles3)

 
str_split()

# strsplit(netflix_titles3$country, ", ")

# create new column for genre
netflix_titles3$genre <- strsplit(netflix_titles3$listed_in, ", ")
View(netflix_titles3)

# return unique genre values 
unlist(netflix_titles3$genre) %>%
  unique()

# Convert chr to date for date_added 
netflix_titles3$date_added <- dmy(netflix_titles3$date_added)
View(netflix_titles3)

netflix_titles3[is.Date(netflix_titles3$date_added) == FALSE,]

# Convert date format from yyyy-mm-dd to yyyy-mm
netflix_titles3$date_year_month <- format(as.Date(netflix_titles3$date_added, "%Y-%m-%d"), "%Y-%m")
View(netflix_titles3)

# Drop description column
netflix_titles3$description <- NULL
View(netflix_titles3)


write_csv(netflix_titles3, "processed_netflix.csv")

