source('pre-processing.R')

source('room_type&satisfaction.R')
library("markdown")

shinyServer(function(input, output, session) {
  

  
  #### Question 1 space #####
  
  

  #### Question 1 space #####
  
  #### Question 2 space #####
  
  
  
  #### Question 2 space #####
  
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
