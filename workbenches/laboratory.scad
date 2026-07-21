//////////////////////////////////////////////////////////////////////
// LibFile: laboratory.scad
// Project: Grid Stack
// FileGroup: Executable Workbench
// FileSummary: Laboratory-only Customizer and printable experiment entry point.
// Role: Isolates mutable experiments and deferred projects from coupon and
//       catalog users. Future route: /laboratory.
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

/* [Laboratory project] */
project_name_selected = "GRID_PANEL_LAB"; // [GRID_PANEL_LAB,TUTORIAL_RECT_45654]

/* [Grid panel count boundary] */
lab_cells_x = 9; // [1:1:40]
lab_cells_y = 9; // [1:1:40]
lab_clear_span_x = 6; // [0.4:0.2:20]
lab_clear_span_y = 6; // [0.4:0.2:20]

/* [Continuous path] */
lab_lead_in = 30; // [0:1:100]

/* [Layer stack] */
// Uniform physical height added by every deposited pass.
lab_deposited_layer_height = 0.2; // [0.05:0.05:0.4]
lab_deposited_layer_count = 8; // [1:1:100]
lab_first_layer_orientation = "X"; // [X,Y]

/* [Render mode] */
render_mode = "structural_grid"; // [structural_grid,path_preview,report_only]

/* [Path diagnostic] */
show_boundary_envelope = true;
show_path_point_numbers = true;

/* [Deferred features] */
report_deferred_features_enabled = false;

/* [Console report] */
report_level = "full"; // [summary,full]

/* [Hidden] */
workbench_name = "laboratory";
include <../main.scad>
