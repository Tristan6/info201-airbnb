# The function 'CreateMap' that will draw a map in our shiny app. It will take in one argumet
# which is the data frame. It will draw using leafLet.
CreateMap <- function(show.frame) {
  
  # Mutate the table to add one more column 'popup.info' which can be use for infor for popup.
  show.frame <- show.frame %>% group_by(neighborhood) %>% top_n(10) %>%
    mutate(popup.info = paste0('<strong>Host id: </strong> ', host_id,
                               '<br><strong>Neighborhood:</strong> ',neighborhood,
                               '<br><strong>Overall satisfaction rating</strong>: ', overall_satisfaction,
                               '<br><strong>Bedrooms:</strong> ', bedrooms,
                               '<br><strong>Price ($):</strong> ', price))
  
  m <- leaflet(show.frame) %>% addTiles() %>%
    setView(lng = show.frame[[1, "longitude"]], lat = show.frame[[1, "latitude"]], zoom = 12) %>%
    addCircleMarkers(~longitude, ~latitude, popup = ~as.character(popup.info),
                     weight = 3, radius=2, color="red", stroke = TRUE)
  
  return(m)    
  
}

# The function 'CreatePlot' that will create a scatter plot which take in three argument, the data
# frame, input city and input year.
CreatePlot <- function(show.frame, city, year) {
  
  show.frame <- show.frame %>% filter(price <= 7500) %>%
    filter(overall_satisfaction > 0)
  
  p <- ggplot(data = show.frame) +
    geom_point(mapping = aes(x = overall_satisfaction, y = price, color = overall_satisfaction)) +
    labs(title = paste('Plot for', city, 'in the year of', year, 'for Airbnb'),
         subtitle = paste('this is the data plot that would show the overall rating vs. the 
                          of the price for Airbnb business in the city of', city),
         x = "Overall Rating (From 1 to 5)",
         y = "Price ($)")
  
  return(p)
  
}

# The function 'CreateTable1' which take in the data frame and input city as argument and it will
# create a table for view.
CreateTable1 <- function(show.frame, city) {
  
  nrow.num <- nrow(show.frame)
  
  sum <- group_by(show.frame, overall_satisfaction) %>% filter(overall_satisfaction > 0) %>%
    summarise(percent = round(n()/nrow.num*100, 2))
  
  names(sum)[1] <- paste0('Overall satisfaction rating (from 1 to 5)')
  names(sum)[2] <- paste0('Percent of ', city, ' (%)')
  return(sum)
}

# The function 'CreateTable2' which take in the data frame and input city as argument and it will
# create a table for view.
CreateTable2 <- function(show.frame, city) {
  
  nrow.num <- nrow(show.frame)
  
  average <- filter(show.frame, bedrooms <= 4) %>%
    group_by(bedrooms) %>% summarise(mean = mean(price))
  
  names(average)[2] <- paste0('Average Price of ', city, ' ($)')
  return(average)
}

