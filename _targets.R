################################################################################
#
# Project build script
#
################################################################################

# Load packages (in packages.R) and load project-specific functions in R folder
suppressPackageStartupMessages(source("packages.R"))
for (f in list.files(here::here("R"), full.names = TRUE)) source (f)

# Set build options ------------------------------------------------------------


# Groups of targets ------------------------------------------------------------

## Data input

data_input_targets <- tar_plan(
  # 1.) Read in official administrative boundary data (admin level 1) directly from rnaturalearth package
   targets::tar_target(name = caucasus_provinces, command = get_country_province(c("Armenia", "Azerbaijan", "Georgia"))),
   targets::tar_target(name = armenia_provinces, command = get_country_province("Armenia")),
   targets::tar_target(name = azerbaijan_provinces, command = get_country_province("Azerbaijan")),
   targets::tar_target(name = georgia_provinces, command = get_country_province("Georgia")),
    
  # 2.) Read in unofficial administrative boundary data (admin level 2 e.g., towns)
  # Manually download from HDX humdata.org and save in folder "raw_data"
  # Armenia data at https://data.humdata.org/dataset/geoboundaries-admin-boundaries-for-armenia
  # file name "geoBoundaries-ARM-ADM2-all"
  targets::tar_target(name = armenia_towns, command = st_read(here("raw_data/geoBoundaries-ARM-ADM2-all/geoBoundaries-ARM-ADM2.shp"))),
  # Azerbaijan data at https://data.humdata.org/dataset/geoboundaries-admin-boundaries-for-azerbaijan
  # file name "geoBoundaries-AZE-ADM2-all"
  targets::tar_target(name = azerbaijan_towns, command = st_read(here("raw_data/geoBoundaries-AZE-ADM2-all/geoBoundaries-AZE-ADM2.shp"))),
  # Georgia data at https://data.humdata.org/dataset/geoboundaries-admin-boundaries-for-georgia
  # file name "geoBoundaries-GEO-ADM2-all"
  targets::tar_target(name = georgia_towns, command = st_read(here("raw_data/geoBoundaries-GEO-ADM2-all/geoBoundaries-GEO-ADM2.shp"))),
  
  
  # 3.) Read in World Population data 
  # WorldPop Population Counts: Population 2020
  # https://www.worldpop.org/geodata/summary?id=24777
  # downloaded manually and saved in raw_data
  # folder as "ppp_2020_1km_Aggregated.tif"
    targets::tar_target(name = world_pop_data, command = terra::wrap(terra::rast(here("raw_data/ppp_2020_1km_Aggregated.tif")))),
  
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
  targets::tar_target(name = world_landcover_data, command = terra::wrap(terra::vrt(list.files(here("raw_data/ESA_WorldCover_10m_2021_v200_60deg_macrotile_N30E000"),
                                                                                   pattern = "tif$",
                                                                                   full.names = TRUE),
                                                                        filename = "data/worldcov.vrt",
                                                                        overwrite = TRUE))),
  
  
  # 5.) Read in World Elevation data
  # Use the elevatr package, which currently provides access to elevation data 
  # from AWS Open Data Terrain Tiles and the Open Topography Global
  # datasets API for raster digital elevation models. 
  # read in elevation data based on a location (e.g., country_provinces)
  targets::tar_target(name = world_elevation_data, command = get_elev_raster(caucasus_provinces, z = 9)), # %>% 
    #terra::rast(world_elevation_data)   # convert raster to SpatRaster. This isn't working now, though?
  
  
  # 6.) Read in FAO Gridded Livestock of the World 2015 data
  # https://dataverse.harvard.edu/dataverse/glw_4
  # downloaded manually and saved in raw_data
  ### CHICKENS (in folder as "6_Ch_2015_Aw.tif")
  targets::tar_target(name = chicken_GLW_data, command = terra::wrap(terra::rast(here("raw_data/6_Ch_2015_Aw.tif")))),
  ### SHEEP (in folder as "6_Sh_2015_Aw.tif")
  targets::tar_target(name = sheep_GLW_data, command = terra::wrap(terra::rast(here("raw_data/6_Sh_2015_Aw.tif")))),
  ### PIG (in folder as "6_Pg_2015_Aw.tif")
  targets::tar_target(name = pig_GLW_data, command = terra::wrap(terra::rast(here("raw_data/6_Pg_2015_Aw.tif")))),
  ### HORSE (in folder as "6_Ho_2015_Aw.tif")
  targets::tar_target(name = horse_GLW_data, command = terra::wrap(terra::rast(here("raw_data/6_Ho_2015_Aw.tif")))),
  ### GOAT (in folder as "6_Gt_2015_Aw.tif")
  targets::tar_target(name = goat_GLW_data, command = terra::wrap(terra::rast(here("raw_data/6_Gt_2015_Aw.tif")))),
  ### DUCK (in folder as "6_Dk_2015_Aw.tif")
  targets::tar_target(name = duck_GLW_data, command = terra::wrap(terra::rast(here("raw_data/6_Dk_2015_Aw.tif")))),
  ### BUFFALO (in folder as "6_Bf_2015_Aw.tif")
  targets::tar_target(name = buffalo_GLW_data, command = terra::wrap(terra::rast(here("raw_data/6_Bf_2015_Aw.tif")))),
  ### CATTLE (in folder as "6_Ct_2015_Aw.tif")
  targets::tar_target(name = cattle_GLW_data, command = terra::wrap(terra::rast(here("raw_data/6_Ct_2015_Aw.tif")))),
  
  
  # 7.) Read in Terrestrial Mammal data
  # Data from https://www.iucnredlist.org
  # downloaded manually and saved in raw_data folder in 
  # subfolder as "MAMMALS_TERRESTRIAL_ONLY
  targets::tar_target(name = mammal_data, command = st_read(here("raw_data/MAMMALS_TERRESTRIAL_ONLY/MAMMALS_TERRESTRIAL_ONLY.shp"))),
  
  
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
  targets::tar_target(name = HFI_2000_data, command = terra::wrap(terra::rast(here("raw_data/hfp2000.tif")))),
  ### 2008
  targets::tar_target(name = HFI_2008_data, command = terra::wrap(terra::rast(here("raw_data/hfp2008.tif")))),
  ### 2018
  targets::tar_target(name = HFI_2018_data, command = terra::wrap(terra::rast(here("raw_data/hfp2018.tif")))),
  
  
  # 9.) Read in Protected Area data
  # Data from https://www.protectedplanet.net/
  # For each country there are multiple shapefile folders split into equal parts due to their large size. 
  # In order to work with the data, you can load all three polygon shapefiles and merge them into one layer.
  # Armenia data (3 shapefiles)
  targets::tar_target(name = protect_area_arm_data0, command = st_read(here("raw_data/Protected_areas_armenia/WDPA_WDOECM_Mar2023_Public_ARM_shp_0/WDPA_WDOECM_Mar2023_Public_ARM_shp-polygons.shp"))),
  targets::tar_target(name = protect_area_arm_data1, command = st_read(here("raw_data/Protected_areas_armenia/WDPA_WDOECM_Mar2023_Public_ARM_shp_1/WDPA_WDOECM_Mar2023_Public_ARM_shp-polygons.shp"))),
  targets::tar_target(name = protect_area_arm_data2, command = st_read(here("raw_data/Protected_areas_armenia/WDPA_WDOECM_Mar2023_Public_ARM_shp_2/WDPA_WDOECM_Mar2023_Public_ARM_shp-polygons.shp"))),
  # Azerbaijan data (3 shapefiles)
  targets::tar_target(name = protect_area_aze_data0, command = st_read(here("raw_data/Protected_areas_azerbaijan/WDPA_WDOECM_Apr2023_Public_AZE_shp_0/WDPA_WDOECM_Apr2023_Public_AZE_shp-polygons.shp"))),
  targets::tar_target(name = protect_area_aze_data1, command = st_read(here("raw_data/Protected_areas_azerbaijan/WDPA_WDOECM_Apr2023_Public_AZE_shp_1/WDPA_WDOECM_Apr2023_Public_AZE_shp-polygons.shp"))),
  targets::tar_target(name = protect_area_aze_data2, command = st_read(here("raw_data/Protected_areas_azerbaijan/WDPA_WDOECM_Apr2023_Public_AZE_shp_2/WDPA_WDOECM_Apr2023_Public_AZE_shp-polygons.shp"))),
  # Georgia data (3 shapefiles)
  targets::tar_target(name = protect_area_geo_data0, command = st_read(here("raw_data/Protected_areas_georgia/WDPA_WDOECM_Apr2023_Public_GEO_shp_0/WDPA_WDOECM_Apr2023_Public_GEO_shp-polygons.shp"))),
  targets::tar_target(name = protect_area_geo_data1, command = st_read(here("raw_data/Protected_areas_georgia/WDPA_WDOECM_Apr2023_Public_GEO_shp_1/WDPA_WDOECM_Apr2023_Public_GEO_shp-polygons.shp"))),
  targets::tar_target(name = protect_area_geo_data2, command = st_read(here("raw_data/Protected_areas_georgia/WDPA_WDOECM_Apr2023_Public_GEO_shp_2/WDPA_WDOECM_Apr2023_Public_GEO_shp-polygons.shp"))),
  
)



