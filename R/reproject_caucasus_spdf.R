#' Function to reproject spatialpolygonsdataframe to different CRS
#'
#'
#' @title reproject_caucasus_spdf

#' @param spdf #spatialpolygonsdataframe
#' @param 
#'
#' @return spatialpolygonsdataframe with new CRS
#' 
#' @examples
#' 
#' 











# Reproject CRS of caucasus_provinces shapefile to match designated raster (i.e. HFI_2000_data)
reproject_caucasus_spdf <- function(spdf){
caucasus_provinces_hfi <- spTransform(spdf, CRS("+proj=moll +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs"))
return(caucasus_provinces_hfi)
}

####OLD CODE - NOW SEPARATED INTO EXTENT (within get_extents.R file) AND REPROJECTION (ABOVE)
### QUESTION - Should I do these steps in one function or multiple functions to create new extent and reproject
    # I think add the extent code here to the already get_extents.R file and create a new .R file with a function to reproject
    # better to error on smaller chunks of code I think? Although its really only a few lines of code

# 1.) Check CRS and see that it is different from other rasters
# CODE terra::crs((terra::rast(HFI_2000_data)), proj = TRUE)

# 2.) Since CRS is different (in meters, not degrees), create a new extent slightly larger than the caucasus region
# CODE extent_caucasus_hfi <- terra::ext(3250000, 4350000, 4550000, 5250000)
# CODE terra::plot((terra::rast(HFI_2000_data)), ext = extent_caucasus_hfi)

# 3.) Since CRS is different, we need to reproject "province_caucasus" shapefile to CRS of HFI data
#     so it can be used to crop and mask the spatraster
# CODE caucasus_provinces_hfi <- spTransform(caucasus_provinces, CRS("+proj=moll +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs"))

