#' Function to load all livestock files, crop and mask to sf of Caucasus countries
#'
#'
#' @title sum_GLW_data
#' @param extent_obj sf object that you want to crop and mask the raster to
#'
#' @return spatraster
#'
#' @examples
#' sum_GLW_data(caucasus_provinces)
#' 
sum_GLW_data <- function(caucasus_provinces){
  
  # get list of all livestock filenames
  livestock_files <- list.files("raw_data", pattern = "*2015_Aw.tif$", 
                                full.names = TRUE)
  
  # load livestock rasters as a stack
  livestock_stack <- terra::rast(livestock_files)
  
  # sum them
  livestock_sum <- sum(livestock_stack, na.rm = T)
  
  # crop and mask
  livestock_crop_mask <- terra::crop(livestock_sum, caucasus_provinces, 
                                     mask = T)
  
  # set variable name
  names(livestock_crop_mask) <- "sum_livestock"
  
  return(livestock_crop_mask)
}


