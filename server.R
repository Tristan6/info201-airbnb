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
  
  output$min <- renderPlot({
    show.frame <- current()
    
    show.frame <- filter(show.frame, minstay < 50)
    
    ggplot(data = show.frame) +
      geom_point(mapping = aes(x = minstay, y = price)) +
      labs(title = paste('Lorem ipsum'))
  })
  
  output$bed <- renderPlot({
    show.frame <- current()
    
    ggplot(data = show.frame) +
      geom_point(mapping = aes(x = bedrooms, y = price)) +
      labs(title = paste('Lorem ipsum'))
  })
  
  output$leaf.map <- renderLeaflet({
    
    leaflet() %>%
      addTiles() %>%  # Add default OpenStreetMap map tiles
      addMarkers(lng=-87.6251, lat=41.8786, popup="test")
  })
  
}

shinyServer(server)