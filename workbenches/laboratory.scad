//////////////////////////////////////////////////////////////////////
// LibFile: laboratory.scad
// Project: Grid Stack
// FileGroup: Executable Workbench
// FileSummary: Mutable Grid Panel laboratory and deferred-project entry point.
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

/* [Laboratory project] */
project_name_selected = "GRID_PANEL_LAB"; // [GRID_PANEL_LAB,TUTORIAL_RECT_45654]

/* [Grid panel count boundary] */
lab_cells_x = 9;
lab_cells_y = 9;
lab_clear_span_x = 6;
lab_clear_span_y = 6;

/* [Continuous path] */
lab_lead_in = 30;

/* [Layer stack] */
lab_deposited_layer_height = 0.2;
lab_deposited_layer_count = 8;
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
