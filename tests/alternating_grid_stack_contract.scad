//////////////////////////////////////////////////////////////////////
// LibFile: alternating_grid_stack_contract.scad
// Project: Grid Stack
// FileGroup: Contract Test
// FileSummary: Verifies equal-height X/Y alternation for laboratory panels.
//////////////////////////////////////////////////////////////////////

include <../grid_stack.scad>
include <../geometry/alternating_grid_stack.scad>

assert(deposited_grid_layer_orientation(0, 0) == 0,
    "X-first layer zero must be X-running.");
assert(deposited_grid_layer_orientation(1, 0) == 90,
    "X-first layer one must be Y-running.");
assert(deposited_grid_layer_orientation(2, 0) == 0,
    "X-first layer two must return to X-running.");
assert(deposited_grid_layer_orientation(0, 90) == 90,
    "Y-first layer zero must be Y-running.");
assert(deposited_grid_layer_orientation(1, 90) == 0,
    "Y-first layer one must be X-running.");

echo("GRID STACK ALTERNATING GRID STACK CONTRACT: PASS");
