# geting all the needed library and source.
source('Overall_rating.R')
source('room_type&satisfaction.R')
source('inverse-squared.R')
source('pre-processing.R')
source("question4.R")
library("markdown")

# Creating the server for shiny app.
shinyServer(function(input, output, session) {

  # In this section, we will create code for answering question one. It will call helper function
  # from the file 'Overall_rating.R'.
  ##### Question 1 #####
  
  # Creating 3 current reactive for three control which respect to question 1. The 'GetFrame'
  # function will be call.
  current.q1.1 <- reactive({
    return(GetFrame(input$city.q1.1, input$year.q1.1))

  })
  current.q1.2 <- reactive({
    return(GetFrame(input$city.q1.2, input$year.q1.2))
    

  })
  
  current.q1.3 <- reactive({
    return(GetFrame(input$city.q1.3, input$year.q1.3))
    
  })
  
  # Function to create the map by using 'leaflet' library. It will help write less code.
  # The function will make a call to get function 'CreateMap'.
  output$leaf.map <- renderLeaflet({
    CreateMap(current.q1.1())
  })
  
  # Function to create the plot by using 'ggplot2' library.
  # The function will make a call to get function 'CreatePlot'.
  output$rate <- renderPlot({
    CreatePlot(current.q1.2(), input$city.q1.2, input$year.q1.2)
  })
  
  # These two following function that will call function that will create two table for our
  # work. The argument are current frame and input city.
  output$table1 <- renderTable({
    CreateTable1(current.q1.3(), input$city.q1.3)
  })
  
    output$table2 <- renderTable({
    CreateTable2(current.q1.3(), input$city.q1.3)
  })  
  
  #### Question 2 #####
  
    # Call for reative to create factor.
   inverse.squared <- reactive({
   return(CreateRatingsFactor(current.q2()))
   })
  
    # Call for reactive for current infor that can be later from page.
  current.q2 <- reactive({
    return(GetFrame(input$city.q2, input$year.q2))
  })
  
  # This is a scatterplot
  output$scatter <- renderPlot({
    CreatePriceReviewScatter(inverse.squared())
  })
  
  # Creating pie chart.
  output$pie <- renderPlot({
    CreatePieChart(inverse.squared())
  })

  
  #### Question 3 space #####
  current.q3 <- reactive({
    return(GetFrame(input$city.q3, input$year.q3))
    
  })
  
  output$jitter <- renderPlot({
    CreateJitter(GetRoomTypeVsSatisfactionData(current.q3()))
  })

  #### Question 3 space #####
  

  #### Question 4 space #####
  current.q4 <- reactive({
    return(GetFrame(input$city.q4, input$year.q4))
  })
  
  question4.data.frame <- reactive({
    return(getDataFrame4(current.q4()))
  })
  
  output$bar.graph4 <- renderPlot({
    getBarGraphReviews(question4.data.frame())
  })
  
  output$pie.chart4 <- renderPlot({
    getPieReviews(question4.data.frame())
  })
  
  output$scatter.plot4 <- renderPlot({
    getScatterReviews(question4.data.frame())
  }) 
  #### Question 4 space #####

})
