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
  # rast to unpack packedspatraster
  country_pop_rast <- terra::rast(country_pop)
  
  # plot GLW + outline of caucasus provinces
  terra::plot(country_pop_rast,
              axes = FALSE,
              smooth = TRUE,
              buffer = TRUE,
              plg=list(
                title = "   Number of
people",
                title.cex=0.8,
                size = 0.7,
                loc = "right"))
  
  terra::plot(country_provinces$geometry,
              border = "darkgray",
              add = TRUE)
}
#plot_pop_country(georgia_pop, georgia_provinces)
#plot_pop_country(armenia_pop, armenia_provinces)
#plot_pop_country(azerbaijan_pop, azerbaijan_provinces)

