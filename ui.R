library('leaflet')

ui <- navbarPage("Airbnb Overview",
                 tabPanel("Home",
                          includeMarkdown("home.md")
                          ),
            
                 # this is jimmys
                 navbarMenu("Overall Rating & Price",
                            tabPanel("map"
                                     #dataTableOutput("table")
                                     #includeMarkdown("question.one.md")
                            ),
                            tabPanel("plot"
                                     
                            ),
                            tabPanel("table"
                                     #dataTableOutput("table")
                            ) 

                 ),
                 tabPanel("Inverse Squared Relationship",
                           
                           plotOutput('scatter')
                          #includeMarkdown("question.two.md")
                           ),
                 tabPanel("Room Type & Satisfaction",
                          sidebarLayout(
                            sidebarPanel(
                              # Input: Select the random distribution type through radio buttons function.
                              radioButtons("city.q3", "Cities:",
                                           c('Chicago' = 'chicago', 'Miami' = 'miami', 'New York' = 'new_york',
                                             'San Diego' = 'san_diego', 'Seattle' = 'seattle')
                              ),
                              
                              br(),
                              
                              # Input: select input for the number of observations year in the data to generate.
                              selectInput("year.q3", "Years (from 2015 to 2017:",
                                          c('2015'=2015, '2016'=2016, '2017'=2017)
                              )
                            ),
                            
                            # This is the main page that will appear on the right of the web.
                            mainPanel(
                              plotOutput('jitter'),
                              includeMarkdown("markdown/question.three.md")
                            )
                          )
                 ),
                 
                 tabPanel("Minimum Stay and Reviews"
                          
                          
                          #includeMarkdown("question.four.md")
                 )
)

shinyUI(ui)