#' Function to get country-level administrative boundaries for western asia countries
#' Data directly downloadable from rnaturalearth
#' 
#' 
#' @title get_western_asia_background

#' @param country1 String name of country
#'
#' @return sf object (Admn0)
#'
#' @examples
#' get_western_asia_background(world_countries, chicken_caucasus)
#' 


get_western_asia_background <- function(countries_object, raster){
  
  # turn into spatvector
  world_countries_vect <- vect(countries_object)
  # create desired extent of western asia
  ext_western_asia <- terra::ext(40, 50.7, 38.1, 43.6)
  # crop to extent
  world_countries_crop <- terra::crop(world_countries_vect, ext_western_asia)
  # change to sf object
  world_countries_crop_sf <- sf::st_as_sf(world_countries_crop)
  # reproject crs to desired raster
  world_countries_crop_sf <- st_transform(world_countries_crop_sf, crs = st_crs(raster))

return(world_countries_crop_sf)
}





