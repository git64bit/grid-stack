//////////////////////////////////////////////////////////////////////
// LibFile: validation.scad
// Project: Grid Stack
// FileGroup: Validation
// FileSummary: Rejects incomplete or contradictory environments, boundaries,
//              path policies, patterns, path-layer schedules, and coupon series.
// Role: Stops invalid specifications before path or solid generation begins.
// Requires: Active records, catalogs, lookup, and math helpers.
// Exports: validate_grid_stack() and validate_coupon_series().
//////////////////////////////////////////////////////////////////////

module validate_material(material) {
    assert(material[MAT_NAME] != "", "Material name cannot be empty.");
    assert(material[MAT_STATUS] == "in_use" || material[MAT_STATUS] == "reserved",
        "Material status must be 'in_use' or 'reserved'.");
}

module validate_nozzle(nozzle) {
    assert(nozzle[NZ_DIAMETER] > 0, "Nozzle diameter must be positive.");
}

module validate_process(process, material, nozzle, allow_laboratory = false) {
    assert(process[PX_MATERIAL] == material[MAT_NAME],
        "Process material lookup does not match the process record.");
    assert(process[PX_NOZZLE] == nozzle[NZ_NAME],
        "Process nozzle lookup does not match the process record.");
    assert(process[PX_LAYER_H] > 0, "Layer height must be positive.");
    assert(allow_laboratory ||
           process[PX_LAYER_H] <= nozzle[NZ_DIAMETER],
        allow_laboratory
            ? "Laboratory layer height must be positive."
            : "Layer height must not exceed nozzle diameter in this project.");
    assert(is_integer_value(process[PX_WIDTH_PASSES]) &&
           process[PX_WIDTH_PASSES] >= 2,
        "A structural strand requires at least two horizontal passes.");
    assert(is_integer_value(process[PX_HEIGHT_PASSES]) &&
           process[PX_HEIGHT_PASSES] >= 2,
        "A structural strand requires at least two deposited layers.");
    assert(process[PX_BRIDGE_MAX] > 0,
        "Maximum unsupported span must be positive.");
    assert(
        process[PX_QUALIFICATION] == "owner_tested" ||
        (allow_laboratory &&
         process[PX_QUALIFICATION] == "laboratory_unqualified"),
        allow_laboratory
            ? "Laboratory process qualification must be owner_tested or laboratory_unqualified."
            : "The active Grid Stack process must be owner-tested."
    );
    assert(is_integer_value(process[PX_REVISION]) && process[PX_REVISION] >= 1,
        "Process revision must be a positive integer.");
}

module validate_boundary(boundary, process, nozzle) {
    assert(boundary[B_MODE] == "dimension" || boundary[B_MODE] == "count",
        "Boundary mode must be dimension or count.");
    assert(boundary[B_EDGE_MARGIN] >= 0,
        "Boundary edge margin cannot be negative.");

    if (boundary_is_dimension_driven(boundary)) {
        assert(boundary[B_SIZE_X] > 0 && boundary[B_SIZE_Y] > 0,
            "Dimension-driven boundary sizes must be positive.");
        assert(boundary[B_CELLS_X] == 0 && boundary[B_CELLS_Y] == 0,
            "Dimension-driven boundaries must not contain grid counts.");
    }

    if (boundary_is_count_driven(boundary)) {
        assert(boundary[B_KIND] == "rectangle",
            "Current count-driven boundaries are rectangular.");
        assert(is_integer_value(boundary[B_CELLS_X]) &&
               is_integer_value(boundary[B_CELLS_Y]) &&
               boundary[B_CELLS_X] >= 1 && boundary[B_CELLS_Y] >= 1,
            "Count-driven boundaries require positive integer cell counts.");
        assert(boundary[B_CLEAR_SPAN_X] > 0 &&
               boundary[B_CLEAR_SPAN_Y] > 0,
            "Count-driven clear spans must be positive.");
        assert(boundary_size_x(boundary, process, nozzle) > 0 &&
               boundary_size_y(boundary, process, nozzle) > 0,
            "Derived count-driven boundary sizes must be positive.");
    }

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

module validate_pattern_set(pattern_set, boundary, process, nozzle) {
    zones = pattern_set[PS_ZONES];
    assert(len(zones) >= 1, "A pattern set requires at least one zone.");

