library('shiny')
library('ggplot2')
library('dplyr')
library('tidyr')
library('maps')
library('stringr')
library('leaflet')


# Get the ui and server.
source('ui_server.R')

# create the shiny app.
shinyApp(ui = my.ui, server = my.server)
