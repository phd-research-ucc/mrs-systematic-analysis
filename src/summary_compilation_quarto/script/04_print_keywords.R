# Meta Data --------------------------------------------------------------------
#
# Version:      1.0
# Author:       Oleksii Dovhaniuk
# Created on:   2024-01-12
# Updated on:   2024-01-12
#
# Description:  Outputs the publication's keywords.
#
# Prerequisits: Loaded keywords
#
# Location:     script/04_print_keywords.R
#


# Functions -------------------------------------------------------------------

hl <- function(text, keyword_type, colour='teal'){
    colour <- case_when(
        keyword_type == 'method' ~ '#75A267',
        keyword_type == 'objectives' ~ '#B8B500',
        keyword_type == 'subject' ~ '#3CB0CD',
        keyword_type == 'property' ~ '#AD62F8',
        keyword_type == 'tool' ~ '#CB527D',
        TRUE ~ colour
    )
    glue("<span style='color: { colour };'>{ text }</span>")
}




# Script ----------------------------------------------------------------------

cat( glue(" _{ hl(keywords$keyword, keywords$keyword_type) }_<br>") )
cat(  
    glue(
        "<br>**Colours explained:** _{ hl('Method', 'method') }, { hl('Objectives', 'objectives') }, { hl('Subject', 'subject') }, { hl('Property', 'property') }, { hl('Tool', 'tool') }_
        "
    ) 
)

