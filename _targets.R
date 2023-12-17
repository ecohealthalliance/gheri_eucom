################################################################################
#
# Project build script
#
################################################################################

# Load packages (in packages.R) and load project-specific functions in R folder
suppressPackageStartupMessages(source("packages.R"))
for (f in list.files(here::here("R"), full.names = TRUE)) source (f)

# Groups of targets ------------------------------------------------------------

### DATA INPUT
data_input_targets <- tar_plan(
  
  # 1.) Read in official administrative boundary data (admin level 1 and 0) directly from rnaturalearth package
   tar_target(caucasus_provinces, 
              get_country_province(c("Armenia", "Azerbaijan", "Georgia"))),
   tar_target(armenia_provinces,
              get_country_province("Armenia")),
   tar_target(azerbaijan_provinces,
              get_country_province("Azerbaijan")),
   tar_target(georgia_provinces,
              get_country_province("Georgia")),
  #tar_target(western_asia,
  #            get_country_province(c("Armenia", "Azerbaijan", "Georgia", "Turkey", "Iran", "Russia"))),
   tar_target(world_countries,
              ne_countries()),
   
  # 3.) Read in World Population data 
  # WorldPop Population Counts: Population 2020
  # https://www.worldpop.org/geodata/summary?id=24777
  # downloaded manually and saved in raw_data
  # folder as "ppp_2020_1km_Aggregated.tif"
  tar_file(world_pop_data, "raw_data/ppp_2020_1km_Aggregated.tif"),  
  #targets::tar_target(name = world_pop_data, command = terra::wrap(terra::rast(here("raw_data/ppp_2020_1km_Aggregated.tif")))),
  
  # 4.) Read in World Landcover data
  # ESA World Cover 2021
  # https://worldcover2021.esa.int/
  # download manually: large files, so only download tile with Cuacasus countries
  # Saved in raw_data folder as "ESA_WorldCover_10m_2021_v200_60deg_macrotile_N30E000"
  # Data set is large, so read all files in together as virtual tiles
  # This creates data/worldcov.vrt as an index file, and raster treats it all as
  # one large raster without ever loading bits in unless needed. You can, for
  # instance, just plot(worldcov_vrt) without bringing your computer to a halt, 
  # and of course crop and mask it.  From then on you could also
  # do terra::rast("data/worldcov.vrt") to load this.
  # targets::tar_target(name = world_landcover_data, command = terra::wrap(terra::vrt(list.files(here("raw_data/ESA_WorldCover_10m_2021_v200_60deg_macrotile_N30E000"),
  #                                                                                  pattern = "tif$",
  #                                                                                  full.names = TRUE),
  #                                                                       #filename = "data/worldcov.vrt",
  #                                                                       overwrite = TRUE))),
  targets::tar_target(world_land_cover_vrt,
                      terra::wrap({
                        files <- list.files(here("raw_data/ESA_WorldCover_10m_2021_v200_60deg_macrotile_N30E000"), full.names = TRUE)
                        
                        vrt_file <- file.path(here(), "world_land_cover.vrt")
                        
                        world_land_cover_vrt <- terra::vrt(files, vrt_file, overwrite=TRUE)})),
   

  # 6.) Read in FAO Gridded Livestock of the World 2015 data
  # https://dataverse.harvard.edu/dataverse/glw_4
  # downloaded manually and saved in raw_data
  ### CHICKENS (in folder as "6_Ch_2015_Aw.tif")
  tar_file(chicken_GLW, "raw_data/6_Ch_2015_Aw.tif"),
  ### SHEEP (in folder as "6_Sh_2015_Aw.tif")
  tar_file(sheep_GLW, "raw_data/6_Sh_2015_Aw.tif"),
  ### PIG (in folder as "6_Pg_2015_Aw.tif")
  tar_file(pig_GLW, "raw_data/6_Pg_2015_Aw.tif"),
  ### HORSE (in folder as "6_Ho_2015_Aw.tif")
  tar_file(horse_GLW, "raw_data/6_Ho_2015_Aw.tif"),
  ### GOAT (in folder as "6_Gt_2015_Aw.tif")
  tar_file(goat_GLW, "raw_data/6_Gt_2015_Aw.tif"),
  ### DUCK (in folder as "6_Dk_2015_Aw.tif")
  tar_file(duck_GLW, "raw_data/6_Dk_2015_Aw.tif"),
  ### BUFFALO (in folder as "6_Bf_2015_Aw.tif")
  tar_file(buffalo_GLW, "raw_data/6_Bf_2015_Aw.tif"),
  ### CATTLE (in folder as "6_Ct_2015_Aw.tif")
  tar_file(cattle_GLW, "raw_data/6_Ct_2015_Aw.tif"),
  
  
  # 7.) Read in Terrestrial Mammal data
  # Data from https://www.iucnredlist.org
  # downloaded manually and saved in raw_data folder in 
  # subfolder as "MAMMALS_TERRESTRIAL_ONLY
  tar_file(mammal_data, "raw_data/MAMMALS_TERRESTRIAL_ONLY/MAMMALS_TERRESTRIAL_ONLY.shp"),
  
  
  # 8.) Read in Human Footprint Index data
  # Data from the Mu et al., paper "A global record of annual terrestrial Human Footprint 
  # datasetS from 2000 to 2018" (https://www.nature.com/articles/s41597-022-01284-8)
  # Data accessed at https://figshare.com/articles/figure/An_annual_global_terrestrial_Human_Footprint_dataset_from_2000_to_2018/16571064
  # Info about the scoring system:
  # For any grid cell, the Human Footprint can range between 0–50 (larger number = higher human pressure)
  # Each year 2000-2018 is different data set, so first choose year and read in
  # I only have the years 2000, 2008, and 2018 for now, but can downlaod more years as desired
  # Maybe we want to overlay national protected areas or something?
  ### 2000
  targets::tar_target(HFI_2000_data,
                      terra::wrap(terra::rast(here("raw_data/hfp2000.tif")))),
  ### 2008
  #targets::tar_target(HFI_2008_data,
                      #terra::wrap(terra::rast(here("raw_data/hfp2008.tif")))),
  ### 2018
  targets::tar_target(HFI_2018_data,
                      terra::wrap(terra::rast(here("raw_data/hfp2018.tif")))),
  
  
  # 9.) Read in Protected Area data
  # Data from https://www.protectedplanet.net/
  # For each country there are 3 shapefile folders split into equal parts due to their large size. 
  # In order to work with the data, you can load all three polygon shapefiles and merge them into one layer.
# Armenia data (3 shapefiles)
  tar_file(protect_area_arm_data0, "raw_data/Protected_areas_armenia/WDPA_WDOECM_Mar2023_Public_ARM_shp_0/WDPA_WDOECM_Mar2023_Public_ARM_shp-polygons.shp"),
  tar_file(protect_area_arm_data1, "raw_data/Protected_areas_armenia/WDPA_WDOECM_Mar2023_Public_ARM_shp_1/WDPA_WDOECM_Mar2023_Public_ARM_shp-polygons.shp"),
  tar_file(protect_area_arm_data2, "raw_data/Protected_areas_armenia/WDPA_WDOECM_Mar2023_Public_ARM_shp_2/WDPA_WDOECM_Mar2023_Public_ARM_shp-polygons.shp"),
# Azerbaijan data (3 shapefiles)
  tar_file(protect_area_aze_data0, "raw_data/Protected_areas_azerbaijan/WDPA_WDOECM_Apr2023_Public_AZE_shp_0/WDPA_WDOECM_Apr2023_Public_AZE_shp-polygons.shp"),
  tar_file(protect_area_aze_data1, "raw_data/Protected_areas_azerbaijan/WDPA_WDOECM_Apr2023_Public_AZE_shp_1/WDPA_WDOECM_Apr2023_Public_AZE_shp-polygons.shp"),
  tar_file(protect_area_aze_data2, "raw_data/Protected_areas_azerbaijan/WDPA_WDOECM_Apr2023_Public_AZE_shp_2/WDPA_WDOECM_Apr2023_Public_AZE_shp-polygons.shp"),
# Georgia data (3 shapefiles)
  tar_file(protect_area_geo_data0, "raw_data/Protected_areas_georgia/WDPA_WDOECM_Apr2023_Public_GEO_shp_0/WDPA_WDOECM_Apr2023_Public_GEO_shp-polygons.shp"),
  tar_file(protect_area_geo_data1, "raw_data/Protected_areas_georgia/WDPA_WDOECM_Apr2023_Public_GEO_shp_1/WDPA_WDOECM_Apr2023_Public_GEO_shp-polygons.shp"),
  tar_file(protect_area_geo_data2, "raw_data/Protected_areas_georgia/WDPA_WDOECM_Apr2023_Public_GEO_shp_2/WDPA_WDOECM_Apr2023_Public_GEO_shp-polygons.shp"),
  
  # 10.) Read in Azerbaijan health facilities
  # Data from https://data.humdata.org/dataset/hotosm_aze_health_facilities
  # HOTOSM Azerbaijan Health Facilities (OpenStreetMap Export)
  targets::tar_target(health_facility_aze,
                    terra::wrap(terra::vect(here("raw_data/hotosm_aze_health_facilities_points_shp/hotosm_aze_health_facilities_points.shp")))),


)


