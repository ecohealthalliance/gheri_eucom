#' Function to crop and mask packedspatraster to polygons of Caucasus countries
#'
#'
#' @title crop_mask_packedraster

#' @param spatextent spatextent object or function that outputs a spatextent
#' @param packedspatraster packedspatraster object
#' @param spdf spatialpolygonsdataframe object
#'
#' @return spatraster
#'
#' @examples
#' crop_mask_packedraster(get_caucasus_extent(), world_pop_data, caucasus_provinces)
#' Rather than using a function like "get_caucasus_extent()" you can also just use a spatraster object on its own
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

