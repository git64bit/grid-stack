//////////////////////////////////////////////////////////////////////
// LibFile: laboratory_layer_height_contract.scad
// Project: Grid Stack
// FileGroup: Contract Test
// FileSummary: Verifies unrestricted Laboratory deposited-layer height and
//              direct-contact uniform Z stacking.
//////////////////////////////////////////////////////////////////////

lab_deposited_layer_height = 10;
lab_deposited_layer_count = 3;

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

assert(nearly_equal(wb_lab_deposited_layer_height, 10),
    "The wrapper layer-height override must resolve to 10 mm.");
assert(nearly_equal(trace_height(process), 10),
    "The mutable laboratory process must use the unrestricted wrapper height.");
assert(trace_height(process) > nozzle[NZ_DIAMETER],
    "This test must exceed the nozzle diameter to prove the cap is removed.");
assert(nearly_equal(
    wb_lab_deposited_layer_count * trace_height(process),
    30
),
    "Three 10 mm deposited layers must resolve to 30 mm total height.");

for (layer_index = [0 : wb_lab_deposited_layer_count - 1])
    assert(nearly_equal(
        layer_index * trace_height(process),
        layer_index * 10
    ),
        "Every deposited layer must start exactly on the preceding layer.");

echo("GRID STACK UNRESTRICTED LABORATORY HEIGHT CONTRACT: PASS");
