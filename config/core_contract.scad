//////////////////////////////////////////////////////////////////////
// LibFile: core_contract.scad
// Project: Grid Stack
// FileGroup: Core Contract
// FileSummary: Enforces the fixed topology shared by all Grid Stack objects.
//////////////////////////////////////////////////////////////////////

GRID_STACK_CORE_CONTRACT_VERSION = 2;

module validate_configurable_grid_core_contract(
    process,
    nozzle,
    boundary,
    path_policy_record,
    pattern_set_record,
    deposited_layer_count,
    first_orientation
) {
    assert(GRID_STACK_CORE_CONTRACT_VERSION == 2,
        "Unexpected Grid Stack core-contract version.");
    assert(boundary_is_count_driven(boundary) && boundary[B_KIND] == "rectangle",
        "Grid Stack requires rectangular count_boundary().");
    assert(boundary[B_EDGE_MARGIN] == 0,
        "Grid Stack does not add a filler perimeter border.");
    assert(pattern_set_record[PS_NAME] == "SQUARE_COUPON",
        "Grid Stack currently requires the square-grid pattern.");
    assert(path_policy_record[PP_REQUIRE_CONTINUOUS] &&
           !path_policy_record[PP_ALLOW_TRAVEL] &&
           !path_policy_record[PP_ALLOW_LIFT] &&
           !path_policy_record[PP_ALLOW_CLOSED_SUBPATHS],
        "Each layer must remain one continuous open nozzle path.");
    assert(path_policy_record[PP_LEAD_OUT] == 0,
        "Grid Stack has one open endpoint and no lead-out.");
    assert(process[PX_WIDTH_PASSES] >= 2 && process[PX_HEIGHT_PASSES] >= 2,
        "Grid Stack retains the minimum two-pass structural process.");
    assert(deposited_layer_count >= 1 && is_integer_value(deposited_layer_count),
        "Deposited layer count must be a positive integer.");
    assert(first_orientation == "X" || first_orientation == "Y",
        "First layer orientation must be X or Y.");
    assert(nozzle[NZ_DIAMETER] > 0,
        "Nozzle diameter must be positive.");

    echo("GRID STACK CORE CONTRACT: PASS");
}

module report_grid_stack_core_contract() {
    echo(str("Grid Stack core contract version: ", GRID_STACK_CORE_CONTRACT_VERSION));
    echo("Core: continuous open path, square rectangular count grid, alternating X/Y layers.");
    echo("Scope boundary: incompatible topology or geometry belongs in another project.");
}
