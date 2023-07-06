#' Function to merge protected areas sf objects
#'
#'
#' @title merge_protected_areas
#' @param arm0 sf object
#' @param arm1 sf object
#' @param arm2 sf object
#' @param aze0 sf object
#' @param aze1 sf object
#' @param aze2 sf object
#' @param geo0 sf object
#' @param geo1 sf object
#' @param geo2 sf object
#'
#' @return spatvect with all protected areas merged together into one file
#' 
#' @example merge_protected_areas(protect_area_arm_data0, protect_area_arm_data1, protect_area_arm_data2,
                                # protect_area_aze_data0, protect_area_aze_data1, protect_area_aze_data2,
                                # protect_area_geo_data0, protect_area_geo_data1, protect_area_geo_data2)
#' 


merge_protected_areas <- function(arm0, arm1, arm2, aze0, aze1, aze2, geo0, geo1, geo2){
  
  # get list of all protected area filenames
  areas <- c("arm0", "arm1", "arm2", "aze0", "aze1", "aze2", "geo0", "geo1", "geo2")
  
  for (area_name in areas) {
    assign(area_name, terra::vect(get(area_name)))
  }
  
  cauc_protect <- terra::union(arm0 + arm1 + arm2 + aze0 + aze1 + aze2 + geo0 + geo1 + geo2)
  
  return(cauc_protect)
}

#merged_cauc <- merge_protected_areas(protect_area_arm_data0, protect_area_arm_data1, protect_area_arm_data2,
#                                     protect_area_aze_data0, protect_area_aze_data1, protect_area_aze_data2,
#                                     protect_area_geo_data0, protect_area_geo_data1, protect_area_geo_data2)

merge_protected_areas_cntry <- function(cntry0, cntry1, cntry2){
  
  # get list of all protected area filenames
  areas <- c("cntry0", "cntry1", "cntry2")
  
  for (area_name in areas) {
    assign(area_name, terra::vect(get(area_name)))
  }
  
  cntry_protect <- terra::union(cntry0 + cntry1 + cntry2)
  
  return(cntry_protect)
}

#merged_arm <- merge_protected_areas_cntry(protect_area_arm_data0, protect_area_arm_data1, protect_area_arm_data2)











#merge_protected_areas <- function(arm0, arm1, arm2, aze0, aze1, aze2, geo0, geo1, geo2){
  
  # get list of all protected area filenames
 # areas <- c("protect_area_arm_data0", "protect_area_arm_data1", "protect_area_arm_data2",
  #           "protect_area_aze_data0", "protect_area_aze_data1", "protect_area_aze_data2",
   #          "protect_area_geo_data0", "protect_area_geo_data1", "protect_area_geo_data2")
  
  #for (area_name in areas) {
  #  assign(area_name, terra::vect(get(area_name)))
  #}
  
  #cauc_protect <- terra::union(protect_area_arm_data0 + protect_area_arm_data1 + protect_area_arm_data2 +
   #                              protect_area_aze_data0 + protect_area_aze_data1 + protect_area_aze_data2 +
    #                             protect_area_geo_data0 + protect_area_geo_data1 + protect_area_geo_data2)
  
  #return(cauc_protect)
#}

#protect_area_caucasus <- merge_protected_areas()
#terra::plot(protect_area_caucasus)












### OLD CODE, CAN BE DELETED SOON ################################################
#merge_protected_area_sf <- function(shape1, shape2, shape3){
# single_sf <- dplyr::bind_rows(list(shape1, shape2, shape3))
#sf::sf_use_s2(FALSE) # switches off spherical geometry to avoid errors with st_union
#combined_sf <- st_union(single_sf)
#return(combined_sf)
#}

