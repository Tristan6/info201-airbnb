source('pre-processing.R')
source('inverse-squared.R')
library("markdown")

shinyServer(function(input, output, session) {
  
  inverse.squared <- reactive({
    return(CreateRatingsFactor(current.q2()))
  })
  
  #### Question 1 space #####
  
  

  #### Question 1 space #####
  
  #### Question 2 space #####
  
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
  
  #### Question 2 space #####
  
  #### Question 3 space #####
  

  #### Question 3 space #####
  

  #### Question 4 space #####
  
 
  #### Question 4 space #####c

})
