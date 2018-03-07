### Conclusions from Analysis of Reviews and Price

One of the most interesting conclusions found from analyzing the reviews and price columns was their unusual relationship.
Regardless of what city or year is chosen, the data very closely follows an inverse squared relationship. This is relationship
is sometimes called the inverse-squared law and is most commonly associated with force of gravity and illumination.

Less related to the relationship of the axis, the majority of the ratings (overall_satisfaction)
were five stars. This is important because the less expensive listings had the most amount of reviews (meaning people visited frequently)
though these listings still managed to get a five star rating. One conclusion is that hospitality is more important to this business
than is luxury. Another conclusion could be that the customers experience 'good deal' effect, meaning they feel like they are getting
a good price for the room they stayed in.

Jimmy's Youtube Embed:
<iframe width="560" height="315" src="https://www.youtube.com/embed/XWUeChVZqgw" frameborder="0" allowfullscreen></iframe>

Adharsh may want this:
HandleMissingData <- function(year) {
  if(year == 2017) {
    na.message <- "In 2017 the minstay column has missing data. Please choose a different year"
    return(na.message)
  } else {
    return("")
  }
}
