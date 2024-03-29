#' Function to plot human footprint index
#'
#'
#' @title plot_hfi
#'
#' @param HFI_data humanfootprint 2000 data file as packedspatraster
#' @param caucasus_provinces sf object to provide outline of admin1 boundries for 3 caucasus countries
#' @param georgia_provinces sf object to provide outline of admin1 boundries for Georgia
#'
#' 
#' @examples
#' plot_hfi(hfi_2018_caucasus, protected_area_caucasus, caucasus_provinces, georgia_provinces)
#' 

#Adjust function and line of code below function to plot based on each country (georgia, armenia, azerbaijan), and if
#you're doing the region as a whole vs just one country.
#Need to comment out text and adjjust label positions

plot_hfi <- function(HFI_data, caucasus_provinces, georgia_provinces){
  # 1.)  rast to unpack packedspatraster
  HFI_data_spatrast <- terra::rast(HFI_data)
  
  # 2.) Create scale
  hfi_scale <- scale_fill_viridis_c(limits = c(0,51),
                                    option = "D",  
                                    na.value = "transparent",
                                    name = "Human Footprint
Index",
                                    breaks = c(1, 10, 20, 30, 40, 50))
  
  # 3.) Create georgia, armenia, and azerbaijan labels
  #label_georgia <- grobTree(textGrob("Regions of
#Georgia", x=0.05,  y=0.75, hjust=0, gp=gpar(col="black", fontsize=10)))
  
  #label_armenia <- grobTree(textGrob("Armenia", x=0.4,  y=0.25, hjust=0, gp=gpar(col="#5a5a5a", fontsize=10)))
  
  #label_azerbaijan <- grobTree(textGrob("Azerbaijan", x=0.83,  y=0.54, hjust=0, gp=gpar(col="black", fontsize=10)))
  
  # 4.) Plot data
  region_hfi <- ggplot() +
    geom_spatraster(data = HFI_data_spatrast) +
    #geom_sf(data = caucasus_provinces, fill = NA, color = "black") +
    geom_sf(data = georgia_provinces, fill = NA, color = "#cccccc") +
    hfi_scale +
    theme_void() 
    #annotation_custom(label_georgia) +
    #annotation_custom(label_armenia)
    #annotation_custom(label_azerbaijan)
  
  return(region_hfi)
}

# HFI 2000 data
#plot_hfi(hfi_2000_georgia, georgia_provinces, georgia_provinces)
# HFI 2018 data
#plot_hfi(hfi_2018_georgia, georgia_provinces, georgia_provinces)

