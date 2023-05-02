#' Function to get state/province-level administrative boundaries for any number of countries
#' Data directly downloadable from rnaturalearth
#' 
#' 
#' @title get_country_province

#' @param country1 String name of country
#'
#' @return sf object (Admn1)
#'
#' @examples
#' get_country_province("Armenia")
#' get_country_province(c("Armenia", "Azerbaijan", "Georgia"))
#' 
get_country_province <- function(country1) {
  
  # 1.) download shapefiles from natural earth
  desired_states <- rnaturalearth::ne_states(country = country1)
  
  # 2.) convert to sf object and clean
  states_sf <- sf::st_as_sf(desired_states) %>% 
    dplyr::select(name, type_en, latitude, longitude, admin)
  col_order <- c("admin","name", "type_en", "latitude", "longitude")
  cntry_states <- states_sf[, col_order]
  
  return(cntry_states)
}

