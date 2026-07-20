//////////////////////////////////////////////////////////////////////
// LibFile: reporting.scad
// Project: Grid Stack
// FileGroup: Reporting
// FileSummary: Prints the resolved environment and project specification.
// Role: Makes hidden vector fields inspectable before geometry exists.
// Requires: Active records and derived process functions.
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
    echo(str("Maximum unsupported span: ", process[PX_BRIDGE_MAX], " mm"));
    echo(str("Boundary: ", boundary[B_NAME], " [", boundary[B_KIND], "]"));
    echo(str("Path policy: ", path_policy[PP_NAME]));
    echo(str("Pattern set: ", pattern_set[PS_NAME]));
    echo(str("Layer schedule: ", schedule[LS_NAME]));
    echo(str("Scheduled deposited layers: ", total_scheduled_layers(schedule)));
    echo(str("Nominal stack height: ", scheduled_height(schedule, process), " mm"));
    echo(str("One continuous nozzle path required: ",
        path_policy[PP_REQUIRE_CONTINUOUS]));

    if (level == "full") {
        echo("Layer groups [orientation, count, pattern, z-step multiplier]:");
        for (group = schedule[LS_GROUPS])
            echo([
                group[LG_ORIENTATION], group[LG_COUNT],
                group[LG_PATTERN_SET], group[LG_Z_STEP_MULTIPLIER]
            ]);

        echo("Pattern zones [name, pattern, band rule, band value, pitch, clear gap, connector]:");
        for (zone = pattern_set[PS_ZONES])
            echo([
                zone[Z_NAME], zone[Z_PATTERN], zone[Z_BAND_KIND],
                zone[Z_BAND_VALUE], zone[Z_STRAND_PITCH],
                zone_clear_gap(zone, process, nozzle), zone[Z_CONNECTOR]
            ]);
    }

    echo("Batch 002 intentionally generates no geometry.");
    echo("------------------------------------------------------------");
}
