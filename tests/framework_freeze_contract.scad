//////////////////////////////////////////////////////////////////////
// LibFile: framework_freeze_contract.scad
// Project: Grid Stack
// FileGroup: Contract Test
// FileSummary: Static assertions for the frozen rectangular framework:
//              twelve positive-gap cases plus one direct-contact reference.
// Role: Verifies naming, count-boundary dimensions, schedule quantization,
//       printable support strategies, and retained deferred stubs.
// Requires: Current workbench foundation, framework contract, and catalogs.
// Output: Console assertions only.
//////////////////////////////////////////////////////////////////////

include <../grid_stack.scad>
include <../lib/coupon_framework.scad>
include <../config/materials.scad>
include <../config/nozzles.scad>
include <../config/process_profiles.scad>
include <../config/boundaries.scad>
include <../config/patterns.scad>
include <../config/schedules.scad>
include <../config/coupons.scad>
include <../config/path_policies.scad>
include <../config/projects.scad>

process = named_record(
    PROCESS_PROFILES,
    "PLA_PLUS_0P4_LH0P2_W2_H2_R1",
    "process profile"
);
nozzle = named_record(NOZZLES, process[PX_NOZZLE], "nozzle");

assert(GRID_STACK_RECTANGULAR_FRAMEWORK_VERSION == 2);
assert(len(COUPON_BOUNDARIES) == 4);
assert(len(COUPON_VERTICAL_GAPS) == 3);
assert(len(COUPON_MATRIX_PROJECTS) == 12);
assert(len(DIRECT_REFERENCE_PROJECTS) == 1);
assert(DIRECT_CONTACT_REFERENCE_PROJECT ==
    "COUPON_3X3_SPAN6_GAP0_DIRECT");

for (boundary = COUPON_BOUNDARIES) {
    assert(coupon_boundary_supported(boundary));
    assert(boundary_strand_count_x(boundary) == 4);
    assert(boundary_strand_count_y(boundary) == 4);
    assert(nearly_equal(
        boundary_size_x(boundary, process, nozzle),
        3 * boundary[B_CLEAR_SPAN_X] +
        4 * strand_width(process, nozzle)
    ));
}

for (schedule = COUPON_STACK_SCHEDULES) {
    assert(coupon_schedule_supported(schedule));
    assert(coupon_print_geometry_supported(schedule, process));
    assert(total_scheduled_path_layers(schedule) == 2);
    assert(nearly_equal(
        coupon_gap_layer_count(schedule, process),
        round(coupon_gap_layer_count(schedule, process))
    ));
}

assert(coupon_support_strategy(COUPON_STACK_SCHEDULES[0]) ==
    "direct_orthogonal");
for (i = [1 : len(COUPON_STACK_SCHEDULES) - 1])
    assert(coupon_support_strategy(COUPON_STACK_SCHEDULES[i]) ==
        "witness_riser_bridge");

assert(coupon_project_name(3, 3, 5, 1) == "COUPON_3X3_SPAN5_GAP1");
assert(coupon_schedule_name(2) == "YWITNESS1_GAP2_YTEST1_RISERX");

// Deferred boundary and pattern records remain lookup-visible.
assert(len(DEFERRED_BOUNDARIES) == 3);
assert(len(DEFERRED_PROJECTS) == 1);

echo("GRID STACK FRAMEWORK FREEZE CONTRACT: PASS");
