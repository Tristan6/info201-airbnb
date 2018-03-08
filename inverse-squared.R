# A file handling all data analysis related to question 2
library(RColorBrewer)

# Used for each visualization
airbnb.color.palette <- c("#F16664", "#FFF6E6", "#79CCCD", "#6BB7B9", "#007D8C")

# Takes the reactive function from the server as input and tailors the data set towards this 
# analysis question.
CreateRatingsFactor <- function(reactive.data) {
  processed.data <- reactive.data
  
  cols.of.interest <- c("room_type", "reviews", "overall_satisfaction", "price")
  
  # Gets rid of listings with NA or non-values in the room_type, reviews, and 
  # overall_satisfaction columns. This also removes unrepresentative outliers.
  processed.data <- processed.data %>% 
    select(cols.of.interest) %>% 
    filter(price < 4000 & !room_type == "" & !is.na(reviews) & 
             !is.na(overall_satisfaction)) #%>% 
  
  return(processed.data)
}

# Takes as input a reactive function (which returns the above function) and uses the data set to 
# return a scatterplot of price and review data, colored by the room type.
CreatePriceReviewScatter <- function(processed.data) {
  scatter.data <- processed.data
  
  # This is a scatterplot of reviews and price colored by the room_type
  price.review.scatter <- ggplot(data = scatter.data) +
    geom_point(mapping = aes(x = reviews, y = price, color = room_type)) +
    scale_color_manual(values = airbnb.color.palette) +
    scale_y_continuous(breaks = c(0, 1000, 2000, 3000, 4000)) +
    labs(title = paste('Inverse Squared Relationship: Reviews vs Price'), 
         x = 'number of reviews', y = 'price per night (in dollars)')
  
  return(price.review.scatter)
}

# Takes as input a reactive function (which returns the above function) and uses the data set to 
# return a pie chart of with percentages of each room type in the selected city and year adding
# clarity to the previous visualization.
CreatePieChart <- function(processed.data) {
  pie.data <- processed.data %>% 
    select(room_type)

  # Creates a vector with the counts of each room_type 
  slices <- pie.data %>% filter(room_type == "Entire home/apt") %>% nrow()
  slices[2] <- pie.data %>% filter(room_type == "Private room") %>% nrow()
  slices[3] <- pie.data %>% filter(room_type == "Shared room") %>% nrow()
  
  # This will turn into wedge labels
  lbls <- c("Entire Home/apt", "Private Room", "Shared Room")
  
  # Create percentages based on the room_type ratios
  pct <- round((slices/sum(slices)*100), 1)

  # add percents and % symbol to labels 
  lbls <- paste0(lbls, " (", pct, "%", ")")
  
  # Make an RColorBrewer Palette available in R
  pie.color <- brewer.pal(3, 'RdYlGn')
  
  # A Pie Chart with percentage and room_type labels for each wedge
  pie <- pie(slices,labels = lbls, col = airbnb.color.palette,
      main="Pie Chart of Countries")
  
  return(pie)
}