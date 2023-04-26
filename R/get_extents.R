#' 
#' Functions to get extent of the South Caucasus region and each individual country within the region
#'
#' @param
#'
#'
#' @return SpatExtent
#'
#' @examples
#' 


### CAUCASUS (ARM + AZE +GEO) ###
get_caucasus_extent <- function(){
  # Identify extent of South Caucasus region (done on next line)
  # terra::ext(caucasus_provinces)
  # Create extent based on slightly larger extent then caucasus_provinces
  extent_cauc <- terra::ext(39.6, 50.7, 38, 44)
  return(extent_cauc)
}



### ARMENIA ###
get_armenia_extent <- function(){
  # Identify extent of Armenia (done on next line)
  # terra::ext(armenia_provinces)
  # Create extent based on slightly larger extent then armenia_provinces
  extent_arm <- terra::ext(43.3, 46.7, 38.8, 41.35)
  return(extent_arm)
}


### AZERBAIJAN ###
get_azerbaijan_extent <- function(){
  # Identify extent of Azerbaijan (done on next line)
  # terra::ext(azerbaijan_provinces)
  # Create extent based on slightly larger extent then azerbaijan_provinces
  extent_aze <- terra::ext(44.7, 50.7, 38.3, 41.95)
  return(extent_aze)
}


### GEORGIA ###
get_georgia_extent <- function(){
  # Identify extent of Georgia (done on next line)
  # terra::ext(georgia_provinces)
  # Create extent based on slightly larger extent then georgia_provinces
  extent_geo <- terra::ext(39.2, 46.75, 40.5, 43.9)
  return(extent_geo)
}


