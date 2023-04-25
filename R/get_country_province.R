# Function to get state administrative boundaries for just one country
# Data directly downloadable from rnaturalearth
#' Title
#'
#' @param country1 String name of country
#'
#' @return SpatialPolygonsDataFrame (Admn1)
#'
#' @examples
#' get_country_province("Armenia")
#' 
get_country_province <- function(country1) {
  
  # 1.) download shapefiles from natural earth
  desired_states <- ne_states(country = country1)
  
  # 2.)  clean downloaded SpatialPolygonsDataFrame
  spdf_1 <- dplyr::select(desired_states, name, type_en, latitude, longitude, admin)
  col_order <- c("admin","name", "type_en", "latitude", "longitude")
  cntry_states <- spdf_1[, col_order]
  return(cntry_states)
}