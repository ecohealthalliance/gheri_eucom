#' Function to aggregate/sum GLW spatrasters to Caucasus countries
#'
#'
#' @title sum_GLW_data

#' @param 
#'
#' @return 
#'
#' @examples
#' 
sum_GLW_data <- function(){
  
}

### THIS IS GENERALLY WHAT I THINK TO DO, BUT NOT SURE EXACTLY HOW TO MAKE IT WORK

# 1.) Loop to unpack GLW packed rasters?

# 2.) create a list of all the spatraster files
#spatrasters <- list.files(pattern = "_caucasus_GLW$", full.names = TRUE)

# 3.) load all the spatrasters into a SpatRasterList
#spatraster_list <- terra::rast(list_packspatrasters)

# 4.) create a new spatraster with a variable "sum_livestock"
#sum_livestock <- sum(spatraster_list)

# 5.) set the variable name to "sum_livestock"
#names(sum_livestock) <- "sum_livestock"

# 6.) save the new spatraster as a GeoTIFF file
#writeRaster(sum_livestock, "sum_livestock.tif", format = "GTiff", overwrite = TRUE)


