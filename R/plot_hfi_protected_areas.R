#' Function to plot human footprint index and protected area data
#'
#'
#' @title plot_hfi_protected_areas
#'
#' @param HFI_data humanfootprint 2000 data file as packedspatraster
#' @param protected_area packedspatvector of protected areas
#' @param caucasus_provinces sf object to provide outline of admin1 boundries for 3 caucasus countries
#' @param georgia_provinces sf object to provide outline of admin1 boundries for Georgia
#'
#' 
#' @examples
#' plot_hfi_protected_areas(hfi_2018_caucasus, protected_area_caucasus, caucasus_provinces, georgia_provinces)
#' 

plot_hfi_protected_areas <- function(HFI_data, protected_area, caucasus_provinces, georgia_provinces){
# 1.)  rast to unpack packedspatraster
HFI_data_spatrast <- terra::rast(HFI_data)

# 2.)  vect to unpack packedspatvector
protected_area_spatvect <- terra::vect(protected_area)

# 3.)  reproject crs of spatvector to match hfi
protected_area_spatvect_hfi_projection <- terra::project(protected_area_spatvect, HFI_data_spatrast)

# 4.) Create scale
hfi_scale <- scale_fill_viridis_c(limits = c(0,51),
                                         option = "D",  
                                         na.value = "transparent",
                                         name = "Human Footprint
Index",
                                         breaks = c(1, 10, 20, 30, 40, 50))


# 5.) Create georgia, armenia, and azerbaijan labels
label_georgia <- grobTree(textGrob("Regions of
Georgia", x=0.05,  y=0.75, hjust=0, gp=gpar(col="black", fontsize=10)))
label_armenia <- grobTree(textGrob("Armenia", x=0.4,  y=0.25, hjust=0, gp=gpar(col="#5a5a5a", fontsize=10)))
label_azerbaijan <- grobTree(textGrob("Azerbaijan", x=0.83,  y=0.58, hjust=0, gp=gpar(col="#5a5a5a", fontsize=10)))
label_protected <- grobTree(textGrob("Protected
  Areas", x=0.52,  y=0.8, hjust=0, gp=gpar(col="#ff8080", fontsize=11)))

# 6.) Plot data
region_hfi <- ggplot() +
  geom_spatraster(data = HFI_data_spatrast) +
  #geom_sf(data = caucasus_provinces, fill = NA, color = "black") +
  geom_sf(data = georgia_provinces, fill = NA, color = "white") +
  geom_spatvector(data = protected_area_spatvect_hfi_projection, alpha = 0.1, color = "#ff8080") +
  hfi_scale +
  theme_void() +
  annotation_custom(label_georgia) +
  annotation_custom(label_armenia) +
  annotation_custom(label_azerbaijan) +
  annotation_custom(label_protected)


return(region_hfi)
}

# HFI 2018 data
#plot_hfi_protected_areas(hfi_2018_caucasus, protected_area_caucasus, caucasus_provinces, georgia_provinces)