## Data processing
data_processing_targets <- tar_plan(
 # Don't think I need these lines (133-137)anymore because I can directly use the get_caucasus_extent() function in my next crop_mask_raster targets below
 # 1.) Create extent for Caucasus region and each individual country
 # targets::tar_target(name = extent_caucasus, command = get_caucasus_extent()), 
 # targets::tar_target(name = extent_armenia, command = get_armenia_extent()),
 # targets::tar_target(name = extent_azerbaijan, command = get_azerbaijan_extent()),
 # targets::tar_target(name = extent_georgia, command = get_georgia_extent()),
  
  # 2.) Crop and mask raster data to Caucasus region
  # (make sure to check crs of each raster to match crs of spdf (caucasus_provinces) and to use appropriate extent)
  # terra::crs((terra::rast(packedspatraster)), proj = TRUE)
  
  # 2.a.) Rasters with same CRS as caucasus_provinces shapefile
  # Population data 
  targets::tar_target(name = pop_caucasus, command = terra::wrap(crop_mask_packedraster(get_caucasus_extent(), world_pop_data, caucasus_provinces))),
  # Landcover data
  targets::tar_target(name = landcover_caucasus, command = terra::wrap(crop_mask_packedraster(get_caucasus_extent(), world_landcover_data, caucasus_provinces))),
  # Elevation data -- currently not working and receiving an error
  targets::tar_target(name = elevation_caucasus, command = terra::wrap(crop_mask_packedraster(get_caucasus_extent(), world_elevation_data, caucasus_provinces))),
  # Chicken data (GLW)
  targets::tar_target(name = chicken_caucasus_GLW, command = terra::wrap(crop_mask_packedraster(get_caucasus_extent(), chicken_GLW_data, caucasus_provinces))),                                                  
  # Sheep data (GLW)
  targets::tar_target(name = sheep_caucasus_GLW, command = terra::wrap(crop_mask_packedraster(get_caucasus_extent(), sheep_GLW_data, caucasus_provinces))),
  # Pig data (GLW)
  targets::tar_target(name = pig_caucasus_GLW, command = terra::wrap(crop_mask_packedraster(get_caucasus_extent(), pig_GLW_data, caucasus_provinces))),
  # Horse data (GLW)
  targets::tar_target(name = horse_caucasus_GLW, command = terra::wrap(crop_mask_packedraster(get_caucasus_extent(), horse_GLW_data, caucasus_provinces))),
  # Goat data (GLW)
  targets::tar_target(name = goat_caucasus_GLW, command = terra::wrap(crop_mask_packedraster(get_caucasus_extent(), goat_GLW_data, caucasus_provinces))),
  # Duck data (GLW)
  targets::tar_target(name = duck_caucasus_GLW, command = terra::wrap(crop_mask_packedraster(get_caucasus_extent(), duck_GLW_data, caucasus_provinces))),
  # Buffalo data (GLW)
  targets::tar_target(name = buffalo_caucasus_GLW, command = terra::wrap(crop_mask_packedraster(get_caucasus_extent(), buffalo_GLW_data, caucasus_provinces))),
  # Cattle data (GLW)
  targets::tar_target(name = cattle_caucasus_GLW, command = terra::wrap(crop_mask_packedraster(get_caucasus_extent(), cattle_GLW_data, caucasus_provinces))),
  
  # 2.b.) Rasters with different CRS than caucasus_provinces shapefile, so cropping with different shapefile and extent
  # Human Footprint Index 2000 -- these need to be processed with a different extent and spdf
  targets::tar_target(name = HFI_2000_caucasus, command = terra::wrap(crop_mask_packedraster(get_caucasus_extent_HFI(), HFI_2000_data, reproject_caucasus_spdf(caucasus_provinces)))),
  # Human Footprint Index 2008 -- these need to be processed with a different extent (need different extent function)
  targets::tar_target(name = HFI_2008_caucasus, command = terra::wrap(crop_mask_packedraster(get_caucasus_extent_HFI(), HFI_2008_data, reproject_caucasus_spdf(caucasus_provinces)))),
  # Human Footprint Index 2018 -- these need to be processed with a different extent (need different extent function)
  targets::tar_target(name = HFI_2018_caucasus, command = terra::wrap(crop_mask_packedraster(get_caucasus_extent_HFI(), HFI_2018_data, reproject_caucasus_spdf(caucasus_provinces)))),
  
  # 3.) Combine protected area sf objects for each country and for the region
  targets::tar_target(name = protect_area_armenia, command = merge_protected_area_sf(protect_area_arm_data0, protect_area_arm_data1, protect_area_arm_data2)),
  targets::tar_target(name = protect_area_azerbaijan, command = merge_protected_area_sf(protect_area_aze_data0, protect_area_aze_data1, protect_area_aze_data2)),
  targets::tar_target(name = protect_area_georgia, command = merge_protected_area_sf(protect_area_geo_data0, protect_area_geo_data1, protect_area_geo_data2)),
  targets::tar_target(name = protect_area_caucasus, command = merge_protected_area_caucasus(protect_area_arm_data0, protect_area_arm_data1, protect_area_arm_data2,
                                                                                            protect_area_aze_data0, protect_area_aze_data1, protect_area_aze_data2,
                                                                                            protect_area_geo_data0, protect_area_geo_data1, protect_area_geo_data2)),
  
  
)


