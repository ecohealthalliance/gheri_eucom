<!-- README.md is generated from README.Rmd. Please edit that file -->

# South Caucasus Drivers of Zoonotic Disease

<!-- badges: start -->

[![Project Status: WIP -- Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip) [![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental) [![container-workflow-template](https://github.com/ecohealthalliance/container-template/actions/workflows/container-workflow-template.yml/badge.svg)](https://github.com/ecohealthalliance/container-template/actions/workflows/container-workflow-template.yml)

<!-- badges: end -->

This repository is used to map global data sets on drivers of zoonotic disease spillover, emergence, and spread downscaled to the South Caucasus region for presentation and comparison across countries.

The repo uses a containerised R workflow built on the `targets` framework, made portable using `renv`.

## Data

All data is publicly available and can be directly downloaded online. Data sources and direct download links are in the '\_targets.R' file.

## Functions

Individual functions for manipulating the data are available in the 'R' folder.

## Related Outputs

Maps generated through this repo are embedded in in-depth country reports that take stock of and assess One Health operations in the South Caucasus region. These reports highlight the progress that Armenia, Azerbaijan, and Georgia have made in implementing the One Health approach, while identifying continued needs for One Health system strengthening.

-   Armenia report (English and Armenian): <https://zenodo.org/doi/10.5281/zenodo.10094792>

-   Azerbaijan report (English and Azerbaijani): <https://zenodo.org/doi/10.5281/zenodo.10048711>

-   Georgia report (English and Georgian): <https://zenodo.org/doi/10.5281/zenodo.10048349>

## Funder

This work was made possible through the support of the Uniformed Services University of the Health Sciences (USU) (Award number HU00012010031 -- *Strengthening Multisectoral Approaches to Biodefense and Biosurveillance in the Caucasus*). The information or content and conclusions do not necessarily represent the official position or policy of, nor should any official endorsement be inferred on the part of, USU, the Department of Defense, or the U.S. Government.
