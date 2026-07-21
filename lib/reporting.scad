//////////////////////////////////////////////////////////////////////
// LibFile: reporting.scad
// Project: Grid Stack
// FileGroup: Reporting
// FileSummary: Prints the resolved environment, boundary mode, pattern, and
//              complete structural path-layer stack schedule.
// Role: Makes hidden vector fields inspectable before geometry exists.
// Requires: Active records and derived math functions.
// Exports: report_grid_stack().
//////////////////////////////////////////////////////////////////////

module report_grid_stack(
    project, process, material, nozzle, boundary,
    path_policy, pattern_set, schedule, level = "summary"
) {
    echo("------------------------------------------------------------");
    echo(str("Grid Stack project: ", project[PR_NAME]));
    echo(str("Process environment: ", process[PX_NAME]));
    echo(str("Material: ", material[MAT_NAME], " [", material[MAT_FAMILY], "]"));
    echo(str("Nozzle: ", nozzle[NZ_NAME], " / ", nozzle[NZ_DIAMETER], " mm"));
    echo(str("Single trace basis: ", trace_width(nozzle), " x ",
        trace_height(process), " mm"));
    echo(str("Structural pass composition: ", process[PX_WIDTH_PASSES],
        " wide x ", process[PX_HEIGHT_PASSES], " high"));
    echo(str("Composed structural strand: ", strand_width(process, nozzle),
        " x ", strand_height(process), " mm"));
    echo(str("Maximum qualified unsupported span: ",
        process[PX_BRIDGE_MAX], " mm"));
    echo(str("Boundary: ", boundary[B_NAME], " [", boundary[B_MODE],
        " / ", boundary[B_KIND], "]"));
    echo(str("Resolved outside size: ",
        boundary_size_x(boundary, process, nozzle), " x ",
        boundary_size_y(boundary, process, nozzle), " mm"));

    if (boundary_is_count_driven(boundary)) {
        echo(str("Clear-opening count: ", boundary[B_CELLS_X], " x ",
            boundary[B_CELLS_Y]));
        echo(str("Structural-strand count: ",
            boundary_strand_count_x(boundary), " x ",
            boundary_strand_count_y(boundary)));
        echo(str("Clear span: ", boundary[B_CLEAR_SPAN_X], " x ",
            boundary[B_CLEAR_SPAN_Y], " mm"));
        echo(str("Strand pitch: ",
            boundary_strand_pitch_x(boundary, process, nozzle), " x ",
            boundary_strand_pitch_y(boundary, process, nozzle), " mm"));
    }

    echo(str("Path policy: ", path_policy[PP_NAME]));
    echo(str("Pattern set: ", pattern_set[PS_NAME]));
    echo(str("Stack schedule: ", schedule[SS_NAME]));
    echo(str("Scheduled complete structural path layers: ",
        total_scheduled_path_layers(schedule)));
    echo(str("Required deposited layers: ",
        total_scheduled_layers(schedule, process)));
    echo(str("Material height: ",
        scheduled_material_height(schedule, process), " mm"));
    echo(str("Clear vertical height: ",
        scheduled_clear_height(schedule), " mm"));
    echo(str("Total stack height: ",
        scheduled_height(schedule, process), " mm"));
    echo(str("One continuous nozzle path required: ",
        path_policy[PP_REQUIRE_CONTINUOUS]));

    if (level == "full") {
        echo("Path-layer groups [orientation, layer count, pattern, clear gap after]:");
        for (group = schedule[SS_GROUPS])
            echo([
                group[PLG_ORIENTATION], group[PLG_LAYER_COUNT],
                group[PLG_PATTERN_SET], group[PLG_CLEAR_GAP_AFTER]
            ]);

        echo("Pattern zones [name, pattern, spacing source, X clear span, X pitch, connector]:");
        for (zone = pattern_set[PS_ZONES])
            echo([
                zone[Z_NAME], zone[Z_PATTERN], zone[Z_SPACING_SOURCE],
                zone_clear_span(zone, boundary, process, nozzle, "x"),
                zone_strand_pitch(zone, boundary, process, nozzle, "x"),
                zone[Z_CONNECTOR]
            ]);
    }

    echo("Render capability is selected by the calling entry point.");
    echo("------------------------------------------------------------");
}
