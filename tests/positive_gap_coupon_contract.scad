//////////////////////////////////////////////////////////////////////
// LibFile: positive_gap_coupon_contract.scad
// Project: Grid Stack
// FileGroup: Contract Test
// FileSummary: Static assertions for the 3 x 3, 6 mm span, 2 mm gap
//              witness/riser/bridge coupon.
// Role: Verifies path alignment, layer quantization, riser support, and total
//       height before the full immutable matrix is printed.
// Requires: Current workbench foundation, framework, and coupon paths.
// Output: Console assertions only.
//////////////////////////////////////////////////////////////////////

include <../grid_stack.scad>
include <../lib/coupon_framework.scad>
include <../paths/structural_coupon_paths.scad>

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
    coupon_schedule_name(2),
    [
        path_layer_group(90, 1, "SQUARE_COUPON", 2),
        path_layer_group(90, 1, "SQUARE_COUPON", 0)
    ]
);

witness = structural_coupon_path(boundary, process, nozzle, 90, 30);
riser = structural_coupon_path(boundary, process, nozzle, 0, 0);
test = structural_coupon_path(boundary, process, nozzle, 90, 0);

assert(coupon_support_strategy(schedule) == "witness_riser_bridge");
assert(coupon_print_geometry_supported(schedule, process));
assert(nearly_equal(coupon_gap_layer_count(schedule, process), 10));
assert(len(witness) == 9);
assert(len(riser) == 8);
assert(len(test) == 8);
assert(nearly_equal(point_distance_2d(witness[1], riser[0]), 0));
assert(nearly_equal(point_distance_2d(riser[0], test[0]), 0));
for (i = [0 : len(test) - 1])
    assert(nearly_equal(point_distance_2d(test[i], witness[i + 1]), 0));
assert(nearly_equal(2 * strand_height(process) + 2, 2.8));

echo("GRID STACK POSITIVE-GAP COUPON CONTRACT: PASS");
