# Meta Data --------------------------------------------------------------------
#
# Version:      1.0
# Author:       Oleksii Dovhaniuk
# Created on:   2024-01-12
# Updated on:   2024-01-12
#
# Description:  Outputs the authors' affiliations.
#
# Prerequisits: Loaded affiliations
#
# Location:     script/03_print_affiliations.R
#




# Script ----------------------------------------------------------------------

cat(  
    glue(
        "**{
            affiliations$author_name
        }**<br>_{
            affiliations$author_affiliation
        }_<br><br>"
    ) 
)

