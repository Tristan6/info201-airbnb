source('pre-processing.R')
source("question4.R")
library("markdown")

shinyServer(function(input, output, session) {
  
  current <- reactive({
    return(GetFrame(input$city, input$year))
  })
  
  #### Question 1 space #####
  
  #### Question 1 space #####
  
  #### Question 2 space #####
  
  
  
  #### Question 2 space #####
  
  #### Question 3 space #####
  

  #### Question 3 space #####
  

  #### Question 4 space #####
  question4.data.frame <- reactive({
    return(getDataFrame4(curent()))
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
