//////////////////////////////////////////////////////////////////////
// LibFile: workbench_wrapper_contract.scad
// Project: Grid Stack
// FileGroup: Contract Test
// FileSummary: Verifies wrapper fallback resolution and preset compatibility.
//////////////////////////////////////////////////////////////////////

include <../config/defaults.scad>

assert(wb_workbench_name == "development");
assert(wb_project_name == "GRID_PANEL_LAB");
assert(wb_render_mode == "structural_grid");
assert(wb_lab_cells_x == 9 && wb_lab_cells_y == 9);
assert(wb_lab_deposited_layer_count == 8);
assert(wb_report_level == "full");

echo("GRID STACK WORKBENCH WRAPPER CONTRACT: PASS");
