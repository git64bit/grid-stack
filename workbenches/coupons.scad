//////////////////////////////////////////////////////////////////////
// LibFile: coupons.scad
// Project: Grid Stack
// FileGroup: Executable Workbench
// FileSummary: Generic count-boundary coupon generator.
// Role: Coupon variants are named Customizer presets, not hard-coded projects.
//////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////
// GRID STACK CORE CONTRACT
// - One continuous open nozzle path per deposited layer.
// - No intentional lift, idle travel, or disconnected printed subpaths.
// - Parallel traces with perpendicular square connectors and square ends.
// - Alternating X/Y layers inside a rectangular count_boundary().
// - Cell count and clear span derive the outside dimensions; no filler border.
// - Conflicting topology or geometry grammar belongs in another project.
//////////////////////////////////////////////////////////////////////

/* [Coupon project] */
project_name_selected = "GRID_COUPON"; // [GRID_COUPON]

/* [Count boundary] */
coupon_cells_x = 3;
coupon_cells_y = 3;
coupon_clear_span_x = 6;
coupon_clear_span_y = 6;

/* [Continuous path] */
coupon_lead_in = 30;

/* [Layer stack] */
coupon_deposited_layer_height = 0.2;
coupon_deposited_layer_count = 2;
coupon_first_layer_orientation = "X"; // [X,Y]

/* [Render mode] */
render_mode = "structural_grid"; // [structural_grid,path_preview,report_only]

/* [Path diagnostic] */
show_boundary_envelope = true;
show_path_point_numbers = true;

/* [Console report] */
report_level = "full"; // [summary,full]

/* [Hidden] */
workbench_name = "coupons";
include <../main.scad>
