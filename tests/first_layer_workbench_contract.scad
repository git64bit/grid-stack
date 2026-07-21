//////////////////////////////////////////////////////////////////////
// LibFile: first_layer_workbench_contract.scad
// Project: Grid Stack
// FileGroup: Contract Test
// FileSummary: Verifies that variable first-layer settings are preset-ready.
//////////////////////////////////////////////////////////////////////

workbench_name = "first-layer";
project_name_selected = "FIRST_LAYER_TRACE_LAB";
render_mode = "trace_layer";
trace_count = 5;

include <../grid_stack.scad>
include <../config/defaults.scad>
include <../config/process_profiles.scad>
include <../registries/first_layer_projects.scad>
include <../config/workbenches.scad>

assert(wb_first_layer_trace_count == 5);
assert(len(wb_first_layer_traces) == 5);
assert(wb_first_layer_traces[0] == [-10, 10, 0]);
assert(workbench_render_mode_allowed("first-layer", "trace_layer"));
assert(FIRST_LAYER_PROJECTS[0][PR_NAME] == "FIRST_LAYER_TRACE_LAB");

echo("GRID STACK FIRST-LAYER WORKBENCH CONTRACT: PASS");
