//////////////////////////////////////////////////////////////////////
// LibFile: laboratory_layer_height_contract.scad
// Project: Grid Stack
// FileGroup: Contract Test
// FileSummary: Verifies unrestricted direct-contact laboratory layer height.
//////////////////////////////////////////////////////////////////////

lab_deposited_layer_height = 10;
lab_deposited_layer_count = 3;

include <../grid_stack.scad>
include <../config/defaults.scad>
include <../config/materials.scad>
include <../config/nozzles.scad>
include <../registries/configurable_grid_projects.scad>

process = CONFIGURABLE_GRID_PROCESS_PROFILES[0];
nozzle = named_record(NOZZLES, process[PX_NOZZLE], "nozzle");

assert(nearly_equal(wb_lab_deposited_layer_height, 10));
assert(nearly_equal(wb_grid_deposited_layer_height, 10));
assert(nearly_equal(trace_height(process), 10));
assert(trace_height(process) > nozzle[NZ_DIAMETER]);
assert(nearly_equal(wb_grid_deposited_layer_count * trace_height(process), 30));

for (layer_index = [0 : wb_grid_deposited_layer_count - 1])
    assert(nearly_equal(layer_index * trace_height(process), layer_index * 10));

echo("GRID STACK UNRESTRICTED LABORATORY HEIGHT CONTRACT: PASS");
