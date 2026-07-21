//////////////////////////////////////////////////////////////////////
// LibFile: laboratory_grid_stack.scad
// Project: Grid Stack
// FileGroup: Laboratory Contract
// FileSummary: Validates and reports the configurable alternating deposited
//              layers used by GRID_PANEL_LAB.
// Role: Keeps laboratory stack controls explicit without changing the frozen
//       coupon schedule schema or immutable coupon APIs.
// Requires: Core record indexes and process/boundary mathematics.
// Exports: laboratory_orientation_degrees(),
//          validate_laboratory_grid_stack(), and
//          report_laboratory_grid_stack().
//////////////////////////////////////////////////////////////////////

GRID_STACK_LABORATORY_STACK_VERSION = 2;

// Function: laboratory_orientation_degrees()
// Synopsis: Converts the user-facing X/Y selector to path degrees.
function laboratory_orientation_degrees(first_orientation) =
    assert(first_orientation == "X" || first_orientation == "Y",
        "Laboratory first-layer orientation must be X or Y.")
    first_orientation == "X" ? 0 : 90;

// Module: validate_laboratory_grid_stack()
// Synopsis: Enforces the Grid Stack contract for one mutable panel stack.
module validate_laboratory_grid_stack(
    project,
    process,
    nozzle,
    boundary,
    path_policy_record,
    pattern_set_record,
    deposited_layer_count,
    deposited_layer_height,
    first_orientation
) {
    assert(GRID_STACK_LABORATORY_STACK_VERSION == 2,
        "Unexpected laboratory stack contract version.");
    assert(boundary_is_count_driven(boundary) &&
           boundary[B_KIND] == "rectangle",
        "Laboratory grid panels require rectangular count_boundary().");
    assert(boundary[B_EDGE_MARGIN] == 0,
        "Laboratory count grids cannot add a filler border.");
    assert(coupon_pattern_supported(pattern_set_record),
        "Laboratory grid panels currently require SQUARE_COUPON.");
    assert(path_policy_record[PP_REQUIRE_CONTINUOUS],
        "Every deposited grid layer must use one continuous path.");
    assert(!path_policy_record[PP_ALLOW_TRAVEL] &&
           !path_policy_record[PP_ALLOW_LIFT] &&
           !path_policy_record[PP_ALLOW_CLOSED_SUBPATHS],
        "Laboratory grid layers cannot permit travel, lift, or closed subpaths.");
    assert(path_policy_record[PP_LEAD_OUT] == 0,
        "Laboratory grid panels have one open endpoint and no lead-out.");
    assert(process[PX_WIDTH_PASSES] >= 2 &&
           process[PX_HEIGHT_PASSES] >= 2,
        "The laboratory grid must retain the two-pass structural process.");
    assert(deposited_layer_height > 0,
        "Deposited layer height must be positive.");
    assert(nearly_equal(trace_height(process), deposited_layer_height),
        "Laboratory process and Customizer layer height must agree.");
    assert(process[PX_QUALIFICATION] == "laboratory_unqualified",
        "Mutable grid-panel work must use a laboratory process profile.");
    assert(deposited_layer_count >= 1 &&
           is_integer_value(deposited_layer_count),
        "Deposited layer count must be a positive integer.");
    assert(first_orientation == "X" || first_orientation == "Y",
        "First deposited layer must be X or Y.");
    assert(project[PR_PROCESS] == process[PX_NAME],
        "Laboratory project process lookup failed.");
    assert(project[PR_BOUNDARY] == boundary[B_NAME],
        "Laboratory project boundary lookup failed.");
    assert(project[PR_PATH_POLICY] == path_policy_record[PP_NAME],
        "Laboratory project path-policy lookup failed.");
    assert(project[PR_PATTERN_SET] == pattern_set_record[PS_NAME],
        "Laboratory project pattern lookup failed.");
    assert(nozzle[NZ_DIAMETER] > 0,
        "Laboratory nozzle diameter must be positive.");

    echo("GRID STACK LABORATORY STACK VALIDATION: PASS");
}

// Module: report_laboratory_grid_stack()
// Synopsis: Reports the resolved deposited-layer stack and dimensions.
module report_laboratory_grid_stack(
    project,
    process,
    material,
    nozzle,
    boundary,
    path_policy_record,
    deposited_layer_count,
    deposited_layer_height,
    first_orientation,
    report_level = "full"
) {
    deposited_height = trace_height(process);

    assert(nearly_equal(deposited_height, deposited_layer_height),
        "Reported layer height must match the Customizer value.");
    total_height = deposited_layer_count * deposited_height;

    echo("------------------------------------------------------------");
    echo(str("Grid Stack laboratory project: ", project[PR_NAME]));
    echo(str("Material: ", material[MAT_NAME]));
    echo(str("Nozzle: ", nozzle[NZ_DIAMETER], " mm"));
    echo(str("Uniform deposited layer height: ", deposited_height, " mm"));
    echo(str("Composed path width: ", strand_width(process, nozzle), " mm"));
    echo(str("Count boundary: ", boundary[B_CELLS_X], " x ",
        boundary[B_CELLS_Y], " clear openings"));
    echo(str("Clear span: ", boundary[B_CLEAR_SPAN_X], " x ",
        boundary[B_CLEAR_SPAN_Y], " mm"));
    echo(str("Resolved outside size: ",
        boundary_size_x(boundary, process, nozzle), " x ",
        boundary_size_y(boundary, process, nozzle), " mm"));
    echo(str("Deposited layer count: ", deposited_layer_count));
    echo(str("First deposited orientation: ", first_orientation));
    echo(str("Alternation: ", first_orientation,
        first_orientation == "X" ? ", Y, X, Y..." : ", X, Y, X..."));
    echo(str("Total stack height: ", total_height, " mm"));
    echo(str("First-layer lead-in: ", path_policy_record[PP_LEAD_IN], " mm"));
    echo("Every deposited layer rests directly on the preceding layer.");
    echo("One continuous open path is generated for every deposited layer.");

    if (deposited_height > nozzle[NZ_DIAMETER])
        echo(str(
            "LABORATORY NOTICE: selected deposited layer height ",
            deposited_height, " mm exceeds nozzle diameter ",
            nozzle[NZ_DIAMETER],
            " mm. Geometry is permitted but the process is unqualified."
        ));

    if (report_level == "full")
        for (layer_index = [0 : deposited_layer_count - 1])
            echo(str(
                "Layer ", layer_index + 1,
                ": orientation=",
                deposited_grid_layer_orientation(
                    layer_index,
                    laboratory_orientation_degrees(first_orientation)
                ) == 0 ? "X" : "Y",
                ", Z=", layer_index * deposited_height, " mm"
            ));

    echo("------------------------------------------------------------");
}
