
# Get the ui and server.
source('ui.R')
source('server.R')

# create the shiny app.
shinyApp(ui = ui, server = server)
