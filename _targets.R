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


# Read in World Population data 
# WorldPop Population Counts: Population 2020
# https://www.worldpop.org/geodata/summary?id=24777
# downloaded manually and saved in raw_data
# folder as "ppp_2020_1km_Aggregated.tif"

data_input_targets <- tar_plan(
  # Read in World Population data 
  # WorldPop Population Counts: Population 2020
  # https://www.worldpop.org/geodata/summary?id=24777
  # downloaded manually and saved in raw_data
  # folder as "ppp_2020_1km_Aggregated.tif"
  targets::tar_target(name = world_pop, command = terra::rast(here("raw_data/ppp_2020_1km_Aggregated.tif")))
  
  #Add admisntrative info abotu data soruces
#  targets::tar_target(name = country_provinces, command = get_country_province()
)


## Data processing
data_processing_targets <- tar_plan(
  ## Example data processing target/s; delete and replace with your own data
  ## processing targets
  
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
