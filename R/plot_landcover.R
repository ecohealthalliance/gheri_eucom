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

# Ideally get ggplot once some issues sorted out, but for now, just doing a terra::plot

#output_landcover <- crop_landcover(world_land_cover_vrt, western_asia_crop)

plot_landcover <- function(output_landcover, western_asia_crop){
#Add white box to put legend over
# Create a matrix with the coordinates of the box vertices
coords <- matrix(c(40.17, 38.2,
                   43.2, 38.2,
                   43.2, 40,
                   40.17, 40,
                   40.17, 38.2), ncol = 2, byrow = TRUE)

#Plot
terra::plot(output_landcover,
            axes = FALSE)
terra::plot(western_asia_crop$geometry,
            border = "black",
            add = TRUE)
add_legend(legend = "Regions of
Georgia",    x=39.5, y= 42.6, pch = 15, col="#99cc99", cex = 0.9, bty="n")
box <- polygon(coords,  col = alpha("gray", 0.8), border='gray')
add_legend(legend = "Tree cover",         x=40.12, y= 40.1, pch = 15, col="darkgreen", cex = 0.9, bty="n")
add_legend(legend = "Grassland",          x=40.12, y= 39.85, pch = 15, col="yellow", cex = 0.9, bty="n")
add_legend(legend = "Cropland",           x=40.12, y= 39.6, pch = 15, col="magenta", cex = 0.9, bty="n")
add_legend(legend = "Built-up",           x=40.12, y= 39.35, pch = 15, col="red", cex = 0.9, bty="n")
add_legend(legend = "Water",              x=40.12, y= 39.1, pch = 15, col="blue", cex = 0.9, bty="n")
add_legend(legend = "Sparse vegetation",  x=40.12, y= 38.85, pch = 15, col="darkgray", cex = 0.9, bty="n")
add_legend(legend = "Snow",               x=40.12, y= 38.6, pch = 15, col="white", cex = 0.9, bty="n")

}

#output_landcover <- crop_landcover(world_land_cover_vrt, western_asia_crop) #need to run first (from other function)
#plot_landcover(output_landcover, western_asia_crop)



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