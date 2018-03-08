source("pre-processing.R")

# need to make this reactive
question4.data <- GetFrame('Seattle', '2015') %>%
  select(room_id, overall_satisfaction, reviews) %>%
  na.omit() %>%
  filter(overall_satisfaction != 0) %>%
  mutate(is_five = (overall_satisfaction == 5))

## based on this plot it is clear that there a lot of reviews with 5 stars
## how realistic is it that there are so many 5 star reviews?
bar.reviews.sat <- ggplot(data = question4.data) +
  geom_bar(mapping = aes(x = overall_satisfaction, fill = reviews))

## based on bar plot, 
# looks like listings below a certain overall satisfaction aren't allowed on the air bnb
# reviews with 5 have the most

pie <- ggplot(data = question4.data, mapping = aes(x = factor(1), fill = factor(is_five))) +
  geom_bar(width = 1) +
  coord_polar(theta="y") + 
  xlab("") + 
  ylab("Number of Reviews") + 
  labs(title = "Percentage of reviews with five star ratings", fill = "Has Five Star Rating")

# scatter plot apping overall satisfcation to number of reviews
scatter.reviews.sat <- ggplot(data = question4.data) + 
  geom_point(mapping = aes(x = overall_satisfaction, y = reviews), position = "jitter") + 
  ylab("number of reviews")

# it is clear that listings with higher ratings tend to have a lot more reviews
# it is possible that these listings might have more "fake reviews" that compensate s
# for bad reviews