
ui <- fluidPage(
  titlePanel('Group Project'),
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
      )

    ),
    
    # This is the main page that will appear on the right of the web.
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("price.rate", plotOutput("rate"), leafletOutput('leaf.map')),
                  tabPanel("price.min", plotOutput('min')),
                  tabPanel('price.bed', plotOutput('bed'))
      )
    )
  )
)

shinyUI(ui)