    for (zone = zones) {
        assert(
            zone[Z_SPACING_SOURCE] == "fixed_pitch" ||
            zone[Z_SPACING_SOURCE] == "boundary_clear_span",
            str("Unknown spacing source in zone '", zone[Z_NAME], "'.")
        );

        if (zone[Z_SPACING_SOURCE] == "boundary_clear_span")
            assert(boundary_is_count_driven(boundary),
                "Boundary-clear-span patterns require a count boundary.");

        assert(zone_clear_span(zone, boundary, process, nozzle, "x") > 0,
            str("Zone '", zone[Z_NAME], "' has no X clear span."));
        assert(zone_clear_span(zone, boundary, process, nozzle, "y") > 0,
            str("Zone '", zone[Z_NAME], "' has no Y clear span."));
        assert(zone[Z_BAND_VALUE] >= 0,
            str("Zone '", zone[Z_NAME], "' has a negative band value."));
    }
}

module validate_stack_schedule(schedule, pattern_sets) {
    groups = schedule[SS_GROUPS];
    assert(len(groups) >= 1, "A stack schedule requires at least one group.");

    for (group = groups) {
        assert(group[PLG_LAYER_COUNT] >= 1 &&
               is_integer_value(group[PLG_LAYER_COUNT]),
            "Every path-layer group count must be a positive integer.");
        assert(group[PLG_CLEAR_GAP_AFTER] >= 0,
            "Clear vertical gap cannot be negative.");
        referenced_pattern = named_record(
            pattern_sets, group[PLG_PATTERN_SET], "pattern set"
        );
        assert(referenced_pattern[PS_NAME] == group[PLG_PATTERN_SET],
            "Path-layer-group pattern-set lookup failed.");
    }

    assert(groups[len(groups) - 1][PLG_CLEAR_GAP_AFTER] == 0,
        "The final strand group cannot leave an unbounded gap after itself.");

    if (schedule[SS_REQUIRE_SYMMETRY])
        assert(groups == reversed(groups),
            "This schedule is declared symmetric but is not a palindrome.");
}

module validate_grid_stack(
    project, process, material, nozzle, boundary,
    path_policy, pattern_set, schedule
) {
    validate_material(material);
    validate_nozzle(nozzle);
    validate_process(process, material, nozzle);
    validate_boundary(boundary, process, nozzle);
    validate_path_policy(path_policy);
    validate_pattern_set(pattern_set, boundary, process, nozzle);
    validate_stack_schedule(schedule, PATTERN_SETS);

    for (group = schedule[SS_GROUPS])
        assert(group[PLG_PATTERN_SET] == project[PR_PATTERN_SET],
            "Current projects permit one pattern set per project.");

    echo("GRID STACK VALIDATION: PASS");
}

module validate_coupon_series(series) {
    process = named_record(PROCESS_PROFILES, series[CS_PROCESS], "process profile");
    material = named_record(MATERIALS, process[PX_MATERIAL], "material");
    nozzle = named_record(NOZZLES, process[PX_NOZZLE], "nozzle");
    policy = named_record(PATH_POLICIES, series[CS_PATH_POLICY], "path policy");
    pattern = named_record(PATTERN_SETS, series[CS_PATTERN_SET], "pattern set");

    validate_process(process, material, nozzle);
    validate_path_policy(policy);
    assert(len(series[CS_BOUNDARIES]) >= 1,
        "A coupon series requires at least one boundary.");
    assert(len(series[CS_SCHEDULES]) >= 1,
        "A coupon series requires at least one schedule.");

    for (boundary_name = series[CS_BOUNDARIES]) {
        boundary = named_record(BOUNDARIES, boundary_name, "boundary");
        validate_boundary(boundary, process, nozzle);
        assert(boundary_is_count_driven(boundary),
            "Coupon series boundaries must be count-driven.");
        validate_pattern_set(pattern, boundary, process, nozzle);
    }

    for (schedule_name = series[CS_SCHEDULES]) {
        schedule = named_record(STACK_SCHEDULES, schedule_name, "stack schedule");
        validate_stack_schedule(schedule, PATTERN_SETS);
        for (group = schedule[SS_GROUPS])
            assert(group[PLG_PATTERN_SET] == series[CS_PATTERN_SET],
                "Coupon schedule pattern does not match the coupon series.");
    }

    echo("GRID STACK COUPON SERIES VALIDATION: PASS");
}
