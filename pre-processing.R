# A pre-processing file for loading libraries, intially processing the data, and any data 
# manipulation NOT related to the individual analysis questions.

library('shiny')
library('ggplot2')
library('dplyr')
library('tidyr')
library('maps')
library('stringr')
library('leaflet')

# The 'GetFrame' function that will take in 2 argument, one is the input city and input year. Then
# it will return a data frame from the data folder.
GetFrame <- function(city, year) {
  
  path.now <- paste0('data/', city, '/' , 'airbnb-', year, '.csv')
  
  show.frame <- read.csv(file = path.now, stringsAsFactors = FALSE)
  return(show.frame)
}