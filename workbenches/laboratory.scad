//////////////////////////////////////////////////////////////////////
// LibFile: laboratory.scad
// Project: Grid Stack
// FileGroup: Executable Workbench
// FileSummary: Laboratory-only Customizer and reporting entry point.
// Role: Isolates experimental and deferred projects from coupon and catalog
//       users. Future route: /laboratory.
// Includes: ../main.scad after all user-facing assignments.
//////////////////////////////////////////////////////////////////////

/* [Laboratory project] */
project_name_selected = "TUTORIAL_RECT_45654"; // [TUTORIAL_RECT_45654]

/* [Deferred features] */
report_deferred_features_enabled = true;

/* [Console report] */
report_level = "full"; // [summary,full]

/* [Hidden] */
workbench_name = "laboratory";
render_mode = "report_only";
include <../main.scad>
