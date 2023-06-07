#' Function to reproject spatialpolygonsdataframe to different CRS
#'
#'
#' @title get_cropped_hfi

#' @param sf                #object to crop hfi data to
#' @param packedpsatraster  #HFI data to crop
#'
#' @return spatraster of cropped hfi data
#' 
#' @examples
#' hfi_caucasus_2000 <- get_cropped_hfi(caucasus_provinces, HFI_2000_data)
#' 

get_cropped_hfi <- function(sf_object, HFI_data){

  #reproject sf object that will be used to crop HFI data
  object_hfi_projection <- st_transform(sf_object, crs = st_crs(terra::rast(HFI_2000_data)))

  # crop and mask
  mask_rast_crop <- terra::crop((terra::rast(HFI_2000_data)), object_hfi_projection, mask = TRUE)
  
  return(mask_rast_crop)
}


