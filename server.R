library('shiny')
library('ggplot2')
library('dplyr')
library('tidyr')
library('maps')
library('stringr')
library('leaflet')
source('pre-processing.R')

server <- function(input, output) {
  
  current <- reactive({
    return(GetFrame(input$city, input$year))
    
  })
  
  output$rate <- renderPlot({
    
    show.frame <- current() %>% filter(price <= 7500)
    
    ggplot(data = show.frame) +
      geom_point(mapping = aes(x = overall_satisfaction, y = price, color = overall_satisfaction)) +
      labs(title = paste(input$city, ':', input$year))
  })
  
  output$table1 <- renderTable({
    
    show.frame <- current()
    nrow.num <- nrow(show.frame)
    
    sum <- group_by(show.frame, overall_satisfaction) %>% filter(overall_satisfaction > 0) %>%
      summarise(percent = round(n()/nrow.num*100, 2))
    
    names(sum)[1] <- paste0('Overall satisfaction rating (from 1 to 5)')
    names(sum)[2] <- paste0('Percent of ', input$city, ' (%)')
    sum
  })
  
  output$table2 <- renderTable({
    show.frame <- current()
    nrow.num <- nrow(show.frame)
    
    average <- filter(show.frame, bedrooms <= 4) %>%
      group_by(bedrooms) %>% summarise(mean = mean(price))
    
    names(average)[2] <- paste0('Average Price of ', input$city, ' ($)')
    average
  })
  
  output$leaf.map <- renderLeaflet({
    
    show.frame <- current() %>% group_by(neighborhood) %>% top_n(50) %>%
      mutate(popup.info = paste0('<strong>Host id: </strong> ', host_id,
                                 '<br><strong>Neighborhood:</strong> ',neighborhood,
                                 '<br><strong>Overall satisfaction rating</strong>: ', overall_satisfaction,
                                 '<br><strong>Bedrooms:</strong> ', bedrooms,
                                 '<br><strong>Price ($):</strong> ', price))
    
    m <- leaflet(show.frame) %>% addTiles() %>%
      setView(lng = show.frame[[1, "longitude"]], lat = show.frame[[1, "latitude"]], zoom = 12) %>%
      addCircleMarkers(~longitude, ~latitude, popup = ~as.character(popup.info),
                       weight = 3, radius=2, color="red", stroke = TRUE)
      # labs(title = paste('Map for', input$city, 'in the year of', input$year, 'for Airbnb'),
      #      subtitle = paste('this is the interactive map that would show the location of the host for
      #      Airbnb business in the city of', input$city),
      #      x = "Longitude (degree)",
      #      y = "Latitude (degree)")
    #ffa500

    m    
  })
}
