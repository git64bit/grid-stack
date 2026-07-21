//////////////////////////////////////////////////////////////////////
// LibFile: default.scad
// Project: Grid Stack
// FileGroup: Development Workbench Entry Point
// FileSummary: Executable cross-project wrapper for framework development.
// Role: Owns the broad Customizer used by maintainers. Normal users should
//       open a specialized file under workbenches/.
// Includes: main.scad after all user-facing assignments.
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
/* [Project selection] */
project_name_selected = "COUPON_3X3_SPAN6_GAP1"; // [COUPON_3X3_SPAN6_GAP0_DIRECT,COUPON_3X3_SPAN5_GAP1,COUPON_3X3_SPAN5_GAP2,COUPON_3X3_SPAN5_GAP3,COUPON_3X3_SPAN6_GAP1,COUPON_3X3_SPAN6_GAP2,COUPON_3X3_SPAN6_GAP3,COUPON_3X3_SPAN7_GAP1,COUPON_3X3_SPAN7_GAP2,COUPON_3X3_SPAN7_GAP3,COUPON_3X3_SPAN8_GAP1,COUPON_3X3_SPAN8_GAP2,COUPON_3X3_SPAN8_GAP3,GRID_PANEL_LAB,CATALOG_WORKBENCH_STUB,TUTORIAL_RECT_45654]

/* [Render mode] */
render_mode = "structural_coupon"; // [structural_coupon,structural_grid,path_preview,report_only]

/* [Path diagnostic] */
path_orientation = 0; // [0:X-running,90:Y-running]
show_boundary_envelope = true;
show_path_point_numbers = true;

/* [Laboratory grid panel] */
lab_cells_x = 9; // [1:1:40]
lab_cells_y = 9; // [1:1:40]
lab_clear_span_x = 6; // [0.4:0.2:20]
lab_clear_span_y = 6; // [0.4:0.2:20]
lab_lead_in = 30; // [0:1:100]

/* [Coupon series] */
report_coupon_series_enabled = false;
coupon_series_name_selected = "PLA_PLUS_BRIDGE_GAP_3X3"; // [PLA_PLUS_BRIDGE_GAP_3X3]

/* [Framework audit] */
report_deferred_features_enabled = false;

/* [Console report] */
report_level = "full"; // [summary,full]

/* [Hidden] */
workbench_name = "development";
include <main.scad>
