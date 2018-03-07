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
                 tabPanel("Minimum Stay and Reviews"
                          
                          
                          #includeMarkdown("question.four.md")
                 )
)

shinyUI(ui)