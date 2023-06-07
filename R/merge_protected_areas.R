#' Function to merge protected area sf objects
#'
#'
#' @title merge_protected_areas
#' @param 
#'
#' @return spatvect with all protected areas merged into one object
#' 
#' 


# There should be a way to edit this function to be more generic where you don't have to specify the exact number
# of shapes, but I don't know how to do that at the moment.
merge_protected_areas <- function(){
  areas <- c("protect_area_arm_data0", "protect_area_arm_data1", "protect_area_arm_data2",
             "protect_area_aze_data0", "protect_area_aze_data1", "protect_area_aze_data2",
             "protect_area_geo_data0", "protect_area_geo_data1", "protect_area_geo_data2")
  
  for (area_name in areas) {
    assign(area_name, terra::vect(get(area_name)))
  }
  
  cauc_protect <- terra::union(protect_area_arm_data0 + protect_area_arm_data1 + protect_area_arm_data2 +
                                 protect_area_aze_data0 + protect_area_aze_data1 + protect_area_aze_data2 +
                                 protect_area_geo_data0 + protect_area_geo_data1 + protect_area_geo_data2)
  
  return(cauc_protect)
}

#protect_area_caucasus <- merge_protected_areas()
#terra::plot(protect_area_caucasus)



### OLD CODE, CAN BE DELETED SOON ################################################
#merge_protected_area_sf <- function(shape1, shape2, shape3){
# single_sf <- dplyr::bind_rows(list(shape1, shape2, shape3))
#sf::sf_use_s2(FALSE) # switches off spherical geometry to avoid errors with st_union
#combined_sf <- st_union(single_sf)
#return(combined_sf)
#}

