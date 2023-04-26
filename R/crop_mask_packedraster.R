#' 
#' Function to crop and mask raster to polygons of Caucasus countries
#'
#' @param 
#'
#'
#' @return 
#'
#' @examples
#' 
#' 
crop_mask_packedraster <- function(spatextent, packedspatraster, spdf){
  # 1.) unwrap PackedSpatRaster
  spatraster <- terra::rast(packedspatraster)
  # 2.) crop raster
  rast_crop <- crop(spatraster, spatextent)
  # 3.) need a SpatVector for the mask so turn desired SPDF into SpatVec object
  spatvec <- vect(spdf, filter=p)
  # 4.) mask using spatvec
  mask_rast_crop <- terra::mask(x = rast_crop, mask = spatvec)
  # 5.) re-wrap spatraster
  #packed_mask <- terra::wrap(mask_rast_crop)
  return(mask_rast_crop)
}





#test1 <- terra::rast(chicken_GLW_data)
#test2 <- terra::crop(test1, extent_caucasus)


#spatraster <- terra::rast(world_pop_data)
#rast_crop <- crop(spatraster, extent_caucasus) # this is the screwy step



