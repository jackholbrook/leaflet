#' Now that there is a providers list
#' You can programmatically add providers.<br/>
#' Here I show how to add all 'ESRI' provided basemaps.
#' Checkout the `providers` list for all available providers.<br/>
#' <br/>
library(leaflet)

m <- leaflet() %>% setView(0, 0, 1)

# Take out ESRI provided tiles
esri <- providers %>%
  purrr::keep(~ grepl("^Esri", .))

esri %>%
  purrr::walk(function(x) m <<- m %>% addProviderTiles(x, group = x))

m %>%
  addLayersControl(
    baseGroups = names(esri),
    options = layersControlOptions(collapsed = TRUE)
  )

#' <br/><br/><br/><br/>
#' providers with options
#' Change the accessToken with your mapbox token in options below
#' The one here may not work always
mapbox.tileIds <- list(Satellite = "mapbox.satellite",
                       Terrian = "mapbox.mapbox-terrain-v2",
                       Comic = "bhaskarvk.1cm89o4e",
                       "High Contrast" = "bhaskarvk.1biainl5")

m <- leaflet() %>% setView(0, 0, 1)

names(mapbox.tileIds) %>%
  purrr::walk(function(x) {
                 m <<- m %>%
                    addProviderTiles(providers$MapBox, group = x,
                       options = providerTileOptions(
                         detectRetina = TRUE,
                         # id and accessToken are Mapbox specific options
                         id = mapbox.tileIds[[x]],
                         accessToken = Sys.getenv("MAPBOX_ACCESS_TOKEN")
                       ))
                 })

m %>%
  addLayersControl(
    baseGroups = names(mapbox.tileIds),
    options = layersControlOptions(collapsed = FALSE)
  )
