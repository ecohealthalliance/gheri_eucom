#' 
#' Function to get state/province level (admin1) administrative boundaries for any number of countries
#' Data directly downloadable from rnaturalearth package
#'
#' @param countries Vector of country names
#'
#'
#' @return SpatialPolygonsDataFrame
#'
#' @examples
#' get_country_province("Armenia")
#' get_country_province(c("Armenia", "Azerbaijan", "Georgia"))
#' 
# CODE process_mammal_data <- function(){
  
# CODE }

#mam_caucasus <- st_crop(mammal_data, extent_caucasus)


### FROM OLD R PROJ TO BE REWORKED HERE

# 1.) Crop and mask shapefile - Noam recomended this first, but I couldn't figure out how to do
# this so I cropped and masked after fasterizing


# 2.) generate a 1/X degree world map of mammalian biodiversity by rasterizing all the layers.
# QUESTION TO REVIEWERS - how does fasterize determine what value to associate with each
# raster cell? Equally splits up total from polygon? Some other algorithm?

# CODE mammal_raster <- raster(mammal_shapes, res = 1/200) 

# Don't totally understand what's happening here because there are no values. Is it turning each polygon into a raster?
# Resolution = degrees here, not sure how to change to km (I can estimate how many km 1/2000 of a degree is, but
# it would be easier to just switch to km)

# CODE mammal_sum <- fasterize(mammal_shapes, mammal_raster, fun="sum")

# CODE par(mar=c(0,0.5,0,0.5)) # This adjust margins around plot (not necessary, but can use if desired)
# CODE plot(mammal_sum, axes=FALSE, box=FALSE)


# 3.) Crop and mask raster
# 3a) create extent "ext_caucasus2" (need extent not spatextent since this is a raster layer)
# CODE ext_caucasus2 <- extent(39.6, 50.7, 38, 44)
# 3b crop to extent
# CODE mam_sum_crop <- crop(mammal_sum, ext_caucasus2)
# 3c mask
# CODE mask_mam_sum_crop <- mask(x = mam_sum_crop, mask = province_caucasus)

# CODE plot(mask_mam_sum_crop)
# CODE plot(province_caucasus, add = TRUE)
