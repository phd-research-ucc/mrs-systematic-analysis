# Meta Data ---------------------------------------------------------------
#
# Medical Resource Scheduling Systematic Literature Review
# 01_setup.R
#




# Import Packages ----------------------------------------------------------------

library(tidyverse)
library(bib2df)
library(writexl)
library(stringi)
library(glue)





# Read File ---------------------------------------------------------------

references_df <- bib2df("src/data/raw/references.bib")

ref_important_df <- references_df |>
  select(
    CATEGORY,
    BIBTEXKEY,
    AUTHOR,
    TITLE,
    YEAR,
    ABSTRACT,
    DATE,
    DATE.ADDED,
    DATE.MODIFIED,
    DOI,
    URL,
    KEYWORDS,
    # ISSN,
    # EISSN,
    # JT,
    # JID,
    # JOURNAL1,
    # JOURNAL2,
    # BOOKTITLE,
    # EDITOR,
    # INSTITUTION,
    # ORGANISATION,
    # PUBLISHER
  )

names(ref_important_df) <- tolower(names(ref_important_df))

ref_important_df <- ref_important_df |>
  rename(
    date_added = date.added,
    date_modified = date.modified,
    bibtex_key = bibtexkey
  )




# Clear and Restore Years -------------------------------------------------

ref_important_df$clear_year <- substr(ref_important_df$year, 1, 4)
ref_important_df$restored_year <- ifelse(
  is.na(ref_important_df$clear_year) | length(ref_important_df$clear_year) < 4,
  substr(ref_important_df$date_added, 1, 4),
  ref_important_df$clear_year
) 

ref_restored_years_df <- ref_important_df |>
  select(-year, -clear_year, -date, -date_added, -date_modified) |>
  rename(year = restored_year)

table(is.na(ref_restored_years_df$year))


ref_restored_years_df$restored_url <- ifelse(
  is.na(ref_restored_years_df$url) & !is.na(ref_restored_years_df$doi),
  paste0('https://doi.org/', ref_restored_years_df$doi),
  ref_restored_years_df$url
)

ref_restored_urls_df <- ref_restored_years_df |>
  select(-url) |>
  rename(url = restored_url)




# Clear DOI ---------------------------------------------------------------

ref_restored_urls_df$clear_doi <- ifelse(
  substr(ref_restored_urls_df$doi, 1, 16) == 'https://doi.org/',
  substr(ref_restored_urls_df$doi, 17, length(ref_restored_urls_df$doi)),
  ref_restored_urls_df$doi
)

ref_clear_dois_df <- ref_restored_urls_df |>
  select(-doi) |>
  rename(doi = clear_doi)





# Separate and Clear Authors ----------------------------------------------
# TODO:
#   1. format letters from for example "{\\\"u}" to "ü";
#   2. clear start and end of the authors names from "{" and "}"
#   3. add columns: "department", "institution", "country", "iso2", "email",
#                   "phone", "orcid", "researcher_domain"

authors_df <- ref_clear_dois_df |>
  mutate(author = stri_unescape_unicode(ref_clear_dois_df$author)) |>
  mutate(author = strsplit(as.character(author), '\", \"')) |>
  select(bibtex_key, author) |>
  unnest(author) |>
  na.omit()

table(is.na(authors_df$author))

authors_df$author <- ifelse(
  substr(authors_df$author, 1, 3) == 'c(\"',
  substr(authors_df$author, 4, length(authors_df$author)),
  authors_df$author
)

authors_df$author <- gsub("\\)$", "", authors_df$author)
authors_df$author <- gsub("\\\"$", "", authors_df$author)




# Split into Groups -------------------------------------------------------
# TODO:
#   1. Define resources' visible attributes 
#      for pre-splitting them into groups:
#     a) Online resources are in category "ONLINE";
#     b) Reviews often are mentioned as "review" 
#        in titles, keywords, and abstracts;
#     c) Specialised works contain words like "scheduling", "operation",
#        "patient", etc. in titles, keywords, and abstracts;
#     d) Case study is sometime mention in titles, keywords, and abstracts.
#
#   2. Split into groups: 
#     SR -> Specialised Reviews, related to MRS problem;
#     SO -> Specialised Online posts, ads, commercial articles;
#     SC -> Specialised Case and application of the previous theory on practice;
#     SM -> Specialised Models developed specially for MRS problems;
#     SF -> Specialised Full work of developing model and implementing it;
#     ST -> Specialised Theory works;
#     SA -> Specialised Administration related works;
#     AR -> Alternative Reviews of methods applicable to MRS;
#     AO -> Alternative Online resources;
#     AC -> Alternative Case which applied in a similar field or 
#           somehow related to MRS problems;
#     AF -> Alternative Full work of developing model and implementing it;
#     AM -> Alternative Models for scheduling resources;
#     AT -> Alternative Theory works;
#     AA -> Alternative Administration related works;
#     HP -> Healthcare policies and rules;
#     ND -> Undefined;
#     NA -> Other.
#
#   3. Add column "group" to manually alter the group based on the review.
#
#   4. Also group by the year of publication: 2020+, 2015-2019, 2010-2014,
#      2005-2009, 2000-2004, before 2000.

literature_df <- ref_clear_dois_df |>
  mutate(
    research_methodology = ifelse(
      ( grepl('review', title, ignore.case = TRUE) |
        grepl('review', abstract, ignore.case = TRUE) |
        grepl('review', keywords, ignore.case = TRUE) ),
      'review',
      'undefined'
    ),
    spaciality = ifelse(
        ( grepl('operating', title, ignore.case = TRUE) |
          grepl('operating', abstract, ignore.case = TRUE) |
          grepl('operating', keywords, ignore.case = TRUE) ),
      'specialised',
      'undefined'
    ),
    category = tolower(category),
    iso2 = 'undefined',
    direction = as.factor('undefined'),
    relevance = NA,
    review_url = 'undefined',
    comment = '',
    status = as.factor('unprocessed'),
    objectives = '',
    objectives_reached = as.logical(NA),
    conflict_of_interests = '',
    resource_status = as.factor('undefined'),
    environment = as.factor('undefined'),
    provider = as.factor('undefined'),
    unsertainty = as.logical(NA),
    covid19 = as.logical(NA),
    comprehension = 0.00,
    last_access_date = as.Date("2023-11-16"),
    update_date = as.Date("2023-11-16")
  )

# Write the literature data frame to an Excel file
write_xlsx(literature_df, glue('src/data/edit/{Sys.Date()}_literature.xlsx'))

# Separate Keywords -------------------------------------------------------


keywords_df <- ref_clear_dois_df |>
  mutate(keyword = strsplit(as.character(keywords), ',')) |>
  unnest(keyword) |>
  mutate(keyword = strsplit(as.character(keyword), ';')) |>
  unnest(keyword) |>
  select(bibtex_key, keyword) |>
  mutate(
    keyword = trimws(keyword),
    keyword_type = 'undefined'
  )

# Write the keywords data frame to an Excel file
write_xlsx(keywords_df, glue('src/data/edit/{Sys.Date()}_keywords.xlsx'))


