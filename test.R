library(sp)
library(leaflet)
circleFun <- function(center = c(0,0),diameter = 1, npoints = 100){
  r = diameter / 2
  tt <- seq(0,2*pi,length.out = npoints)
  xx <- center[1] + r * cos(tt)
  yy <- center[2] + r * sin(tt)
  Sr1 = Polygon(cbind(xx, yy))
  Srs1 = Polygons(list(Sr1), "s1")
  SpP = SpatialPolygons(list(Srs1), 1:1)
  return(SpP)
}
Circle.Town <- circleFun(c(1,-1),2.3,npoints = 100)

df1 <- data.frame(long=c(0.6,1,1.4), lat=c(-2, -.8, -0.2), other=c('a', 'b', 'c'), VAM=c(10,8,6), 
                  type=c('Public', 'Public', 'Private'), id=c(1:3)) %>% 
  mutate(X=paste0('<strong>id: </strong>', 
                  id,
                  '<br><strong>type</strong>: ',
                  type,
                  '<br><strong>VAM</strong>: ',
                  VAM))

# Create a continuous palette function
pal <- colorNumeric(
  palette = "RdYlBu",
  domain = df1$VAM
)

leaflet(height = "400px") %>% 
  addTiles() %>%
  addPolygons(data = Circle.Town, color = 'green',  fillOpacity = .7) %>%
  addCircleMarkers(data = df1, lat = ~lat, lng =~long, 
                   radius = ~VAM, popup = ~as.character(X), 
                   fillColor = ~pal(VAM),
                   stroke = FALSE, fillOpacity = 0.8,
                   clusterOptions = markerClusterOptions()) %>% 
  addLegend(position = "topright",
            pal = pal, values = df1$VAM,
            title = "VAM",
            opacity = 1
  ) %>% 
  setView(lng = 1, lat = -1, zoom = 8)





addCircleMarkers(map, lng = NULL, lat = NULL, radius = 10,
                 layerId = NULL, group = NULL, stroke = TRUE, color = "#03F",
                 weight = 5, opacity = 0.5, fill = TRUE, fillColor = color,
                 fillOpacity = 0.2, dashArray = NULL, popup = NULL,
                 popupOptions = NULL, label = NULL, labelOptions = NULL,
                 options = pathOptions(), clusterOptions = NULL, clusterId = NULL,
                 data = getMapData(map))

popupOptions(maxWidth = 300, minWidth = 50, maxHeight = NULL,
             autoPan = TRUE, keepInView = FALSE, closeButton = TRUE,
             zoomAnimation = TRUE, closeOnClick = NULL, className = "", ...)

addTiles(map, urlTemplate = "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
         attribution = NULL, layerId = NULL, group = NULL,
         options = tileOptions())

