#' Function to get country-level administrative boundaries for any number of countries
#' Data directly downloadable from rnaturalearth
#' 
#' 
#' @title get_country_border

#' @param country1 String name of country
#'
#' @return sf object (Admn0)
#'
#' @examples
#' get_country_border("Armenia")
#' get_country_border(c("Armenia", "Azerbaijan", "Georgia"))
#' 
get_country_border <- function(country1) {
  
  # 1.) download shapefiles from natural earth
  desired_countries <- rnaturalearth::ne_countries(country = country1)
  
  # 2.) convert to sf object
  countries_sf <- sf::st_as_sf(desired_countries) 

  return(countries_sf)
}




