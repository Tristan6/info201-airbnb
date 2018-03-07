source('pre-processing.R')
source('inverse-squared.R')
library("markdown")

shinyServer(function(input, output, session) {
  
  current <- reactive({
    return(GetFrame(input$city, input$year))
    
  })
  
  inverse.squared <- reactive({
    return(CreateRatingsFactor(current()))
  })
  
  #### Question 1 space #####
  
  

  #### Question 1 space #####
  
  #### Question 2 space #####
  
  output$scatter <- renderPlot({
    CreatePriceReviewScatter(inverse.squared())
  })
  
  output$pie <- renderPlot({
    CreatePieChart(inverse.squared())
  })
  
  #### Question 2 space #####
  
  #### Question 3 space #####
  

  #### Question 3 space #####
  

  #### Question 4 space #####
  
 
  #### Question 4 space #####c

})
