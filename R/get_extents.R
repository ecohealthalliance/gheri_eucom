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
### using CRS from caucasus_provinces
get_caucasus_extent <- function(){
  # 1.) Identify extent of South Caucasus region (done on next line)
  # terra::ext(caucasus_provinces)
  # 2.) Create extent based on slightly larger extent then caucasus_provinces
  extent_cauc <- terra::ext(39.6, 50.7, 38, 44)
  return(extent_cauc)
}


### CAUCASUS (ARM + AZE +GEO) ###
### using CRS from caucasus_provinces_HFI (extent in meters)
get_caucasus_extent_HFI <- function(){
  # 1.) Identify extent of South Caucasus region (done on next line)
  # terra::crs((terra::rast(HFI_2000_data)), proj = TRUE)
  # 2.) Since CRS is different (in meters, not degrees), create a new extent slightly larger than the caucasus region
  extent_cauc_hfi <- terra::ext(3250000, 4350000, 4550000, 5250000)
  return(extent_cauc_hfi)
}
  

### ARMENIA ###
get_armenia_extent <- function(){
  # 1.) Identify extent of Armenia (done on next line)
  # terra::ext(armenia_provinces)
  # 2.) Create extent based on slightly larger extent then armenia_provinces
  extent_arm <- terra::ext(43.3, 46.7, 38.8, 41.35)
  return(extent_arm)
}


### AZERBAIJAN ###
get_azerbaijan_extent <- function(){
  # 1.) Identify extent of Azerbaijan (done on next line)
  # terra::ext(azerbaijan_provinces)
  # 2.) Create extent based on slightly larger extent then azerbaijan_provinces
  extent_aze <- terra::ext(44.7, 50.7, 38.3, 41.95)
  return(extent_aze)
}


### GEORGIA ###
get_georgia_extent <- function(){
  # 1.) Identify extent of Georgia (done on next line)
  # terra::ext(georgia_provinces)
  # 2.) Create extent based on slightly larger extent then georgia_provinces
  extent_geo <- terra::ext(39.2, 46.75, 40.5, 43.9)
  return(extent_geo)
}


