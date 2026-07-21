//////////////////////////////////////////////////////////////////////
// LibFile: alternating_grid_stack_contract.scad
// Project: Grid Stack
// FileGroup: Contract Test
// FileSummary: Verifies equal-height X/Y alternation.
//////////////////////////////////////////////////////////////////////

include <../grid_stack.scad>
include <../paths/rectangular_grid.scad>
include <../geometry/alternating_grid_stack.scad>

assert(deposited_grid_layer_orientation(0, 0) == 0);
assert(deposited_grid_layer_orientation(1, 0) == 90);
assert(deposited_grid_layer_orientation(2, 0) == 0);
assert(deposited_grid_layer_orientation(0, 90) == 90);
assert(deposited_grid_layer_orientation(1, 90) == 0);

echo("GRID STACK ALTERNATING GRID STACK CONTRACT: PASS");
