//////////////////////////////////////////////////////////////////////
// LibFile: configurable_grid_stack.scad
// Project: Grid Stack
// FileGroup: Configurable Grid Contract
// FileSummary: Validates and reports Customizer-defined grid stacks.
//////////////////////////////////////////////////////////////////////

function grid_orientation_degrees(first_orientation) =
    assert(first_orientation == "X" || first_orientation == "Y",
        "First-layer orientation must be X or Y.")
    first_orientation == "X" ? 0 : 90;

module validate_configurable_grid_stack(
    project, process, material, nozzle, boundary,
    path_policy_record, pattern_set_record,
    deposited_layer_count, first_orientation
) {
    validate_material(material);
    validate_nozzle(nozzle);
    validate_process(process, material, nozzle, true);
    validate_boundary(boundary, process, nozzle);
    validate_path_policy(path_policy_record);
    validate_pattern_set(pattern_set_record, boundary, process, nozzle);
    validate_configurable_grid_core_contract(
        process, nozzle, boundary, path_policy_record,
        pattern_set_record, deposited_layer_count, first_orientation
    );
    assert(project[PR_PROCESS] == process[PX_NAME],
        "Configurable project process lookup failed.");
    assert(project[PR_BOUNDARY] == boundary[B_NAME],
        "Configurable project boundary lookup failed.");
    echo("GRID STACK CONFIGURABLE GRID VALIDATION: PASS");
}

module report_configurable_grid_stack(
    project, process, material, nozzle, boundary,
    path_policy_record, deposited_layer_count,
    first_orientation, report_level = "full"
) {
    deposited_height = trace_height(process);
    total_height = deposited_layer_count * deposited_height;

    echo("------------------------------------------------------------");
    echo(str("Grid Stack project: ", project[PR_NAME]));
    echo(str("Material: ", material[MAT_NAME]));
    echo(str("Nozzle: ", nozzle[NZ_DIAMETER], " mm"));
    echo(str("Deposited layer height: ", deposited_height, " mm"));
    echo(str("Composed path width: ", strand_width(process, nozzle), " mm"));
    echo(str("Count boundary: ", boundary[B_CELLS_X], " x ", boundary[B_CELLS_Y]));
    echo(str("Clear span: ", boundary[B_CLEAR_SPAN_X], " x ",
        boundary[B_CLEAR_SPAN_Y], " mm"));
    echo(str("Resolved outside size: ",
        boundary_size_x(boundary, process, nozzle), " x ",
        boundary_size_y(boundary, process, nozzle), " mm"));
    echo(str("Deposited layer count: ", deposited_layer_count));
    echo(str("First orientation: ", first_orientation));
    echo(str("Total stack height: ", total_height, " mm"));
    echo(str("First-layer lead-in: ", path_policy_record[PP_LEAD_IN], " mm"));
    echo("Every layer rests directly on the preceding layer.");

    if (deposited_height > nozzle[NZ_DIAMETER])
        echo(str("WORKBENCH NOTICE: layer height ", deposited_height,
            " mm exceeds nozzle diameter ", nozzle[NZ_DIAMETER],
            " mm. Geometry is permitted but unqualified."));

    if (report_level == "full")
        for (layer_index = [0 : deposited_layer_count - 1])
            echo(str("Layer ", layer_index + 1,
                ": orientation=",
                deposited_grid_layer_orientation(
                    layer_index, grid_orientation_degrees(first_orientation)
                ) == 0 ? "X" : "Y",
                ", Z=", layer_index * deposited_height, " mm"));
    echo("------------------------------------------------------------");
}
