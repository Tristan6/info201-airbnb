
# Get the ui and server.
source('ui_server.R')

# create the shiny app.
shinyApp(ui = my.ui, server = my.server)
