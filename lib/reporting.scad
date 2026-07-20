module report_grid_stack(
    project,
    material,
    boundary,
    path_policy,
    pattern_set,
    schedule,
    level = "summary"
) {
    echo("------------------------------------------------------------");
    echo(str("Grid Stack project: ", project[PR_NAME]));
    echo(str("Material profile: ", material[M_NAME]));
    echo(str("Boundary: ", boundary[B_NAME], " [", boundary[B_KIND], "]"));
    echo(str("Path policy: ", path_policy[PP_NAME]));
    echo(str("Pattern set: ", pattern_set[PS_NAME]));
    echo(str("Layer schedule: ", schedule[LS_NAME]));
    echo(str("Scheduled deposited layers: ", total_scheduled_layers(schedule)));
    echo(str("Nominal stack height: ", scheduled_height(schedule, material), " mm"));
    echo(str("Maximum unsupported span: ", material[M_BRIDGE_MAX], " mm"));
    echo(str("Bridge completion layers: ", material[M_BRIDGE_BUILD_LAYERS]));
    echo(str("One continuous nozzle path required: ", path_policy[PP_REQUIRE_CONTINUOUS]));

    if (level == "full") {
        echo("Layer groups [orientation, count, pattern, z-step multiplier]:");
        for (group = schedule[LS_GROUPS])
            echo([
                group[LG_ORIENTATION],
                group[LG_COUNT],
                group[LG_PATTERN_SET],
                group[LG_Z_STEP_MULTIPLIER]
            ]);

        echo("Pattern zones [name, pattern, band rule, band value, pitch, clear gap, connector]:");
        for (zone = pattern_set[PS_ZONES])
            echo([
                zone[Z_NAME],
                zone[Z_PATTERN],
                zone[Z_BAND_KIND],
                zone[Z_BAND_VALUE],
                zone[Z_STRAND_PITCH],
                zone_clear_gap(zone, material),
                zone[Z_CONNECTOR]
            ]);
    }

    echo("Batch 001 intentionally generates no geometry.");
    echo("------------------------------------------------------------");
}
