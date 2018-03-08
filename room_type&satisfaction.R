source('pre-processing.R')


GetRoomTypeVsSatisfaction <- function(data) {
  processed.data <- data
  
  # remove zero ratings
  zero.removed <- filter(data, overall_satisfaction != 0)

  # remove blank room_type
  blank.removed <- filter(zero.removed, room_type != "")
  
  return(processed.data)
}

CreateJitter <- function(processed.data) {
 
  jitter.data <- processed.data
 
  ggplot(data = jitter.data) +
    geom_jitter(width = 0.19, mapping = aes(x = overall_satisfaction, y = room_type, color = reviews)) +
    scale_colour_gradientn(colours=rainbow(6)) +
    labs(title = paste('Room Type vs. Satisfaction'), color = paste('Number of Ratings'))

}


