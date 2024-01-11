# Meta Data --------------------------------------------------------------------
#
# Version:      1.0
# Author:       Oleksii Dovhaniuk
# Created on:   2024-01-10
# Updated on:   2024-01-11
#
# Description:  Collects all mined data from the
#               analysed literature material into
#               R's global environment or Quarto 
#               process environment.
#
# Location:     script/01_gather_data.R
#




# Script ----------------------------------------------------------------------


# Get a list of R script files in the 03_data folder
script_files <- list.files(
    path = 'data', 
    pattern = '\\.R$', 
    full.names = TRUE
)

# Source each R script
for (script in script_files) {
  source(script)
}

# Clear excessive variables
remove(
  script,
  script_files
)