#' Function to plot mammal species richness data
#'
#'
#' @title plot_mammal_rich
#'
#' @param mammal_rich aggregation of IUCN mammal species data file as packedspatraster
#' @param armenia_provinces sf object to provide outline of admin1 boundries for Armenia
#' @param armenia_provinces sf object to provide outline of admin1 boundries for Azerbaijan
#' @param georgia_provinces sf object to provide outline of admin1 boundries for Georgia
#'
#' 
#' @examples
#' plot_mammal_rich(mammal_rich, armenia_provinces, azerbaijan_provinces, georgia_provinces)
#' 
#' 

plot_mammal_rich <- function(mammal_rich, armenia_provinces, azerbaijan_provinces, georgia_provinces){
  # rast to unpack packedspatraster
  mammal_rich_rast <- terra::rast(mammal_rich)
  
  # plot mammal richness + outline of caucasus provinces
  terra::plot(mammal_rich_rast,
              axes = FALSE,
              smooth = TRUE,
              plg=list(
                title = "   Number
        of species",
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

#plot_mammal_rich(mammal_rich, armenia_provinces, azerbaijan_provinces, georgia_provinces)

### Code now in function
# rast to unpack packedspatraster
#mammal_rich_rast <- terra::rast(mammal_rich)
# plot mammal richness + outline of caucasus provinces
#terra::plot(mammal_rich_rast,
 #           axes = FALSE,
  #          smooth = TRUE,
   #         plg=list(
    #          title = "   Number
     #   of species",
      #        title.cex=0.8,
       #       size = 0.7,
        #      loc = "right"))

#add_legend(legend = "Regions of
#Georgia",    x=39.6, y= 42.7, pch = 15, col="#99cc99", cex = 0.9, bty="n")

#terra::plot(armenia_provinces$geometry,
 #           border = "darkgray",
  #          add = TRUE)
#add_legend(legend = "Regions of
#Armenia",    x=42.6, y= 40, cex = 0.7, bty="n")

#terra::plot(azerbaijan_provinces$geometry,
 #           border = "darkgray",
  #          add = TRUE)
#add_legend(legend = "Regions of
#Azerbaijan",    x=49, y= 41.5, cex = 0.7, bty="n")

# last plot so it is on top of the gray borders
#terra::plot(georgia_provinces$geometry,
 #           add = TRUE)


