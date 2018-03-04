# A pre-processing file for loading libraries, intially processing the data, and any data 
# manipulation NOT related to the individual analysis questions.



library('shiny')
library('ggplot2')
library('dplyr')
library('tidyr')
library('maps')
library('stringr')
library('leaflet')

GetFrame <- function(city, year) {
  
  path.now <- paste0('./data', '/', city, '/' , year)
  files <- list.files(path = path.now, pattern = '*airbnb')
  
  num <- 2
  show.frame <- read.csv(file = paste0(path.now, '/', files[1]), stringsAsFactors = FALSE)
  while (num <= length(files)) {
    now.frame <- read.csv(file = paste0(path.now, '/', files[num]), stringsAsFactors = FALSE)
    
    show.frame <- rbind(show.frame, now.frame)
    
    num <- num + 1
  }
  return(show.frame)
}