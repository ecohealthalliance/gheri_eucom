#' Function to plot GLW livestock data
#'
#'
#' @title plot_livestock

#' @param summed_livestock aggregation of GLW data file as packedspatraster
#' @param armenia_provinces sf object to provide outline of admin1 boundries for Armenia
#' @param armenia_provinces sf object to provide outline of admin1 boundries for Azerbaijan
#' @param georgia_provinces sf object to provide outline of admin1 boundries for Georgia
#'
#' 
#' @examples
#' plot_livestock(summed_livestock, armenia_provinces, azerbaijan_provinces, georgia_provinces)
#' 
#' 

plot_livestock <- function(summed_livestock, armenia_provinces, azerbaijan_provinces, georgia_provinces){

  # rast to unpack packedspatraster
summed_livestock_rast <- terra::rast(summed_livestock)
  
  # plot GLW + outline of caucasus provinces
  terra::plot(summed_livestock_rast,
              axes = FALSE,
              smooth = TRUE,
              plg=list(
                title = "   Number of
 livestock",
                title.cex=0.8,
                size = 0.7,
                loc = "right"))
  
  add_legend(legend = "Regions of
Georgia",    x=39.6, y= 42.7, pch = 15, col="#99cc99", cex = 0.9, bty="n")
  
  terra::plot(armenia_provinces$geometry,
              border = "darkgray",
              add = TRUE)
  add_legend(legend = "Regions of
Armenia",    x=42.6, y= 40, cex = 0.7, bty="n")
  
  terra::plot(azerbaijan_provinces$geometry,
              border = "darkgray",
              add = TRUE)
  add_legend(legend = "Regions of
Azerbaijan",    x=49, y= 41.5, cex = 0.7, bty="n")
  
  # last plot so it is on top of the gray borders
  terra::plot(georgia_provinces$geometry,
              add = TRUE)
}

# plot_livestock(summed_livestock, armenia_provinces, azerbaijan_provinces, georgia_provinces)
