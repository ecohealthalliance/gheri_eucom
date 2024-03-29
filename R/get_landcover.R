#' This function crops a packedspatraster i.e., world landcover data
#' to a desired region i.e., western asia
#'
#'
#' @title crop_landcover

#' @param landcover packedspatraster
#' @param shape_crop sf object to crop the raster to
#'
#' @return spatraster
#' 
#' example crop_landcover(world_land_cover_vrt, western_asia_crop)

crop_landcover <- function(landcover, shape_crop){
  
  #unpack world_land_cover_vrt
  landcover_rast <- terra::rast(landcover)

  #crop (add 'mask = TRUE' when doing a country output, not needed for whole region)
  landcover_crop <- terra::crop( landcover_rast, shape_crop, mask = TRUE)
  
  return(landcover_crop)
  }




# ISSUE: Didn't run below code because of bug, but not deleting for potential future needs

#output_landcover <- crop_landcover(world_land_cover_vrt, western_asia_crop)
#terra::plot(output_landcover)
#landcover_georgia <- crop_landcover(world_land_cover_vrt, georgia_provinces)
#landcover_armenia <- crop_landcover(world_land_cover_vrt, armenia_provinces)
#landcover_azerbaijan <- crop_landcover(world_land_cover_vrt, azerbaijan_provinces)


#data_path <- here("raw_data/ESA_WorldCover_10m_2021_v200_60deg_macrotile_N30E000")

#files <- list.files(data_path, full.names = TRUE)

#vrt_file <- file.path(here(), "world_land_cover.vrt")

#world_land_cover_vrt <- terra::vrt(files, vrt_file, overwrite=TRUE)

#world_land_cover_vrt_wa <- terra::crop(world_land_cover_vrt, western_asia_crop)

#terra::plot(world_land_cover_vrt_wa)


# files <- list.files(here("raw_data/ESA_WorldCover_10m_2021_v200_60deg_macrotile_N30E000"), full.names = TRUE)

#targets::tar_target(world_land_cover_vrt,
#                    {
#                      files <- list.files(here("raw_data/ESA_WorldCover_10m_2021_v200_60deg_macrotile_N30E000"), full.names = TRUE)
#                      
#                      vrt_file <- file.path(here(), "world_land_cover.vrt")
#                      
#                      world_land_cover_vrt <- terra::vrt(files, vrt_file, overwrite=TRUE)}),
#                      
#                      world_land_cover_vrt_wa <- terra::crop(world_land_cover_vrt, western_asia_crop)
#                    
 


#tar_target(
#  worldcov.vrt,
#  command = {
#    files <- list.files(data_path, full.names = TRUE)
#    vrt_file <- file.path(here(), "worldcov.vrt")
#    terra::vrt(files, vrt_file)
#  },
#  format = "file",



