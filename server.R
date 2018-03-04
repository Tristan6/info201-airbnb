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
  
  output$leaf.map <- renderLeaflet({
    
    # leaflet() %>%
    #   addTiles() %>%  # Add default OpenStreetMap map tiles
    #   addMarkers(lng=-87.58671, lat=41.78887, popup="some where")
    
    show.frame <- current() %>% filter(overall_satisfaction > 0)
    
    m <- leaflet(show.frame) %>% addTiles() %>%
      setView(lng = show.frame[[1, "longitude"]], lat = show.frame[[1, "latitude"]], zoom = 12) %>%
      addCircles(~longitude, ~latitude, popup=show.frame$host_id, weight = 3, radius=5,
                     color="#ffa500", stroke = TRUE, fillOpacity = 0.8)

    m    
  })
}
