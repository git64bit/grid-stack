//////////////////////////////////////////////////////////////////////
// LibFile: structural_coupon_contract.scad
// Project: Grid Stack
// FileGroup: Contract Test
// FileSummary: Static assertions for the accepted direct-contact rectangular
//              coupon under framework contract version 2.
// Role: Verifies derived dimensions, path starts, point counts, composition,
//       and immutable direct-contact strategy selection.
// Requires: Current workbench foundation and rectangular coupon path modules.
// Output: Console assertions only.
//////////////////////////////////////////////////////////////////////

include <../grid_stack.scad>
include <../lib/coupon_framework.scad>
include <../paths/structural_coupon_paths.scad>

material = material_spec("PLA_PLUS", "PLA+", "rigid", "in_use");
nozzle = nozzle_spec("BRASS_0P4", 0.4, "brass", "in_use");
process = process_profile(
    "PLA_PLUS_0P4_LH0P2_W2_H2_R1",
    "PLA_PLUS", "BRASS_0P4", 0.2, 2, 2, 6,
    "owner_tested", 1
);
boundary = count_boundary(
    "COUNT_3X3_SPAN6", 3, 3, 6, 6,
    "rectangle", 4, 0, 0
);
schedule = stack_schedule(
    coupon_schedule_name(0),
    [
        path_layer_group(0, 1, "SQUARE_COUPON", 0),
        path_layer_group(90, 1, "SQUARE_COUPON", 0)
    ]
);

lower = structural_coupon_path(boundary, process, nozzle, 0, 30);
upper = structural_coupon_path(boundary, process, nozzle, 90, 0);

assert(GRID_STACK_RECTANGULAR_FRAMEWORK_VERSION == 2);
assert(nearly_equal(strand_width(process, nozzle), 0.8));
assert(nearly_equal(strand_height(process), 0.4));
assert(nearly_equal(boundary_size_x(boundary, process, nozzle), 21.2));
assert(nearly_equal(boundary_size_y(boundary, process, nozzle), 21.2));
assert(len(lower) == 9);
assert(len(upper) == 8);
assert(nearly_equal(point_distance_2d(lower[1], upper[0]), 0));
assert(path_is_axis_aligned(lower));
assert(path_is_axis_aligned(upper));
assert(coupon_print_geometry_supported(schedule, process));
assert(coupon_support_strategy(schedule) == "direct_orthogonal");

echo("GRID STACK STRUCTURAL COUPON CONTRACT: PASS");