### DATA PROCESSING
data_processing_targets <- tar_plan(

#Western Asia Background countries
  tar_target(western_asia_crop,
             get_western_asia_background(world_countries, terra::rast(chicken_caucasus))),

#Landcover data
#tar_target(land_cover_vrt_westasia, 
#           terra::wrap(crop_landcover(world_land_cover_vrt, western_asia_crop))),

tar_target(land_cover_westasia,
           crop_landcover(world_land_cover_vrt, western_asia_crop)),


#world_land_cover_vrt_wa <- terra::crop(world_land_cover_vrt, western_asia_crop)  

#GLW Data
  # Chicken data (GLW) crop and mask
  tar_target(chicken_caucasus, 
             terra::wrap(crop_mask_rast(chicken_GLW, caucasus_provinces))),
  tar_target(chicken_georgia, 
             terra::wrap(crop_mask_rast(chicken_GLW, georgia_provinces))),
  tar_target(chicken_armenia, 
           terra::wrap(crop_mask_rast(chicken_GLW, armenia_provinces))),
  tar_target(chicken_azerbaijan, 
           terra::wrap(crop_mask_rast(chicken_GLW, azerbaijan_provinces))),
  # Sheep data (GLW) crop and mask
  tar_target(sheep_caucasus, 
             terra::wrap(crop_mask_rast(sheep_GLW, caucasus_provinces))),
  # Pig data (GLW) crop and mask
  tar_target(pig_caucasus, 
             terra::wrap(crop_mask_rast(pig_GLW, caucasus_provinces))),
  # Horse data (GLW) crop and mask
  tar_target(horse_caucasus, 
             terra::wrap(crop_mask_rast(horse_GLW, caucasus_provinces))),
  # Goat data (GLW) crop and mask
  tar_target(goat_caucasus, 
             terra::wrap(crop_mask_rast(goat_GLW, caucasus_provinces))),
  # Duck data (GLW) crop and mask
  tar_target(duck_caucasus, 
             terra::wrap(crop_mask_rast(duck_GLW, caucasus_provinces))),
  # Buffalo data (GLW) crop and mask
  tar_target(buffalo_caucasus, 
             terra::wrap(crop_mask_rast(buffalo_GLW, caucasus_provinces))),
  # Cattle data (GLW) crop and mask
  tar_target(cattle_caucasus, 
             terra::wrap(crop_mask_rast(cattle_GLW, caucasus_provinces))),
  # Aggregate GLW data
  summed_livestock_caucasus = terra::wrap(sum_GLW_data(caucasus_provinces)),
  summed_livestock_georgia = terra::wrap(sum_GLW_data(georgia_provinces)),
  summed_livestock_armenia = terra::wrap(sum_GLW_data(armenia_provinces)),
  summed_livestock_azerbaijan = terra::wrap(sum_GLW_data(azerbaijan_provinces)),
  summed_livestock_western_asia = terra::wrap(sum_GLW_data(western_asia_crop)),

  
#Human Footprint Index
  # HFI 2000  crop and mask (different crs than caucasus_provinces, so slightly different pre-processing)
  tar_target(hfi_2000_caucasus,
             terra::wrap(get_cropped_hfi(caucasus_provinces, HFI_2000_data))),
  tar_target(hfi_2000_georgia,
           terra::wrap(get_cropped_hfi(georgia_provinces, HFI_2000_data))),  
  tar_target(hfi_2000_armenia,
           terra::wrap(get_cropped_hfi(armenia_provinces, HFI_2000_data))),  
  tar_target(hfi_2000_azerbaijan,
           terra::wrap(get_cropped_hfi(azerbaijan_provinces, HFI_2000_data))),
  
  tar_target(hfi_2018_caucasus,
             terra::wrap(get_cropped_hfi(caucasus_provinces, HFI_2018_data))),
  tar_target(hfi_2018_georgia,
           terra::wrap(get_cropped_hfi(georgia_provinces, HFI_2018_data))),  
  tar_target(hfi_2018_armenia,
           terra::wrap(get_cropped_hfi(armenia_provinces, HFI_2018_data))),  
  tar_target(hfi_2018_azerbaijan,
           terra::wrap(get_cropped_hfi(azerbaijan_provinces, HFI_2018_data))),

#Protected areas  
  # Combine protected area sf objects for each country and for the region
  targets::tar_target(protected_area_caucasus,
                      terra::wrap(merge_protected_areas(protect_area_arm_data0, protect_area_arm_data1, protect_area_arm_data2,
                                                        protect_area_aze_data0, protect_area_aze_data1, protect_area_aze_data2,
                                                        protect_area_geo_data0, protect_area_geo_data1, protect_area_geo_data2))), # this isn't working. Is it dependent on other targets or files being loaded? Seems to be working now.
  targets::tar_target(protected_area_armenia,
                    terra::wrap(merge_protected_areas_cntry(protect_area_arm_data0, protect_area_arm_data1, protect_area_arm_data2))),
  targets::tar_target(protected_area_azerbaijan,
                    terra::wrap(merge_protected_areas_cntry(protect_area_aze_data0, protect_area_aze_data1, protect_area_aze_data2))),
  targets::tar_target(protected_area_georgia,
                    terra::wrap(merge_protected_areas_cntry(protect_area_geo_data0, protect_area_geo_data1, protect_area_geo_data2))),


#Mammal richness
  # Calculate from IUCN data
  mammal_rich_caucasus = terra::wrap(calc_mammal_rich(mammal_data = mammal_data, 
                                             template_rast = chicken_caucasus, 
                                             crop_by_obj = caucasus_provinces)),
  mammal_rich_western_asia = terra::wrap(calc_mammal_rich(mammal_data = mammal_data, 
                                           template_rast = chicken_caucasus, 
                                           crop_by_obj = western_asia_crop)),  
  mammal_rich_armenia = terra::wrap(calc_mammal_rich(mammal_data = mammal_data, 
                                                        template_rast = chicken_armenia, 
                                                        crop_by_obj = armenia_provinces)), 
  mammal_rich_georgia = terra::wrap(calc_mammal_rich(mammal_data = mammal_data, 
                                                   template_rast = chicken_georgia, 
                                                   crop_by_obj = georgia_provinces)), 
  mammal_rich_azerbaijan = terra::wrap(calc_mammal_rich(mammal_data = mammal_data, 
                                                   template_rast = chicken_azerbaijan, 
                                                   crop_by_obj = azerbaijan_provinces)), 

#World population
  # crop and mask
  tar_target(caucasus_pop, 
             terra::wrap(crop_mask_rast(world_pop_data, caucasus_provinces))),
  tar_target(georgia_pop, 
             terra::wrap(crop_mask_rast(world_pop_data, georgia_provinces))),
  tar_target(armenia_pop, 
             terra::wrap(crop_mask_rast(world_pop_data, armenia_provinces))),
  tar_target(azerbaijan_pop, 
             terra::wrap(crop_mask_rast(world_pop_data, azerbaijan_provinces))),
tar_target(western_asia_pop, 
           terra::wrap(crop_mask_rast(world_pop_data, western_asia_crop))),

#World landcover
# crop and mask
# tar_target(caucasus_landcover, 
#           terra::wrap(crop_mask_rast(world_landcover_data, caucasus_provinces))),

#Azerbaijan health facilities
#tar_target(health_facility_aze,
#           terra::wrap(get_health_facility(health_facility_pt_aze))),
)



# List targets -----------------------------------------------------------------

list(
  data_input_targets,
  data_processing_targets
  # analysis_targets,
  # outputs_targets,
  # report_targets,
  # deploy_targets
)
