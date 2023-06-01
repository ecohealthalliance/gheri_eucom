#' Function to rasterize IUCN mammal data and calculate species richness
#'
#'
#' @title calc_mammal_rich

#' @param mammal_data IUCN mammal data file
#' @param template_rast raster that will serve as a template for richness
#' @param crop_by_obj sf object that you want to crop + mask the richness raster to
#'
#' @return SpatRaster
#' 
#' @examples
#' calc_mammal_rich(mammal_data, chicken_caucasus, caucasus_provinces)
#' 
#' 

calc_mammal_rich <- function(mammal_data, template_rast, crop_by_obj){
  
  # load the raster you want to use as an output template
  template_rast <- terra::rast(template_rast)
  
  # read in IUCN data as SpatVector
  mammal_vec <- terra::vect(mammal_data)
  
  # set a richness value as 1 for summing
  mammal_vec$richness <- 1
  
  # crop to make the summing less computationally intensive
  mammal_crop <- terra::crop(mammal_vec, crop_by_obj)
  
  # rasterize the species layers using a sum function
  mammal_rast <- terra::rasterize(mammal_crop, template_rast, 
                                  field = "richness", fun = "sum")
  
  # and finally mask
  mammal_masked <- terra::mask(mammal_rast, crop_by_obj)
  
  mammal_masked
}
