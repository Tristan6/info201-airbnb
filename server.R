source('Overall_rating.R')
source('room_type&satisfaction.R')
source('inverse-squared.R')
source('pre-processing.R')

library("markdown")

shinyServer(function(input, output, session) {
  

  ##### Question 1 #####
  current.q1.1 <- reactive({
    return(GetFrame(input$city.q1.1, input$year.q1.1))

  })
  current.q1.2 <- reactive({
    return(GetFrame(input$city.q1.2, input$year.q1.2))
    

  })
  
  current.q1.3 <- reactive({
    return(GetFrame(input$city.q1.3, input$year.q1.3))
    
  })
  
  output$leaf.map <- renderLeaflet({
    CreateMap(current.q1.1())
  })
  
  output$rate <- renderPlot({
    CreatePlot(current.q1.2(), input$city.q1.2, input$year.q1.2)
  })
  
  output$table1 <- renderTable({
    CreateTable1(current.q1.3(), input$city.q1.3)
  })
  
    output$table2 <- renderTable({
    CreateTable2(current.q1.3(), input$city.q1.3)
  })  
  
  #### Question 2 #####

   inverse.squared <- reactive({
   return(CreateRatingsFactor(current.q2()))
   })
  
  current.q2 <- reactive({
    return(GetFrame(input$city.q2, input$year.q2))
  })
  
  # This is a scatterplot
  output$scatter <- renderPlot({
    CreatePriceReviewScatter(inverse.squared())
  })
  
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
  
 
  #### Question 4 space #####c

})
