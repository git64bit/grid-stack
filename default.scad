//////////////////////////////////////////////////////////////////////
// LibFile: default.scad
// Project: Grid Stack
// FileGroup: Development Workbench Entry Point
// FileSummary: Broad maintainer wrapper; specialized users open workbenches/.
//////////////////////////////////////////////////////////////////////

/* [Project selection] */
project_name_selected = "GRID_PANEL_LAB"; // [GRID_PANEL_LAB,GRID_COUPON,CATALOG_WORKBENCH_STUB,TUTORIAL_RECT_45654]

/* [Grid count boundary] */
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

/* [Framework audit] */
report_deferred_features_enabled = false;

/* [Console report] */
report_level = "full"; // [summary,full]

/* [Hidden] */
workbench_name = "development";
include <main.scad>
