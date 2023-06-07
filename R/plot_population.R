#' Functions to plot GLW livestock data
#'
#'
#' @title plot_livestock

#' @param summed_livestock_caucasus aggregation of GLW data file as packedspatraster
#' @param armenia_provinces sf object to provide outline of admin1 boundries for Armenia
#' @param armenia_provinces sf object to provide outline of admin1 boundries for Azerbaijan
#' @param georgia_provinces sf object to provide outline of admin1 boundries for Georgia
#'
#' 
#' @examples
#' plot_livestock_caucasus(summed_livestock, armenia_provinces, azerbaijan_provinces, georgia_provinces)
#' 
#' 

plot_pop_country <- function(country_pop, country_provinces){
  # 1.) rast to unpack packedspatraster
  country_pop_rast <- terra::rast(country_pop)
  
  # 2.) Create scale
  population_scale <- scale_fill_viridis_c(limits = c(0,17000),
                                           option = "H",  
                                           na.value = "transparent",
                                           name = "Number of people",
                                           breaks = c(5000, 10000, 15000))
  
  # 3.) Create georgia, armenia, and azerbaijan labels
  label_georgia <- grobTree(textGrob("Regions of
Georgia", x=0.05,  y=0.75, hjust=0, gp=gpar(col="black", fontsize=10)))
  
  label_armenia <- grobTree(textGrob("Regions of
Armenia", x=0.3,  y=0.25, hjust=0, gp=gpar(col="#5a5a5a", fontsize=10)))
  
  label_azerbaijan <- grobTree(textGrob("Regions of
Azerbaijan", x=0.84,  y=0.6, hjust=0, gp=gpar(col="#5a5a5a", fontsize=10)))
  
  # 4.) Plot data
  region_pop <- ggplot() +
    geom_spatraster(data = country_pop_rast,
                    aes(fill = ppp_2020_1km_Aggregated), interpolate = TRUE) +
    geom_sf(data = caucasus_provinces, fill = NA, color = "#5a5a5a") +
    geom_sf(data = georgia_provinces, fill = NA, color = "white") +
    population_scale +
    theme_void() +
    annotation_custom(label_georgia) +
    annotation_custom(label_armenia) +
    annotation_custom(label_azerbaijan)
  
  return(region_pop)
  
}
#plot_pop_country(caucasus_pop, caucasus_provinces)


