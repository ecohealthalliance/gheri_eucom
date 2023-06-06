#' Function to plot mammal species richness data
#'
#'
#' @title plot_mammal_rich
#'
#' @param mammal_rich aggregation of IUCN mammal species data file as packedspatraster
#' @param caucasus_provinces sf object to provide outline of admin1 boundries for 3 caucasus countries
#' @param georgia_provinces sf object to provide outline of admin1 boundries for Georgia
#'
#' 
#' @examples
#' plot_mammal_rich(mammal_rich, caucasus_provinces, georgia_provinces)
#' 
#' 

plot_mammal_rich <- function(mammal_rich, caucasus_provinces, georgia_provinces){

  
  # 1.)  rast to unpack packedspatraster
  mammal_rich_spatrast <- terra::rast(mammal_rich)
  # 2.) Create scale
  consistent_scale <- scale_fill_viridis_c(limits = c(0,80),
                                         option = "D",  
                                         na.value = "transparent",
                                         name = "Number of
species",
                                         breaks = c(1, 76))
  # 3.) Create georgia, armenia, and azerbaijan labels
  label_georgia <- grobTree(textGrob("Regions of
Georgia", x=0.05,  y=0.75, hjust=0, gp=gpar(col="black", fontsize=10)))
  
  label_armenia <- grobTree(textGrob("Regions of
Armenia", x=0.3,  y=0.25, hjust=0, gp=gpar(col="#5a5a5a", fontsize=10)))
  
  label_azerbaijan <- grobTree(textGrob("Regions of
Azerbaijan", x=0.84,  y=0.6, hjust=0, gp=gpar(col="#5a5a5a", fontsize=10)))
  
  # 4.) Plot data
  georgia_mammal <- ggplot() +
    geom_spatraster(data = mammal_rich_spatrast,
                    aes(fill = richness), interpolate = TRUE) +
    geom_sf(data = caucasus_provinces, fill = NA, color = "darkgray") +
    geom_sf(data = georgia_provinces, fill = NA, color = "black") +
    consistent_scale +
    theme_void() +
    annotation_custom(label_georgia) +
    annotation_custom(label_armenia) +
    annotation_custom(label_azerbaijan)
  
  return(georgia_mammal)
}

plot_mammal_rich(mammal_rich, caucasus_provinces, georgia_provinces)






#plot_mammal_rich_terraplot <- function(mammal_rich, armenia_provinces, azerbaijan_provinces, georgia_provinces){
  # rast to unpack packedspatraster
  #mammal_rich_rast <- terra::rast(mammal_rich)
  
  # plot mammal richness + outline of caucasus provinces
 # terra::plot(mammal_rich_rast,
  #            axes = FALSE,
   #           smooth = TRUE,
    #          plg=list(
     #           title = "   Number
      #  of species",
       #         title.cex=0.8,
        #        size = 0.7,
         #       loc = "right"))
  
  #add_legend(legend = "Regions of
#Georgia",    x=39.6, y= 42.7, pch = 15, col="#99cc99", cex = 0.9, bty="n")
  
 # terra::plot(armenia_provinces$geometry,
  #            border = "darkgray",
   #           add = TRUE)
  #add_legend(legend = "Regions of
#Armenia",    x=42.6, y= 40, cex = 0.7, bty="n")
  
 # terra::plot(azerbaijan_provinces$geometry,
  #            border = "darkgray",
   #           add = TRUE)
  #add_legend(legend = "Regions of
#Azerbaijan",    x=49, y= 41.5, cex = 0.7, bty="n")
  
  # last plot so it is on top of the gray borders
 # terra::plot(georgia_provinces$geometry,
  #            add = TRUE)
#}
#plot_mammal_rich_terraplot(mammal_rich, armenia_provinces, azerbaijan_provinces, georgia_provinces)












