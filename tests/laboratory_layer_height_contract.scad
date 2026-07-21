//////////////////////////////////////////////////////////////////////
// LibFile: laboratory_layer_height_contract.scad
// Project: Grid Stack
// FileGroup: Contract Test
// FileSummary: Verifies that the Laboratory Customizer layer-height value
//              rebuilds the mutable process and changes every Z increment.
//////////////////////////////////////////////////////////////////////

lab_deposited_layer_height = 0.3;
lab_deposited_layer_count = 8;

include <../grid_stack.scad>
include <../lib/coupon_framework.scad>
include <../geometry/alternating_grid_stack.scad>
include <../lib/laboratory_grid_stack.scad>
include <../config/defaults.scad>
include <../config/materials.scad>
include <../config/nozzles.scad>
include <../config/process_profiles.scad>
include <../registries/laboratory_projects.scad>

process = LABORATORY_PROCESS_PROFILES[0];
nozzle = named_record(NOZZLES, process[PX_NOZZLE], "nozzle");

assert(nearly_equal(wb_lab_deposited_layer_height, 0.3),
    "The wrapper layer-height override must resolve to 0.3 mm.");
assert(nearly_equal(trace_height(process), 0.3),
    "The mutable laboratory process must use the wrapper layer height.");
assert(trace_height(process) <= nozzle[NZ_DIAMETER],
    "The test layer height must remain valid for the selected nozzle.");
assert(nearly_equal(
    wb_lab_deposited_layer_count * trace_height(process),
    2.4
),
    "Eight 0.3 mm deposited layers must resolve to 2.4 mm total height.");

for (layer_index = [0 : wb_lab_deposited_layer_count - 1])
    assert(nearly_equal(
        layer_index * trace_height(process),
        layer_index * 0.3
    ),
        "Every deposited layer must use the same Z increment.");

echo("GRID STACK LABORATORY LAYER HEIGHT CONTRACT: PASS");
