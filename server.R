library('shiny')
library('ggplot2')
library('dplyr')
library('tidyr')
library('maps')
library('stringr')
library('leaflet')

server <- function(input, output) {
  
  current <- reactive({
    return(GetFrame(input$city, input$year))
    
  })
  
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
  
  output$rate <- renderPlot({
    
    show.frame <- current()
    
    ggplot(data = show.frame) +
      geom_point(mapping = aes(x = overall_satisfaction, y = price)) +
      labs(title = paste(input$city, ':', input$year))
  })
  
  output$min <- renderPlot({
    show.frame <- current()
    
    show.frame <- filter(show.frame, minstay < 50)
    
    ggplot(data = show.frame) +
      geom_point(mapping = aes(x = minstay, y = price))
  })
  
  output$bed <- renderPlot({
    show.frame <- current()
    
    ggplot(data = show.frame) +
      geom_point(mapping = aes(x = bedrooms, y = price))
  })
  
  output$leaf.map <- renderLeaflet({
    
    leaflet() %>%
      addTiles() %>%  # Add default OpenStreetMap map tiles
      addMarkers(lng=-87.58671, lat=41.78887, popup="some where")
  })
  
}