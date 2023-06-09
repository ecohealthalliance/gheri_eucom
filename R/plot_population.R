#' Function to plot human population data
#'
#'
#' @title plot_human_pop
#'
#' 
#' @examples
#' 
#' 
#' 

plot_human_pop <- function(western_asia_pop, western_asia_crop, georgia_provinces){
  
  # 1.) rast to unpack packedspatraster
  western_asia_pop_spatrast <- terra::rast(western_asia_pop)
  
  # 2.) Create scale fill
  pop_scale <- scale_fill_viridis(#palette = "Spectral",
                                    limits = c(0,30462),
                                           option = "H",  
                                           na.value = "transparent",
                                           name = "Number of
people",
                                           breaks = c(10000, 20000, 30000))
  
  # 3.) Create country labels
  label_georgia <- grobTree(textGrob("Regions of
Georgia", x=0.06,  y=0.73, hjust=0, gp=gpar(col="black", fontsize=10)))
  label_armenia <- grobTree(textGrob("Armenia", x=0.39,  y=0.5, hjust=0, gp=gpar(col="white", fontsize=10)))
  label_azerbaijan <- grobTree(textGrob("Azerbaijan", x=0.65,  y=0.4, hjust=0, gp=gpar(col="white", fontsize=10)))
  label_russia <- grobTree(textGrob("Russia", x=0.57,  y=0.85, hjust=0, gp=gpar(col="white", fontsize=10)))
  label_turkey <- grobTree(textGrob("Turkey", x=0.15,  y=0.28, hjust=0, gp=gpar(col="white", fontsize=10)))
  
  # 4.) Plot data
  ggplot() +
    geom_spatraster(data = western_asia_pop_spatrast,
                    aes(fill = ppp_2020_1km_Aggregated), interpolate = TRUE) +
    geom_spatvector(data = western_asia_crop, fill = "transparent", color = "black") +
    geom_sf(data = georgia_provinces, fill = NA, color = "white") +
    pop_scale +
    theme_void() +
    annotation_custom(label_georgia) +
    annotation_custom(label_armenia) +
    annotation_custom(label_azerbaijan) +
    annotation_custom(label_russia) +
    annotation_custom(label_turkey)

}

plot_human_pop(western_asia_pop, western_asia_crop, georgia_provinces)


