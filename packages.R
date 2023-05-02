######################## LOAD R PACKAGES #######################################

################################################################################
#
#' R packages needed to run any/most {targets} workflows
#
################################################################################

library(targets)
library(tarchetypes)
library(tidyverse)
library(here)
library(knitr)
library(rmarkdown)
library(paws)
library(conflicted)

################################################################################
#
#' Additional R packages needed to run your specific workflow
#
################################################################################

library(data.table)
library(devtools)
library(dplyr)
library(elevatr)
library(fasterize)
library(here)
#library(maps)
#library(mapview)
library(raster)
library(remotes)
library(rgdal)
library(rnaturalearth)
library(rnaturalearthdata)
#library(spdplyr)
library(sf)
library(terra)
library(tibble)
library(tidyr)
library(tidyterra)
library(tidyverse)
library(RColorBrewer)
library(viridis)

library(rnaturalearthhires) # Had trouble installing this so used this code:
# remotes::install_github("ropensci/rnaturalearthhires")

