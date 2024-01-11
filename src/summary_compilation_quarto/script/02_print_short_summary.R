# Meta Data --------------------------------------------------------------------
#
# Version:      1.0
# Author:       Oleksii Dovhaniuk
# Created on:   2024-01-11
# Updated on:   2024-01-11
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


# Script ----------------------------------------------------------------------


cat( glue(
    "**\"{
        metadata[['title']]
    }\"** is published in **{
        metadata[['year']]
    }**, and in the current study it represents **{
        domain
    }** domain. Objectives of the published material are: *{
        metadata[['objectives']]
    }*. The material was **{
        state
    }** and allocated to the **{
        metadata[['group']]
    }** [group](#subsection-material-groups). Subjectivally, after grasping **{
        metadata[['grasp']]*100
    }%** of the work's content, the summary author graded the reviewed work with **{
        metadata[['grade']]
    }** ([grading](#subsection-grading)). There is **{
        outcomes
    }** outcomes of the work, the work {
        pandemic_mentioned
    } COVID-19 pandemic or other pandemic outbreaks, the conflict of interests are **{
        metadata[['coi']]
    }**, and the funding is **{
        metadata[['funding']]
    }**.


    Local reference - **{metadata[['pk']]}**

    Previously mensioned as **{metadata[['old_pk']]}** 
    
    Short note: *{metadata[['comment']]}*

    The original **{type}** can be accessed by the following URL: *[{metadata[['url']]}]({metadata[['url']]})*"
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