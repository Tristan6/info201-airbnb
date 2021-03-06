source("pre-processing.R")

# need to make this reactive
getDataFrame4 <- function(data) {
  question4.data <- data %>%
    select(room_id, overall_satisfaction, reviews) %>%
    na.omit() %>%
    filter(overall_satisfaction != 0) %>%
    mutate(is_five = (overall_satisfaction == 5))
  return(question4.data)
}

## based on this plot it is clear that there a lot of reviews with 5 stars
## how realistic is it that there are so many 5 star reviews?
getBarGraphReviews <- function(question4.data) {
    bar.reviews.sat <- ggplot(data = question4.data) +
    geom_bar(mapping = aes(x = overall_satisfaction, fill = reviews)) + 
    ylab("Number of listings") + 
    labs(title = "Number of Listings with Overall Satisfaction Rating")
  return(bar.reviews.sat)
}

## based on bar plot, 
# looks like listings below a certain overall satisfaction aren't allowed on the air bnb
# reviews with 5 have the most
getPieReviews <- function(question4.data) {
  pie <- ggplot(data = question4.data, mapping = aes(x = factor(1), fill = factor(is_five))) +
    geom_bar(width = 1) +
    coord_polar(theta="y") + 
    xlab("") + 
    ylab("Number of Reviews") + 
    labs(title = "Overall Satisfaction Equal and Not Equal to 5", fill = "Has Five Star Rating") 
  return(pie)
}

# scatter plot apping overall satisfcation to number of reviews
getScatterReviews <- function(question4.data) {
  scatter.reviews.sat <- ggplot(data = question4.data) + 
    geom_point(mapping = aes(x = overall_satisfaction, y = reviews), position = "jitter") + 
    ylab("number of reviews") + 
    labs(title = "Number of Reviews vs. Overall Satisfaction")
  return(scatter.reviews.sat)
}

# it is clear that listings with higher ratings tend to have a lot more reviews
# it is possible that these listings might have more "fake reviews" that compensate s
# for bad reviews