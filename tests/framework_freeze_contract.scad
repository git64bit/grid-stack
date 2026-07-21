//////////////////////////////////////////////////////////////////////
// LibFile: framework_freeze_contract.scad
// Project: Grid Stack
// FileGroup: Contract Test
// FileSummary: Static assertions for all frozen rectangular coupon records:
//              four XY spans, three positive Z gaps, and one direct reference.
// Role: Verifies naming, count-boundary dimensions, schedule semantics, and
//       deferred print status without relying on Customizer state.
// Requires: Current workbench interface, framework contract, and catalogs.
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

assert(GRID_STACK_RECTANGULAR_FRAMEWORK_VERSION == 1);
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
        3 * boundary[B_CLEAR_SPAN_X] + 4 * strand_width(process, nozzle)
    ));
}

for (schedule = COUPON_STACK_SCHEDULES) {
    assert(coupon_schedule_supported(schedule));
    assert(total_scheduled_path_layers(schedule) == 2);
    assert(total_scheduled_layers(schedule, process) == 4);
    assert(nearly_equal(
        scheduled_height(schedule, process),
        2 * strand_height(process) + coupon_schedule_clear_gap(schedule)
    ));
}

assert(coupon_print_geometry_supported(COUPON_STACK_SCHEDULES[0]));
for (i = [1 : len(COUPON_STACK_SCHEDULES) - 1])
    assert(!coupon_print_geometry_supported(COUPON_STACK_SCHEDULES[i]));

assert(coupon_project_name(3, 3, 5, 1) == "COUPON_3X3_SPAN5_GAP1");
assert(coupon_schedule_name(2) == "XGRID1_GAP2_YGRID1");

echo("GRID STACK FRAMEWORK FREEZE CONTRACT: PASS");
