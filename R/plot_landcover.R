#' Function to plot human population data
#'
#'
#' @title plot_landcover
#'
#' 
#' @examples
#' 
#' 
#' 

# Ideally get ggplot once some issues sorted ot, but for now, just doing a terra::plot

output_landcover <- crop_landcover(world_land_cover_vrt, western_asia_crop)

#Add white box to put legend over
# Create a matrix with the coordinates of the box vertices
coords <- matrix(c(40.17, 38.2,
                   44, 38.2,
                   44, 40,
                   40.17, 40,
                   40.17, 38.2), ncol = 2, byrow = TRUE)
#white_box <- polygon(coords, col='white', border='white')



#Plot
terra::plot(output_landcover,
            axes = FALSE)
terra::plot(western_asia_crop$geometry,
            border = "black",
            add = TRUE)
add_legend(legend = "Regions of
Georgia",    x=39.5, y= 42.6, pch = 15, col="#99cc99", cex = 0.9, bty="n")
white_box <- polygon(coords, col='white', border='white')



add_legend(legend = "health clinics",    x=25.1, y= -21, pch = 15, col="#99cc99", cex = 1, bty="n")
add_legend(legend = "hospitals",         x=25.1, y= -21.4, pch = 15, col="#ff8080", cex = 1, bty="n")
add_legend(legend = "central hospitals", x=25.1, y= -21.8, pch = 15, col="#ffff00", cex = 1, bty="n")



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