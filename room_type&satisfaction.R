source('pre-processing.R')

# for testing, remove this line
seattle.2015.data <- GetFrame('Miami', '2015')

# for testing, remove this line
data <- seattle.2015.data

GetRoomTypeVsSatisfaction <- function(data) {
  
  
  # remove zero ratings
  zero.removed <- filter(data, overall_satisfaction != 0)

  # remove blank room_type
  blank.removed <- filter(zero.removed, room_type != "")

}

ggplot(data = GetRoomTypeVsSatisfaction(seattle.2015.data)) +
  geom_jitter(width = 0.19, mapping = aes(x = overall_satisfaction, y = room_type, color = reviews)) +
  scale_colour_gradientn(colours=rainbow(6)) +
  labs(title = paste('Room Type vs. Satisfaction'), color = paste('Number of Ratings'))


# can't get this to work
box.data <- data.frame(
  x = 1,
  data0 <- min(data$overall_satisfaction),
  data25 <- quantile(data$overall_satisfaction, 0.25),
  data50 <- median(data$overall_satisfaction),
  data75 <- quantile(data$overall_satisfaction, 0.75),
  data100 <- max(data$overall_satisfaction)
)

ggplot(df, aes(x)) + 
  geom_boxplot(mapping = aes(ymin = data0, lower = data25, middle = data50, upper = data75, ymax = data100),
             stat = "identity"
             ) 

# Description:
# This visualization compares the room type of the listing with the overall satisfaction rating that the listing recieved. It also shows basic information regarding the number of ratings a listing recieved.
# Because the data has many repeated values and discrete x and y variables, it is organized into a jitter plot. This is different than a traditional scatter plot because instead of overlapping repeating values in the data,
# they are organized into small groups for each room type and value pair. This enables the user to effectively see the frequency of the room type and value pairs for the selected city and year.


# The goal with this particular visualization was to understand if there was relationship between Room Type and Satisfaction. The visualization shows that renting an entire home or apartment is by far the most popular choice for Airbnb users.
# Although there are far less ratings for the shared room type, there is proportionally more spread between ratings, indicating that overall users are less satisfied with shared rooms. This makes sense because private rooms and entire homes and
# apartments are primarily what Airbnb is used for and what made them successful. Shared rooms also introduce more oppurtunites for unpleasant guest experiences.
# 