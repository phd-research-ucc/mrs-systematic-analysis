# Meta Data --------------------------------------------------------------------
#
# Version:      1.0
# Author:       Oleksii Dovhaniuk
# Created on:   2024-01-11
# Updated on:   2024-01-12
#
# Description:  Outputs the short summary 
#               from the named list of metadata.
#
# Prerequisits: Loaded metadata
#
# Location:     script/02_print_short_summary.R
#


# Prepare Variables ----------------------------------------------------------------------

domain <- tolower( metadata[['domain']] )
state <- tolower( metadata[['state']] )
outcomes <- tolower( metadata[['outcomes']] )
pandemic_mentioned <- ifelse(
    metadata[['covid19']], 
    '**considers**', 
    '**does not consider**'
)
type <- tolower( metadata[['type']] )
certainty_points <- ifelse(
    metadata[['certainty']] == 1,
    glue("**{metadata[['certainty']]}** [certainty point](#subsection-certainty)"),
    glue("**{metadata[['certainty']]}** [certainty points](#subsection-certainty)")
)


# Script ----------------------------------------------------------------------


cat( glue(
    "_**\"{
        metadata[['title']]
    }\"**_ is published in **{
        metadata[['year']]
    }**, and in the current study it represents **{
        domain
    }** domain. Objectives of the published material are: *{
        metadata[['objectives']]
    }*. The material was **{
        state
    }** and allocated to the **{
        metadata[['group']]
    }** [group](#subsection-material-groups). After grasping **{
        metadata[['grasp']]*100
    }%** of the work's content, the reviewed work get **{
        metadata[['grade']]
    }** [general grade](#subsection-grading) and {
        certainty_points
    }. There is **{
        outcomes
    }** outcomes of the work, the work {
        pandemic_mentioned
    } COVID-19 pandemic or other pandemic outbreaks, the conflict of interests are **{
        metadata[['coi']]
    }**, and the funding is **{
        metadata[['funding']]
    }**.


    Local reference:<br>**{metadata[['pk']]}**

    Initial reference:<br>**{metadata[['old_pk']]}** 
    
    Short note:<br>_{metadata[['comment']]}_

    The original **{
        type
    }** can be accessed by the following URL:<br>*[{
        metadata[['url']]
    }]({metadata[['url']]})*"
    ) 
)


# Cleanup ----------------------------------------------------------------------

remove(
    domain,
    state,
    outcomes,
    pandemic_mentioned,
    type
)