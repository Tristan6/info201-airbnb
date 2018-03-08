library('leaflet')

ui <- navbarPage("Airbnb Overview",
                 tabPanel("Home",
                          includeMarkdown("home.md")
                 ),
                 
                 # this is jimmys
                 navbarMenu("Overall Rating & Price",
                            tabPanel('Map',
                              sidebarLayout(
                                sidebarPanel(
                                  
                                  # Input: Select the random distribution type through radio buttons function.
                                  radioButtons("city", "Cities:",
                                               c('Chicago' = 'chicago', 'Miami' = 'miami', 'New York' = 'new_york',
                                                 'San Diego' = 'san_diego', 'Seattle' = 'seattle')),
                                  
                                  # br() element to introduce extra vertical spacing.
                                  br(),
                                  
                                  # Input: select input for the number of observations year in the data to generate.
                                  selectInput("year", "Years (from 2015 to 2017:",
                                              c('2015'=2015, '2016'=2016, '2017'=2017)
                                  )
                                ),
                                
                                mainPanel()
                              )
                            )
                 ),
                 tabPanel("Inverse Squared Relationship",
                          
                          plotOutput('scatter')
                          #includeMarkdown("question.two.md")
                 ),
                 tabPanel("Room Type & Satisfaction"
                          
                          
                          #includeMarkdown("question.three.md")
                 ),
                 tabPanel("Minimum Stay and Reviews"
                          
                          
                          #includeMarkdown("question.four.md")
                 )
)

shinyUI(ui)

source('pre-processing.R')
library("markdown")

server <- function(input, output, session) {
  
  current <- reactive({
    return(GetFrame(input$city, input$year))
    
  })
  
  #### Question 1 space #####
  
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
    
    show.frame <- current() %>% group_by(neighborhood) %>% top_n(10) %>%
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
  
  
  #### Question 1 space #####
  
  
  
  #### Question 2 space #####
  
  
  
  #### Question 2 space #####
  
  #### Question 3 space #####
  
  
  #### Question 3 space #####
  
  
  #### Question 4 space #####
  
  
  #### Question 4 space #####c
  
}

shinyApp(ui = ui, server = server)
