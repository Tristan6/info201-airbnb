source('pre-processing.R')

server <- function(input, output) {
  
  current <- reactive({
    return(GetFrame(input$city, input$year))
    
  })
  
  output$rate <- renderPlot({
    
    show.frame <- current()
    
    ggplot(data = show.frame) +
      geom_point(mapping = aes(x = overall_satisfaction, y = price)) +
      labs(title = paste('Lorem ipsum'))
  })
  
  output$leaf.map <- renderLeaflet({
    
    # leaflet() %>%
    # addTiles() %>%  # Add default OpenStreetMap map tiles
    # addMarkers(lng=-87.6251, lat=41.8786, popup="test")

    
    show.frame <- current() %>% filter(overall_satisfaction > 0)
    
    m <- leaflet(show.frame) %>% addTiles() %>%
      setView(lng = show.frame[[1, "longitude"]], lat = show.frame[[1, "latitude"]], zoom = 12) %>%
      addCircles(~longitude, ~latitude, popup=show.frame$host_id, weight = 3, radius=5,
                 color="#ffa500", stroke = TRUE, fillOpacity = 0.8)
    
    m    
  })
  
  output$min <- renderPlot({
    CreateMinStayScatter(current())
  })
  
  output$bed <- renderPlot({
    show.frame <- current()
    
    ggplot(data = show.frame) +
      geom_point(mapping = aes(x = bedrooms, y = price)) +
      labs(title = paste('Lorem ipsum'))
  })
  
}

shinyServer(server)
