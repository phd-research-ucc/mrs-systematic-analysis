

# Get a list of R script files in the 03_data folder
script_files <- list.files(
    path = '03_data', 
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