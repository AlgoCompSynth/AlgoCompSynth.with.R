#! /usr/bin/env Rscript

to_install <- c(
  "audio",
  "caracas",
  "data.table",
  "devtools",
  "DiagrammeR",
  "knitcitations",
  "learnr",
  "miniUI",
  "monitoR",
  "phonTools",
  "pkgdown",
  "renv",
  "reticulate",
  "rTorch",
  "seewave",
  "signal",
  "soundecology",
  "soundgen",
  "tidyverse",
  "tuneR",
  "warbleR"
)
install.packages(to_install, quiet = TRUE)
warnings()
reticulate::py_discover_config()

library(tidyverse)
print("Installed")
installed <- as_tibble(installed.packages()) %>% select(Package, Version); installed %>% print(n = Inf)
print("Missing")
print(setdiff(to_install, installed$Package))
