library(leaflet)

m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=-87.58671, lat=41.78887, popup="some where")
m  # Print the map