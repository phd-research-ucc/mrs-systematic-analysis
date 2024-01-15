# Meta Data --------------------------------------------------------------------
#
# Version:      1.0
# Author:       Oleksii Dovhaniuk
# Created on:   2024-01-15
# Updated on:   2024-01-15
#
# Description:  Import metadata for reviewed references stored in excel.
#
# Location:     /script/_import_metadata.R
#


# Setup ------------------------------------------------------------------------

library(tidyverse)
library(readxl)
library(glue)




# Script -----------------------------------------------------------------------

papers_df <- read_excel('data/raw/2024-01-09_review_papers.xlsx') |> 
  filter(
    state != 'Duplicate'
  )

View(papers_df)



# Your R code
metadata_content <- glue(
    '
#
# LEGEND:
#
# States:
#   - ToDo;
#   - Scan Reviewed;
#   - Focus Reviewed;
#   - All-In Reviewed;
#   - Mastered;
#   - Rejected;
#   - Duplicate.
#
# Types:
#   - Article;
#   - Book;
#   - Online.
#
# Domains:
#   - Scheduler;
#   - Analyser;
#   - Both;
#   - None.
#
# Conflict of interests:
#   - None;
#   - Has CoI;
#   - Not mentioned.
#
# Fundings:
#   - Not funded;
#   - Partially funded;
#   - Fully funded;
#   - Multiple fundings;
#   - Not mentioned.


metadata <- list(
    pk = "{ papers_df$pk }",
    relevance = { as.integer(papers_df$relevance) },
    state = "{ papers_df$state }",
    grade = "{ papers_df$grade }",
    certainty = -99,
    year = { as.integer(papers_df$year) },
    type = "{ papers_df$type }",
    domain = "{ papers_df$domain }",
    grasp = { as.numeric(papers_df$grasp) },
    group = "{ papers_df$group }",
    old_pk = "{ papers_df$old_pk }",
    title = "{ papers_df$title }",
    covid19 = { as.logical(papers_df$covid19) },
    objectives = "{ papers_df$objectives }",
    coi = "{ papers_df$coi }",
    funding = "{ papers_df$funding }",
    outcomes = "Neutral",
    comment = "{ papers_df$comment }",
    url = "{ papers_df$url }"
    )
    '
)

# TODO: Source all templates for creating data files.
# # Specify the folder path
# source_path <- "path/to/your/folder"
# 
# # Get a list of file names in the folder
# file_list <- list.files(source_path, full.names = TRUE, re)
# 
# # Source each file
# for (file in file_list) {
#   source(file)
# }
# 
# folder_count <- sprintf('%04d', papers_df$count)

# Specify the folder name
folder_name <- glue('summary_compilation_quarto/import/{folder_count}')
file_name <- glue('{folder_name}/data/metadata.R')

for ( i in 1:length(folder_count) ) {
    dir.create(folder_name[i])
    dir.create(
        glue('{ folder_name[i] }/data')
    )

    # Write the code to the file
    writeLines(metadata_content[i], file_name[i])
}