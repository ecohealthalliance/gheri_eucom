#' Function to 
#'
#'
#' @title 

#' @param 
#'
#' @return
#' 
#' @examples
#' 
#' 

### Overall goal of editing and processing the mammal data that needs to be:
# 1.) debugged
# 2.) turned into functions
# 3.) incorporated into _targets.R file


### Debugging
# 1.) Crop and mask shapefile
# Noam recommended to crop and mask before fasterizing, but I'm not totally sure how to do this.
# The code below (lines 26-35) runs without error, but may not be the most efficient way to do this.

# # Convert mammal_data sf object to terra format (spatvector)
# mammal_data_terra <- vect(mammal_data)
# # Crop the mammal_data_terra object based on the extent
# mammal_data_crop <- crop(mammal_data_terra, get_caucasus_extent())
# # Convert back to sf format
# mammal_data_crop_sf <- sf::st_as_sf(mammal_data_crop)
# # Convert caucasus_provinces to sf format (needs to be same format for the masking step - can't have one sf and one sp object)
# caucasus_provinces_sf <- sf::st_as_sf(caucasus_provinces)
# # Mask the mammal_data_crop sf object to the caucasus_provinces_sf object
# mammal_data_masked <- st_intersection(mammal_data_crop_sf, caucasus_provinces_sf)


# 2.) generate a 1/X (e.g.1/10) degree resolution world map of mammalian biodiversity by rasterizing all the layers.
# mammal_raster <- raster(mammal_shapes, res = 1/10)      # Noam's example code
# mammal_raster2 <- raster(mammal_data_masked, res = 1/10)  # My code: where code breakdown occurs

# 3.) fasterize mammal rasters
# mammal_sum <- fasterize(mammal_shapes, mammal_raster, fun="sum")         # Noam's example code
#mammal_sum2 <- fasterize(mammal_data_masked, mammal_raster2, fun="sum", )  # My code (where to code breaks down)

# 4.) Adjust margins around plot (not necessary, but can use if desired)
#par(mar=c(0,0.5,0,0.5))
# plot(mammal_sum, axes=FALSE, box=FALSE)  # Noam's example code





