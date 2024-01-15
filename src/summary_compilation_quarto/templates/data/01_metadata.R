
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
    pk = "EX0000MP24",
    relevance = 99,
    state = "Scan Reviewd",
    grade = "",
    certainty = 0,
    year = 2035,
    type = "-",
    domain = "-",
    grasp = 0.0,
    group = "-",
    old_pk = "EXAMPLE",
    title = "-",
    covid19 = FALSE,
    objectives = "-",
    coi = "not mentioned",
    funding = "not mentioned",
    outcomes = "Neutral",
    comment = "-",
    url = "https://doi.org/"
)
'
)