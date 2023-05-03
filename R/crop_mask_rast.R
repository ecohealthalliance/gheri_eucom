#' Function to crop and mask a raster to sf of Caucasus countries
#'
#'
#' @title crop_mask_rast

#' @param file_to_crop filename of the raster to crop
#' @param crop_by_obj sf object that you want to crop and mask the raster to
#'
#' @return spatraster
#'
#' @examples
#' crop_mask_rast(world_pop_data, caucasus_provinces)
#' 
crop_mask_rast <- function(file_to_crop, crop_by_obj){
  
  # load raster
  spatraster <- terra::rast(file_to_crop)
  
  # crop and mask
  mask_rast_crop <- terra::crop(spatraster, crop_by_obj, mask = TRUE)
  
  return(mask_rast_crop)
}

