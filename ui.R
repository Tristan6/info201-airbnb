library('leaflet')

# The ui variable that will be used to create shiny later.
ui <- navbarPage("Airbnb Overview",
                 
                 # The 'home' tab that will show up first to the users.
                 tabPanel("Home",
                          includeMarkdown("home.md")
                          ),
            
                 # The 'navbarMenu' that wil analys the first question in our group. It also include widgets and
                 # main page for three part.
                 navbarMenu("Overall Rating & Price",
                            
                          # The pannel for map with widgets control for city and year.
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
                          
                          # The pannel for plot with widgets control for city and year.
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
                          
                          # The pannel for table with widgets control for city and year.
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
                                     
                                     mainPanel('',includeMarkdown("markdown/table.md") , h4('Table 1: Overall Rating and Percentage.'), tableOutput('table1'),
                                                        h4('Table 2: Bedrooms and Average Price'), tableOutput('table2')
                                   )
                          )
                          )
                 ),
                 
                 # The panel to see the relationship between data plot and pie chart.
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

                 # The panel to see if there relationship between room and overall satisfaction rating.
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
                 
                 # The last panel to see if there is relationship between reivew and rating score.
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