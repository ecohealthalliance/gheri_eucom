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


plot_mammal_rich <- function(mammal_rich_western_asia, western_asia_crop, caucasus_provinces, georgia_provinces){

  # 1.)  rast to unpack packedspatraster
  mammal_rich_spatrast <- terra::rast(mammal_rich_western_asia)
  
  #2.) crop western asia background countries to extent of caucasus_provinces
  #world_countries_vect <- vect(world_countries)
  #ext_western_asia <- terra::ext(40, 50.7, 38.3, 43.6)
  #world_countries_crop <- terra::crop(world_countries_vect, ext_western_asia)
  
   # 2.) Create scale
  consistent_scale <- scale_fill_viridis_c(limits = c(0,80),
                                         option = "D",  
                                         na.value = "transparent",
                                         name = "Number of
species",
                                         breaks = c(1, 76))
  
  # 3.) Create country labels
  label_georgia <- grobTree(textGrob("Regions of
Georgia", x=0.06,  y=0.73, hjust=0, gp=gpar(col="black", fontsize=10)))
  label_armenia <- grobTree(textGrob("Armenia", x=0.42,  y=0.37, hjust=0, gp=gpar(col="#5a5a5a", fontsize=10)))
  label_azerbaijan <- grobTree(textGrob("Azerbaijan", x=0.65,  y=0.4, hjust=0, gp=gpar(col="#5a5a5a", fontsize=10)))
  label_russia <- grobTree(textGrob("Russia", x=0.57,  y=0.85, hjust=0, gp=gpar(col="#5a5a5a", fontsize=10)))
  label_turkey <- grobTree(textGrob("Turkey", x=0.15,  y=0.28, hjust=0, gp=gpar(col="#5a5a5a", fontsize=10)))
  
  # 4.) Plot data
  region_mammal <- ggplot() +
    geom_spatraster(data = mammal_rich_spatrast,
                    aes(fill = richness), interpolate = TRUE) +
    geom_spatvector(data = western_asia_crop, fill = "transparent", color = "#e6e6e6") +
    geom_sf(data = caucasus_provinces, fill = NA, color = "transparent") +
    geom_sf(data = georgia_provinces, fill = NA, color = "black") +
    consistent_scale +
    theme_void() +
    annotation_custom(label_georgia) +
    annotation_custom(label_armenia) +
    annotation_custom(label_azerbaijan) +
    annotation_custom(label_russia) +
    annotation_custom(label_turkey) 
  
  return(region_mammal)
}

#plot_mammal_rich(mammal_rich_western_asia, western_asia_crop, caucasus_provinces, georgia_provinces)






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












