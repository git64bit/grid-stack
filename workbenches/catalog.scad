//////////////////////////////////////////////////////////////////////
// LibFile: catalog.scad
// Project: Grid Stack
// FileGroup: Executable Workbench
// FileSummary: Reserved catalog-only Customizer and rendering entry point.
// Role: Establishes the future product catalog route without exposing coupon
//       or laboratory controls. Future route: /catalog.
// Includes: ../main.scad after all user-facing assignments.
//////////////////////////////////////////////////////////////////////

/* [Catalog project] */
project_name_selected = "CATALOG_WORKBENCH_STUB"; // [CATALOG_WORKBENCH_STUB]

/* [Console report] */
report_level = "full"; // [summary,full]

/* [Hidden] */
workbench_name = "catalog";
render_mode = "report_only";
include <../main.scad>
