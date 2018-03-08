library('leaflet')

ui <- navbarPage("Airbnb Overview",
                 tabPanel("Home",
                          includeMarkdown("home.md")
                          ),
            
                 navbarMenu("Overall Rating & Price",
                          tabPanel('Interactive Map',
                                   sidebarLayout(
                                     sidebarPanel(
                                       
                                       # Input: Select the random distribution type through radio buttons function.
                                       radioButtons("city.q1.1", "Cities:",
                                                    c('Chicago' = 'chicago', 'Miami' = 'miami', 'New York' = 'new_york',
                                                      'San Diego' = 'san_diego', 'Seattle' = 'seattle')),
                                       
                                       # br() element to introduce extra vertical spacing.
                                       br(),
                                       
                                       # Input: select input for the number of observations year in the data to generate.
                                       selectInput("year.q1.1", "Years (from 2015 to 2017:",
                                                   c('2015'=2015, '2016'=2016, '2017'=2017)
                                       )
                                     ),
                                     
                                     mainPanel("",includeMarkdown("markdown/map.md") , leafletOutput('leaf.map'))
                                   )
                          ),
                          
                          tabPanel('Data Plot',
                                   sidebarLayout(
                                     sidebarPanel(
                                       
                                       # Input: Select the random distribution type through radio buttons function.
                                       radioButtons("city.q1.2", "Cities:",
                                                    c('Chicago' = 'chicago', 'Miami' = 'miami', 'New York' = 'new_york',
                                                      'San Diego' = 'san_diego', 'Seattle' = 'seattle')),
                                       
                                       # br() element to introduce extra vertical spacing.
                                       br(),
                                       
                                       # Input: select input for the number of observations year in the data to generate.
                                       selectInput("year.q1.2", "Years (from 2015 to 2017:",
                                                   c('2015'=2015, '2016'=2016, '2017'=2017)
                                       )
                                     ),
                                     
                                     mainPanel('',includeMarkdown("markdown/plot.md") , plotOutput('rate'))
                                   )
                          ),
                          
                          tabPanel('Overall Satisfaction and Price Table',
                                   sidebarLayout(
                                     sidebarPanel(
                                       
                                       # Input: Select the random distribution type through radio buttons function.
                                       radioButtons("city.q1.3", "Cities:",
                                                    c('Chicago' = 'chicago', 'Miami' = 'miami', 'New York' = 'new_york',
                                                      'San Diego' = 'san_diego', 'Seattle' = 'seattle')),
                                       
                                       # br() element to introduce extra vertical spacing.
                                       br(),
                                       
                                       # Input: select input for the number of observations year in the data to generate.
                                       selectInput("year.q1.3", "Years (from 2015 to 2017:",
                                                   c('2015'=2015, '2016'=2016, '2017'=2017)
                                       )
                                     ),
                                     
                                     mainPanel('',includeMarkdown("markdown/table.md") , tableOutput('table1'),
                                                        tableOutput('table2')
                                   )
                          )
                          )
                 ),
                 tabPanel("Inverse Squared Relationship",
                          sidebarLayout(
                            sidebarPanel(
                              # Input: Select the random distribution type through radio buttons function.
                              radioButtons("city.q2", "Cities:",
                                           c('Chicago' = 'chicago', 'Miami' = 'miami', 'New York' = 'new_york',
                                             'San Diego' = 'san_diego', 'Seattle' = 'seattle')
                              ),
                              br(),
                              
                              # Input: select input for the number of observations year in the data to generate.
                              selectInput("year.q2", "Years (from 2015 to 2017:",
                                          c('2015'=2015, '2016'=2016, '2017'=2017)
                              )
                            ),
                            
                            # This is the main page that will appear on the right of the web.
                            mainPanel(
                              plotOutput('scatter'),
                              br(),
                              plotOutput('pie'),
                              includeMarkdown("markdown/question.two.md")
                            )
                          )
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