## Analysis
analysis_targets <- tar_plan(
  ## Example analysis target/s; delete and replace with your own analysis
  ## targets
 
)

## Outputs
outputs_targets <- tar_plan(
  ## This is a placeholder for any targets that produces outputs such as
  ## tables of model outputs, plots, etc. Delete or keep empty if you will not
  ## produce any of these types of outputs
)


## Report
report_targets <- tar_plan(
  ## Example Rmarkdown report target/s; delete and replace with your own
  ## Rmarkdown report target/s
  
  # tar_render(
  #   example_report, path = "reports/example_report.Rmd", 
  #   output_dir = "outputs", knit_root_dir = here::here()
  # )
)

## Deploy targets
deploy_targets <- tar_plan(
  ## This is a placeholder for any targets that are meant to deploy reports or
  ## any outputs externally e.g., website, Google Cloud Storage, Amazon Web
  ## Services buckets, etc. Delete or keep empty if you will not perform any
  ## deployments. The aws_s3_upload function requires AWS credentials to be loaded
  ## but will print a warning and do nothing if not
  
  # html_files = containerTemplateUtils::get_file_paths(tar_obj = example_report,
  #                                                     pattern = "\\.html$"),
  # uploaded_report = containerTemplateUtils::aws_s3_upload(html_files,
  #                                                       bucket = Sys.getenv("AWS_BUCKET"),
  #                                                       error = FALSE,
  #                                                       file_type = "html"),
  # email_updates= 
  #   containerTemplateUtils::send_email_update(
  #     to = strsplit(Sys.getenv("EMAIL_RECIPIENTS"),";")[[1]],
  #     from = Sys.getenv("EMAIL_SENDER"),
  #     project_name = "My Project",
  #     attach = TRUE
  #   )
)

# List targets -----------------------------------------------------------------

list(
  data_input_targets,
  data_processing_targets,
  analysis_targets,
  outputs_targets,
  report_targets,
  deploy_targets
)
