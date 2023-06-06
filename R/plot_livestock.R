#' Functions to plot GLW livestock data
#'
#'
#' @title plot_livestock_caucasus

#' @param summed_livestock_caucasus aggregation of GLW data file as packedspatraster
#' @param armenia_provinces sf object to provide outline of admin1 boundries for Armenia
#' @param armenia_provinces sf object to provide outline of admin1 boundries for Azerbaijan
#' @param georgia_provinces sf object to provide outline of admin1 boundries for Georgia
#'
#' 
#' @examples
#' plot_livestock_caucasus(summed_livestock_caucasus, caucasus_provinces, georgia_provinces)
#' 
#' 

plot_livestock_caucasus <- function(summed_livestock_caucasus, caucasus_provinces, georgia_provinces){

# 1.) rast to unpack packedspatraster
summed_livestock_caucasus_spatrast <- terra::rast(summed_livestock_caucasus)

# 2.) Create scale fill
livestock_scale <- scale_fill_viridis(
  rescaler = function(x, to = c(0, 1), from = NULL) {
    ifelse(x <= 228000,
           scales::rescale(x, to = to, from = c(min(x, na.rm = TRUE), 227000)),
           1)
  },
  breaks = c(50000, 228000, 635538),
  name = "Number of
livestock",
  na.value = "transparent"
)

# 3.) Create georgia, armenia, and azerbaijan labels
  label_georgia <- grobTree(textGrob("Regions of
Georgia", x=0.05,  y=0.75, hjust=0, gp=gpar(col="black", fontsize=10)))
  
  label_armenia <- grobTree(textGrob("Regions of
Armenia", x=0.35,  y=0.22, hjust=0, gp=gpar(col="#5a5a5a", fontsize=10)))
  
  label_azerbaijan <- grobTree(textGrob("Regions of
Azerbaijan", x=0.82,  y=0.64, hjust=0, gp=gpar(col="#5a5a5a", fontsize=10)))
  
  label_livestock_outlier_arm <- grobTree(textGrob("635000
livestock", x=0.27,  y=0.38, hjust=0, gp=gpar(col="red", fontsize=9)))
  
  label_livestock_outlier_aze <- grobTree(textGrob("228000
livestock", x=0.865,  y=0.5, hjust=0, gp=gpar(col="red", fontsize=9)))
  

# 4.) Plot data
ggplot() +
  geom_spatraster(data = summed_livestock_caucasus_spatrast,
                  aes(fill = sum_livestock), interpolate = TRUE) +
  geom_sf(data = caucasus_provinces, fill = NA, color = "#5a5a5a") +
  geom_sf(data = georgia_provinces, fill = NA, color = "white") +
  livestock_scale +
  theme_void() +
  annotation_custom(label_georgia) +
  annotation_custom(label_armenia) +
  annotation_custom(label_azerbaijan) +
  annotation_custom(label_livestock_outlier_arm) +
annotation_custom(label_livestock_outlier_aze)
}

#plot_livestock_caucasus(summed_livestock_caucasus, caucasus_provinces, georgia_provinces)










plot_livestock_caucasus_terra <- function(summed_livestock_caucasus, armenia_provinces, azerbaijan_provinces, georgia_provinces){

  # rast to unpack packedspatraster
  summed_livestock_caucasus_rast <- terra::rast(summed_livestock_caucasus)
  
  # plot GLW + outline of caucasus provinces
  terra::plot(summed_livestock_caucasus_rast,
              axes = FALSE,
              smooth = TRUE,
              plg=list(
                title = "   Number of
 livestock",
                title.cex=0.8,
                size = 0.7,
                loc = "right"))
  
  add_legend(legend = "Regions of
Georgia",    x=39.6, y= 42.7, pch = 15, col="#99cc99", cex = 0.9, bty="n")
  
  terra::plot(armenia_provinces$geometry,
              border = "darkgray",
              add = TRUE)
  add_legend(legend = "Regions of
Armenia",    x=42.6, y= 40, cex = 0.7, bty="n")
  
  terra::plot(azerbaijan_provinces$geometry,
              border = "darkgray",
              add = TRUE)
  add_legend(legend = "Regions of
Azerbaijan",    x=49, y= 41.5, cex = 0.7, bty="n")
  
  # last plot so it is on top of the gray borders
  terra::plot(georgia_provinces$geometry,
              add = TRUE)
}
plot_livestock_caucasus_terra(summed_livestock_caucasus, armenia_provinces, azerbaijan_provinces, georgia_provinces)


plot_livestock_country <- function(summed_livestock_country, country_provinces){
# rast to unpack packedspatraster
  summed_livestock_country_rast <- terra::rast(summed_livestock_country)

# plot GLW + outline of caucasus provinces
terra::plot(summed_livestock_country_rast,
            axes = FALSE,
            smooth = TRUE,
            buffer = TRUE,
            plg=list(
              title = "   Number of
 livestock",
              title.cex=0.8,
              size = 0.7,
              loc = "right"))

terra::plot(country_provinces$geometry,
            add = TRUE)
}
#plot_livestock_country(summed_livestock_georgia, georgia_provinces)
#plot_livestock_country(summed_livestock_armenia, armenia_provinces)
#plot_livestock_country(summed_livestock_azerbaijan, azerbaijan_provinces)
