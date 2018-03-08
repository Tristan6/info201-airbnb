source('Overall_rating.R')
source('pre-processing.R')
library("markdown")

shinyServer(function(input, output, session) {
  
  current.q1.1 <- reactive({
    return(GetFrame(input$city.q1.1, input$year.q1.1))

  })
  
  current.q1.2 <- reactive({
    return(GetFrame(input$city.q1.2, input$year.q1.2))
    
  })
  
  current.q1.3 <- reactive({
    return(GetFrame(input$city.q1.3, input$year.q1.3))
    
  })
  
  #### Question 1 space #####
  
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
  
  
  

  #### Question 1 space #####
  
  
  
  #### Question 2 space #####
  
  
  
  #### Question 2 space #####
  
  #### Question 3 space #####
  

  #### Question 3 space #####
  

  #### Question 4 space #####
  
 
  #### Question 4 space #####c

})
