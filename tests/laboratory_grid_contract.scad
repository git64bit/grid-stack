//////////////////////////////////////////////////////////////////////
// LibFile: laboratory_grid_contract.scad
// Project: Grid Stack
// FileGroup: Contract Test
// FileSummary: Verifies the default 9 x 9 laboratory grid-panel experiment.
//////////////////////////////////////////////////////////////////////

include <../grid_stack.scad>
include <../lib/coupon_framework.scad>
include <../config/core_contract.scad>
include <../geometry/alternating_grid_stack.scad>
include <../lib/laboratory_grid_stack.scad>
include <../config/defaults.scad>
include <../config/materials.scad>
include <../config/nozzles.scad>
include <../config/process_profiles.scad>
include <../registries/laboratory_projects.scad>
include <../config/boundaries.scad>
include <../config/path_policies.scad>
include <../config/patterns.scad>

project = LABORATORY_PRINTABLE_PROJECTS[0];
process = named_record(PROCESS_PROFILES, project[PR_PROCESS], "process");
nozzle = named_record(NOZZLES, process[PX_NOZZLE], "nozzle");
boundary = named_record(BOUNDARIES, project[PR_BOUNDARY], "boundary");
policy = named_record(PATH_POLICIES, project[PR_PATH_POLICY], "path policy");
pattern = named_record(PATTERN_SETS, project[PR_PATTERN_SET], "pattern");

assert(project[PR_NAME] == "GRID_PANEL_LAB",
    "Unexpected laboratory grid-panel project name.");
assert(boundary[B_CELLS_X] == 9 && boundary[B_CELLS_Y] == 9,
    "Laboratory grid panel must default to a 9 x 9 count boundary.");
assert(boundary[B_CLEAR_SPAN_X] == 6 && boundary[B_CLEAR_SPAN_Y] == 6,
    "Laboratory grid panel must default to 6 mm clear spans.");
assert(policy[PP_LEAD_IN] == 30,
    "Laboratory grid panel must default to a 30 mm lead-in.");

assert(wb_lab_deposited_layer_count == 8,
    "Laboratory grid panel must default to eight deposited layers.");
assert(wb_lab_first_layer_orientation == "X",
    "Laboratory grid panel must default to an X-running first layer.");
assert(nearly_equal(
    wb_lab_deposited_layer_count * trace_height(process), 1.6
),
    "Default laboratory stack height must be 1.6 mm.");

validate_laboratory_grid_stack(
    project,
    process,
    nozzle,
    boundary,
    policy,
    pattern,
    wb_lab_deposited_layer_count,
    wb_lab_first_layer_orientation
);

echo("GRID STACK LABORATORY GRID CONTRACT: PASS");
