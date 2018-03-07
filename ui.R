library('leaflet')

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
                 
                 # this is jimmys
                 navbarMenu("Overall Rating & Price",
                            tabPanel("Overall Rating & Price",
                                     #dataTableOutput("table")
                                     uiOutput("question.one")
                            ),
                            tabPanel(""
                                     
                            ),
                            tabPanel(""
                                     #dataTableOutput("table")
                            ), 

                 ),
                 tablPanel("Inverse Squared Relationship",
                           plotOutput('scatter'),
                           uiOutput("question.two")
                           ),
                 tabPanel("Room Type & Satisfaction",
                          uiOutput("question.three")
                 ),
                 tabPanel("Minimum Stay and Reviews",
                          uiOutput("question.four")
                 )
)

shinyUI(ui)