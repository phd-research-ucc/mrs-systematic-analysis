

metadata <- list(
    pk = 'AR0027IR20',
    state = 'Read',
    grade = 'A',
    year = 2020,
    type = 'Article',
    domain = 'Scheduler',
    grasp = 0.8,
    group = 7,
    old_pk = '032IRSchedulingReview2020',
    title = "A state of the art review of intelligent scheduling",
    covid19 = FALSE,
    objectives = "Survey intelligent scheduling systems",
    conflict_of_interests = 'not mentioned',
    funding = 'not mentioned',
    outcomes = 'Neutral',
    comment = "Pros and cons of metaheuristics",
    url = 'https://doi.org/10.1007/s10462-018-9667-6'
)

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