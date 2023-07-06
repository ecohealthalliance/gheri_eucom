#' Functions to plot Azerbaijan health facilities
#'
#'
#' @title plot_health_facility

#' @param facility_pt HOTOSM Azerbaijan Health Facilities data file
#'
#' @return Spatvector
#' 
#' @examples
#' 
#' 
#' 

plot_health_facility <- function(facility){
  
# unpack packedspatvector and drop NA values for health facilities
health_facility <- terra::unwrap(health_facility_aze) %>% 
  tidyterra::drop_na(amenity)

# Plot data
aze_health_facilities <- ggplot() +
  geom_sf(data = azerbaijan_provinces, fill = "lightgray", alpha = 0.3, color = "#666666") +
  geom_spatvector(data = health_facility, aes(colour = amenity)) +
  scale_colour_brewer("Health\nfacilities", palette = "Set1", ) +
  theme_void() +
  theme(legend.text = element_text(size=14),
        legend.title = element_text(size=14))

return(aze_health_facilities)

}

#plot_health_facility(health_facility_aze)

