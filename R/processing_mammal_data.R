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
c

### Current code to process mammal data that needs to be:
# 1.) debugged
# 2.) turned into functions
# 3.) incorporated into _targets.R file



# 1.) Crop and mask shapefile - Noam recommended to do this before fasterizing, but I'm not sure how to do this.

# 2.) generate a 1/X (e.g.1/6) degree resolution world map of mammalian biodiversity by rasterizing all the layers.
# QUESTION - How does fasterize determine what value to associate with each raster cell?
# QUESTION - Equally splits up total from polygon? Some other algorithm?
# QUESTION - I Don't totally understand what's happening below because there are no values. Is it turning each polygon into a raster?
# CODE mammal_raster <- raster(mammal_shapes, res = 1/200)

# 3.) fasterize mammal rasters
# CODE mammal_sum <- fasterize(mammal_shapes, mammal_raster, fun="sum")

# 4.) Adjust margins around plot (not necessary, but can use if desired)
# CODE par(mar=c(0,0.5,0,0.5))
# CODE plot(mammal_sum, axes=FALSE, box=FALSE)






### Code below will be replaced by step # 1.) above by cropping/masking shapefiles (rather than doing crop/mask first here)
# 3.) Crop and mask raster
# 3a) create extent "ext_caucasus2" (need extent not spatextent since this is a raster layer)
# CODE ext_caucasus2 <- extent(39.6, 50.7, 38, 44)
# 3b crop to extent
# CODE mam_sum_crop <- crop(mammal_sum, ext_caucasus2)
# 3c mask
# CODE mask_mam_sum_crop <- mask(x = mam_sum_crop, mask = province_caucasus)

# CODE plot(mask_mam_sum_crop)
# CODE plot(province_caucasus, add = TRUE)



