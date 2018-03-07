library(sp)
library(leaflet)
circleFun <- function(center = c(0,0),diameter = 1, npoints = 100){
  r = diameter / 2
  tt <- seq(0,2*pi,length.out = npoints)
  xx <- center[1] + r * cos(tt)
  yy <- center[2] + r * sin(tt)
  Sr1 = Polygon(cbind(xx, yy))
  Srs1 = Polygons(list(Sr1), "s1")
  SpP = SpatialPolygons(list(Srs1), 1:1)
  return(SpP)
}
Circle.Town <- circleFun(c(1,-1),2.3,npoints = 100)

df1 <- data.frame(long=c(0.6,1,1.4), lat=c(-2, -.8, -0.2), other=c('a', 'b', 'c'), VAM=c(10,8,6), 
                  type=c('Public', 'Public', 'Private'), id=c(1:3)) %>% 
  mutate(X=paste0('<strong>id: </strong>', 
                  id,
                  '<br><strong>type</strong>: ',
                  type,
                  '<br><strong>VAM</strong>: ',
                  VAM))

# Create a continuous palette function
pal <- colorNumeric(
  palette = "RdYlBu",
  domain = df1$VAM
)

leaflet(height = "400px") %>% 
  addTiles() %>%
  addPolygons(data = Circle.Town, color = 'green',  fillOpacity = .7) %>%
  addCircleMarkers(data = df1, lat = ~lat, lng =~long, 
                   radius = ~VAM, popup = ~as.character(X), 
                   fillColor = ~pal(VAM),
                   stroke = FALSE, fillOpacity = 0.8,
                   clusterOptions = markerClusterOptions()) %>% 
  addLegend(position = "topright",
            pal = pal, values = df1$VAM,
            title = "VAM",
            opacity = 1
  ) %>% 
  setView(lng = 1, lat = -1, zoom = 8)





addCircleMarkers(map, lng = NULL, lat = NULL, radius = 10,
                 layerId = NULL, group = NULL, stroke = TRUE, color = "#03F",
                 weight = 5, opacity = 0.5, fill = TRUE, fillColor = color,
                 fillOpacity = 0.2, dashArray = NULL, popup = NULL,
                 popupOptions = NULL, label = NULL, labelOptions = NULL,
                 options = pathOptions(), clusterOptions = NULL, clusterId = NULL,
                 data = getMapData(map))

popupOptions(maxWidth = 300, minWidth = 50, maxHeight = NULL,
             autoPan = TRUE, keepInView = FALSE, closeButton = TRUE,
             zoomAnimation = TRUE, closeOnClick = NULL, className = "", ...)

addTiles(map, urlTemplate = "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
         attribution = NULL, layerId = NULL, group = NULL,
         options = tileOptions())

library(markdown)

ui <- navbarPage("Airbnb Overview",
                 tabPanel("Home",
                          sidebarLayout(
                            sidebarPanel(
                              radioButtons("plotType", "Plot type",
                                           c("Scatter"="p", "Line"="l")
                              )
                            ),
                            mainPanel(
                              plotOutput("plot")
                            )
                          )
                 ),
                 tabPanel("Summary",
                          verbatimTextOutput("summary")
                 ),
                 
                 navbarMenu("Questions",
                            tabPanel("Question 1",
                                     fluidPage(
                                       sidebarLayout(
                                         sidebarPanel(
                                           
                                           # Input: Select the random distribution type through radio buttons function.
                                           radioButtons("city", "Cities:",
                                                        c('Chicago' = 'chicago', 'Miami' = 'miami', 'New York' = 'new_york',
                                                          'San Diego' = 'san_diego', 'Seattle' = 'seattle')),
                                           
                                           # br() element to introduce extra vertical spacing.
                                           #br(),
                                           
                                           # Input: select input for the number of observations year in the data to generate.
                                           selectInput("year", "Years (from 2015 to 2017:",
                                                       c('2015'=2015, '2016'=2016, '2017'=2017)
                                           ),
                                           
                                           h4('Airbnb Promotional Video:'),
                                           
                                           HTML('<iframe width="560" height="315" src="https://www.youtube.com/embed/XWUeChVZqgw" frameborder="0" allowfullscreen></iframe>')
                                           
                                         ),
                                         
                                         # This is the main page that will appear on the right of the web.
                                         mainPanel(
                                           tabsetPanel(type = "tabs",
                                                       tabPanel("map", leafletOutput('leaf.map')),
                                                       tabPanel('price.rating', plotOutput('rate')),
                                                       tabPanel('Overall Rating and Average Price', tableOutput('table1'),
                                                                tableOutput('table2'))
                                           )
                                         )
                                       )
                                     )
                                     #dataTableOutput("table")
                            ),
                            tabPanel("Question 2"
                                     # fluidRow(
                                     #   column(6,
                                     #          includeMarkdown("about.md")
                                     #   ),
                                     #   column(3,
                                     #          img(class="img-polaroid",
                                     #              src=paste0("http://upload.wikimedia.org/",
                                     #                         "wikipedia/commons/9/92/",
                                     #                         "1919_Ford_Model_T_Highboy_Coupe.jpg")),
                                     #          tags$small(
                                     #            "Source: Photographed at the Bay State Antique ",
                                     #            "Automobile Club's July 10, 2005 show at the ",
                                     #            "Endicott Estate in Dedham, MA by ",
                                     #            a(href="http://commons.wikimedia.org/wiki/User:Sfoskett",
                                     #              "User:Sfoskett")
                                     #          )
                                     #   )
                                     # )
                            )
                 )
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    plot(cars, type=input$plotType)
  })
  
  output$summary <- renderPrint({
    summary(cars)
  })
  
  # output$table <- renderDataTable({
  #   datatable(cars)
  # })
}

shinyApp(ui = ui, server = server)

