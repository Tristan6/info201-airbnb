# A file handling all data analysis related to question 2
library(RColorBrewer)

airbnb.color.palette <- c("#F16664", "#FFF6E6", "#79CCCD", "#6BB7B9", "#007D8C")

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

CreatePriceReviewScatter <- function(processed.data) {
  scatter.data <- processed.data
  
  # This is a scatterplot of reviews and price colored by the room_type
  price.review.scatter <- ggplot(data = scatter.data) +
    geom_point(mapping = aes(x = reviews, y = price, color = room_type)) +
    scale_color_brewer(palette = 'RdYlGn') +
    scale_y_continuous(breaks = c(0, 1000, 2000, 3000, 4000)) +
    labs(title = paste('Inverse Squared Property: Reviews and Price'))
  
  return(price.review.scatter)
}

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