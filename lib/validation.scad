module validate_material(material) {
    assert(material[M_NOZZLE_D] > 0, "Nozzle diameter must be positive.");
    assert(material[M_LINE_W] > 0, "Line width must be positive.");
    assert(material[M_LAYER_H] > 0, "Layer height must be positive.");
    assert(material[M_LAYER_H] <= material[M_NOZZLE_D],
        "Layer height should not exceed nozzle diameter in this project.");
    assert(material[M_BRIDGE_MAX] > 0, "Bridge limit must be positive.");
    assert(material[M_BRIDGE_STRAND_W] >= material[M_LINE_W],
        "Bridge strand width must be at least one line width.");
    assert(is_integer_value(material[M_BRIDGE_BUILD_LAYERS]) &&
           material[M_BRIDGE_BUILD_LAYERS] >= 1,
        "Bridge build layers must be a positive integer.");
    assert(material[M_MIN_CLEAR_GAP] >= 0,
        "Minimum clear gap cannot be negative.");
    assert(material[M_MAX_CLEAR_GAP] >= material[M_MIN_CLEAR_GAP],
        "Maximum clear gap must not be smaller than minimum clear gap.");
}

module validate_boundary(boundary) {
    assert(boundary[B_SIZE_X] > 0 && boundary[B_SIZE_Y] > 0,
        "Boundary dimensions must be positive.");
    assert(boundary[B_EDGE_MARGIN] >= 0,
        "Boundary edge margin cannot be negative.");

    if (boundary[B_KIND] == "regular_polygon")
        assert(boundary[B_SIDES] >= 3 && is_integer_value(boundary[B_SIDES]),
            "A regular polygon requires an integer side count of at least three.");
}

module validate_path_policy(policy) {
    assert(policy[PP_LEAD_IN] >= 0 && policy[PP_LEAD_OUT] >= 0,
        "Lead-in and lead-out lengths cannot be negative.");

    if (policy[PP_REQUIRE_CONTINUOUS]) {
        assert(!policy[PP_ALLOW_TRAVEL],
            "A continuous-nozzle path cannot permit travel moves.");
        assert(!policy[PP_ALLOW_LIFT],
            "A continuous-nozzle path cannot permit nozzle lifts.");
        assert(!policy[PP_ALLOW_CLOSED_SUBPATHS],
            "Closed independent subpaths violate the one-path policy.");
    }
}

module validate_pattern_set(pattern_set, material) {
    zones = pattern_set[PS_ZONES];
    assert(len(zones) >= 1, "A pattern set requires at least one zone.");

    for (zone = zones) {
        clear_gap = zone_clear_gap(zone, material);
        assert(zone[Z_STRAND_PITCH] > material[M_LINE_W],
            str("Zone '", zone[Z_NAME], "' has no open gap."));
        assert(clear_gap >= material[M_MIN_CLEAR_GAP],
            str("Zone '", zone[Z_NAME], "' is below the minimum clear gap."));
        assert(clear_gap <= material[M_MAX_CLEAR_GAP],
            str("Zone '", zone[Z_NAME], "' exceeds the configured maximum clear gap."));
        assert(zone[Z_BAND_VALUE] >= 0,
            str("Zone '", zone[Z_NAME], "' has a negative band value."));
    }
}

module validate_schedule(schedule, pattern_sets) {
    groups = schedule[LS_GROUPS];
    assert(len(groups) >= 1, "A layer schedule requires at least one group.");

    for (group = groups) {
        assert(group[LG_COUNT] >= 1 && is_integer_value(group[LG_COUNT]),
            "Every layer-group count must be a positive integer.");
        assert(group[LG_Z_STEP_MULTIPLIER] >= 1,
            "Z-step multiplier cannot be less than one layer height.");
        referenced_pattern = named_record(
            pattern_sets,
            group[LG_PATTERN_SET],
            "pattern set"
        );
        assert(referenced_pattern[PS_NAME] == group[LG_PATTERN_SET],
            "Layer group pattern-set lookup failed.");
    }

    if (schedule[LS_REQUIRE_SYMMETRY])
        assert(groups == reversed(groups),
            "This schedule is declared symmetric but its groups are not a palindrome.");
}

module validate_grid_stack(
    project,
    material,
    boundary,
    path_policy,
    pattern_set,
    schedule
) {
    validate_material(material);
    validate_boundary(boundary);
    validate_path_policy(path_policy);
    validate_pattern_set(pattern_set, material);
    validate_schedule(schedule, PATTERN_SETS);

    for (group = schedule[LS_GROUPS])
        assert(group[LG_PATTERN_SET] == project[PR_PATTERN_SET],
            "Batch 001 permits one pattern set per project. Later batches may vary it by layer group.");

    echo("GRID STACK VALIDATION: PASS");
}
