//////////////////////////////////////////////////////////////////////
// LibFile: catalog.scad
// Project: Grid Stack
// FileGroup: Executable Workbench
// FileSummary: Reserved catalog-only Customizer and rendering entry point.
// Role: Establishes the future product catalog route without exposing coupon
//       or laboratory controls. Future route: /catalog.
// Includes: ../main.scad after all user-facing assignments.
//////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////
// GRID STACK CORE CONTRACT
// - One continuous open nozzle path per deposited layer.
// - No intentional lift, idle travel, or disconnected printed subpaths.
// - Parallel traces with perpendicular square connectors and square ends.
// - Alternating X/Y structural layers inside a rectangular count_boundary().
// - Cell count and clear span derive the outside dimensions; no filler border.
// - Trace size comes from the qualified nozzle and deposited layer height.
// - Structural strands require at least two width and two height passes.
// - Clear span, Z gap, trace size, and strand size remain distinct values.
// - Saved objects are immutable SCAD recipes pinned to a versioned API.
// - Laboratory objects reach Catalog only after physical acceptance.
// - Conflicting topology or geometry grammar belongs in another project.
//////////////////////////////////////////////////////////////////////
/* [Catalog project] */
project_name_selected = "CATALOG_WORKBENCH_STUB"; // [CATALOG_WORKBENCH_STUB]

/* [Console report] */
report_level = "full"; // [summary,full]

/* [Hidden] */
workbench_name = "catalog";
render_mode = "report_only";
include <../main.scad>
