//////////////////////////////////////////////////////////////////////
// LibFile: core_contract.scad
// Project: Grid Stack
// FileGroup: Core Contract
// FileSummary: Declares and enforces the geometry and process limits that
//              define this repository as Grid Stack.
// Role: Prevents workbenches and future generated wrappers from silently
//       expanding the project into unrelated path or geometry systems.
// Requires: The frozen rectangular framework validator.
// Exports: GRID_STACK_CORE_CONTRACT_VERSION,
//          validate_grid_stack_core_contract(), and
//          report_grid_stack_core_contract().
//////////////////////////////////////////////////////////////////////

GRID_STACK_CORE_CONTRACT_VERSION = 1;

// Grid Stack exists only for the following model:
//   1. One continuous open nozzle path per deposited layer.
//   2. No intentional lift, idle travel, or disconnected printed subpaths.
//   3. Parallel traces joined by perpendicular square connectors.
//   4. Alternating X/Y structural grid layers.
//   5. Rectangular count_boundary() geometry.
//   6. Cell count and clear span derive the outside dimensions.
//   7. Square trace terminations and square turns.
//   8. Trace size derives from the qualified nozzle and layer height.
//   9. Structural strands use at least two width passes and two height passes.
//  10. Clear span, Z gap, trace size, and strand size remain distinct values.
//  11. Unsupported spans are reported against the qualified process limit.
//  12. No perimeter border is added merely to reach a requested dimension.
//  13. Permanent objects are immutable SCAD recipes pinned to an API version.
//  14. Laboratory objects enter Catalog only after physical acceptance.
//  15. Any conflicting topology or geometry grammar belongs in another project.

module validate_grid_stack_core_contract(
    project,
    process,
    nozzle,
    boundary,
    path_policy_record,
    pattern_set_record,
    schedule
) {
    assert(GRID_STACK_CORE_CONTRACT_VERSION == 1,
        "Unexpected Grid Stack core-contract version.");

    validate_rectangular_coupon_framework(
        project,
        process,
        nozzle,
        boundary,
        path_policy_record,
        pattern_set_record,
        schedule
    );

    echo("GRID STACK CORE CONTRACT: PASS");
}

module report_grid_stack_core_contract() {
    echo(str("Grid Stack core contract version: ",
        GRID_STACK_CORE_CONTRACT_VERSION));
    echo("Core: continuous open path, square rectangular count grid, alternating X/Y layers.");
    echo("Scope boundary: incompatible path topology or geometry belongs in another project.");
}
