//////////////////////////////////////////////////////////////////////
// LibFile: validation.scad
// Project: Grid Stack
// FileGroup: Validation
// FileSummary: Rejects incomplete or contradictory environments and policies.
// Role: Stops invalid specifications before path or solid generation begins.
// Requires: All active records and utility functions loaded by main.scad.
// Exports: validate_grid_stack() and subordinate validators.
//////////////////////////////////////////////////////////////////////

module validate_material(material) {
    assert(material[MAT_NAME] != "", "Material name cannot be empty.");
    assert(material[MAT_STATUS] == "in_use" || material[MAT_STATUS] == "reserved",
        "Material status must be 'in_use' or 'reserved'.");
}

module validate_nozzle(nozzle) {
    assert(nozzle[NZ_DIAMETER] > 0, "Nozzle diameter must be positive.");
}

module validate_process(process, material, nozzle) {
    assert(process[PX_MATERIAL] == material[MAT_NAME],
        "Process material lookup does not match the process record.");
    assert(process[PX_NOZZLE] == nozzle[NZ_NAME],
        "Process nozzle lookup does not match the process record.");
    assert(process[PX_LAYER_H] > 0, "Layer height must be positive.");
    assert(process[PX_LAYER_H] <= nozzle[NZ_DIAMETER],
        "Layer height must not exceed nozzle diameter in this project.");
    assert(is_integer_value(process[PX_WIDTH_PASSES]) &&
           process[PX_WIDTH_PASSES] >= 2,
        "A structural strand requires at least two horizontal passes.");
    assert(is_integer_value(process[PX_HEIGHT_PASSES]) &&
           process[PX_HEIGHT_PASSES] >= 2,
        "A structural strand requires at least two deposited layers.");
    assert(process[PX_BRIDGE_MAX] > 0,
        "Maximum unsupported span must be positive.");
    assert(process[PX_QUALIFICATION] == "owner_tested",
        "The active Grid Stack process must be owner-tested.");
    assert(is_integer_value(process[PX_REVISION]) && process[PX_REVISION] >= 1,
        "Process revision must be a positive integer.");
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

module validate_pattern_set(pattern_set, process, nozzle) {
    zones = pattern_set[PS_ZONES];
    assert(len(zones) >= 1, "A pattern set requires at least one zone.");

    for (zone = zones) {
        clear_gap = zone_clear_gap(zone, process, nozzle);
        assert(zone[Z_STRAND_PITCH] > strand_width(process, nozzle),
            str("Zone '", zone[Z_NAME], "' has no open gap."));
        assert(clear_gap >= 0,
            str("Zone '", zone[Z_NAME], "' has a negative clear gap."));
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
            pattern_sets, group[LG_PATTERN_SET], "pattern set"
        );
        assert(referenced_pattern[PS_NAME] == group[LG_PATTERN_SET],
            "Layer group pattern-set lookup failed.");
    }

    if (schedule[LS_REQUIRE_SYMMETRY])
        assert(groups == reversed(groups),
            "This schedule is declared symmetric but its groups are not a palindrome.");
}

module validate_grid_stack(
    project, process, material, nozzle, boundary,
    path_policy, pattern_set, schedule
) {
    validate_material(material);
    validate_nozzle(nozzle);
    validate_process(process, material, nozzle);
    validate_boundary(boundary);
    validate_path_policy(path_policy);
    validate_pattern_set(pattern_set, process, nozzle);
    validate_schedule(schedule, PATTERN_SETS);

    for (group = schedule[LS_GROUPS])
        assert(group[LG_PATTERN_SET] == project[PR_PATTERN_SET],
            "Batch 002 permits one pattern set per project.");

    echo("GRID STACK VALIDATION: PASS");
}
