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
                 tabPanel("Room Type & Satisfaction"
                          
                          
                          #includeMarkdown("question.three.md")
                 ),
                 tabPanel("Satisfaction & Reviews",
                          sidebarLayout(
                            sidebarPanel(
                              
                              # Input: Select the random distribution type through radio buttons function.
                              radioButtons("city.q4", "Cities:",
                                           c('Chicago' = 'chicago', 'Miami' = 'miami', 'New York' = 'new_york',
                                             'San Diego' = 'san_diego', 'Seattle' = 'seattle')),
                              
                              # br() element to introduce extra vertical spacing.
                              br(),
                              
                              # Input: select input for the number of observations year in the data to generate.
                              selectInput("year.q4", "Years (from 2015 to 2017:",
                                          c('2015'=2015, '2016'=2016, '2017'=2017)
                              )
                            ),
                         
                          mainPanel('',
                          plotOutput("bar.graph4"),
                          plotOutput("pie.chart4"),
                          plotOutput("scatter.plot4"),
                          includeMarkdown("question.four.md")
                          )
                 )
)
)

shinyUI(ui)