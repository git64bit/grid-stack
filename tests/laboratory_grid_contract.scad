//////////////////////////////////////////////////////////////////////
// LibFile: laboratory_grid_contract.scad
// Project: Grid Stack
// FileGroup: Contract Test
// FileSummary: Verifies the default preset-enabled 9 x 9 laboratory panel.
//////////////////////////////////////////////////////////////////////

include <../grid_stack.scad>
include <../config/core_contract.scad>
include <../config/defaults.scad>
include <../config/materials.scad>
include <../config/nozzles.scad>
include <../config/process_profiles.scad>
include <../registries/configurable_grid_projects.scad>
include <../config/boundaries.scad>
include <../config/path_policies.scad>
include <../config/patterns.scad>
include <../registries/laboratory_projects.scad>
include <../paths/rectangular_grid.scad>
include <../geometry/alternating_grid_stack.scad>
include <../lib/configurable_grid_stack.scad>

project = LABORATORY_PRINTABLE_PROJECTS[0];
process = CONFIGURABLE_GRID_PROCESS_PROFILES[0];
material = named_record(MATERIALS, process[PX_MATERIAL], "material");
nozzle = named_record(NOZZLES, process[PX_NOZZLE], "nozzle");
boundary = CONFIGURABLE_GRID_BOUNDARIES[0];
policy = CONFIGURABLE_GRID_PATH_POLICIES[0];
pattern = named_record(PATTERN_SETS, project[PR_PATTERN_SET], "pattern");

assert(project[PR_NAME] == "GRID_PANEL_LAB");
assert(boundary[B_CELLS_X] == 9 && boundary[B_CELLS_Y] == 9);
assert(boundary[B_CLEAR_SPAN_X] == 6 && boundary[B_CLEAR_SPAN_Y] == 6);
assert(policy[PP_LEAD_IN] == 30);
assert(nearly_equal(trace_height(process), 0.2));
assert(wb_grid_deposited_layer_count == 8);
assert(wb_grid_first_layer_orientation == "X");

validate_configurable_grid_stack(
    project, process, material, nozzle, boundary,
    policy, pattern, wb_grid_deposited_layer_count,
    wb_grid_first_layer_orientation
);

echo("GRID STACK LABORATORY GRID CONTRACT: PASS");
