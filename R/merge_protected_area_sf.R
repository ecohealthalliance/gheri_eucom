#' Function to merge protected area sf objects
#'
#'
#' @title merge_protected_area_sf

#' @param protected_areas #String name of protected area sf objects
#' @param 
#'
#' @return sf with all protected areas merged into one object
#' 
#' @examples
#' function(protect_area_arm_data0, protect_area_arm_data1, protect_area_arm_data2)
#' 

merge_protected_area_sf <- function(shape1, shape2, shape3){
  single_sf <- dplyr::bind_rows(list(shape1, shape2, shape3))
  sf::sf_use_s2(FALSE) # switches off spherical geometry to avoid errors with st_union
  combined_sf <- st_union(single_sf)
  return(combined_sf)
}

# There should be a way to combine these functions into one where you don't have to specify the exact number
# of shapes, but I don't know how to do that at the moment.

merge_protected_area_caucasus <- function(shape1, shape2, shape3, shape4, shape5, shape6, shape7, shape8, shape9){
  single_sf <- dplyr::bind_rows(list(shape1, shape2, shape3, shape4, shape5, shape6, shape7, shape8, shape9))
  sf::sf_use_s2(FALSE) # switches off spherical geometry to avoid errors with st_union
  combined_sf <- st_union(single_sf)
  return(combined_sf)
}

