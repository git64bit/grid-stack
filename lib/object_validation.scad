//////////////////////////////////////////////////////////////////////
// LibFile: object_validation.scad
// Project: Grid Stack
// FileGroup: Saved Objects
// FileSummary: Validates a self-contained grid_stack_object() record without
//              consulting mutable project catalogs or Customizer selections.
// Role: Prevents an old recipe from silently running against an incompatible
//       API or object schema and validates every embedded engineering record.
// Requires: Public API constants, validation.scad, and field indexes.
// Exports: validate_grid_stack_object().
//////////////////////////////////////////////////////////////////////

module _validate_embedded_schedule(schedule, pattern_set) {
    groups = schedule[SS_GROUPS];
    assert(len(groups) >= 1, "A saved-object schedule requires at least one group.");

    for (group = groups) {
        assert(group[SG_STRAND_COUNT] >= 1 &&
               is_integer_value(group[SG_STRAND_COUNT]),
            "Every saved-object strand count must be a positive integer.");
        assert(group[SG_CLEAR_GAP_AFTER] >= 0,
            "Saved-object clear vertical gaps cannot be negative.");
        assert(group[SG_PATTERN_SET] == pattern_set[PS_NAME],
            "Every saved-object strand group must use its embedded pattern set.");
    }

    assert(groups[len(groups) - 1][SG_CLEAR_GAP_AFTER] == 0,
        "The final saved-object strand group cannot leave an unbounded gap.");

    if (schedule[SS_REQUIRE_SYMMETRY])
        assert(groups == reversed(groups),
            "The saved-object schedule declares symmetry but is not a palindrome.");
}

// Module: validate_grid_stack_object()
// Synopsis: Validates identity, API compatibility, and all embedded records.
module validate_grid_stack_object(object) {
    assert(object[GSO_NAME] != "", "Saved-object name cannot be empty.");
    assert(is_integer_value(object[GSO_REVISION]) && object[GSO_REVISION] >= 1,
        "Saved-object revision must be a positive integer.");
    assert(object[GSO_REQUIRED_API] == GRID_STACK_API_VERSION,
        str("Saved object requires Grid Stack API ",
            object[GSO_REQUIRED_API], " but loaded API is ",
            GRID_STACK_API_VERSION, "."));
    assert(object[GSO_SCHEMA_VERSION] == GRID_STACK_OBJECT_SCHEMA_VERSION,
        str("Saved object schema ", object[GSO_SCHEMA_VERSION],
            " is incompatible with loaded schema ",
            GRID_STACK_OBJECT_SCHEMA_VERSION, "."));
    assert(object[GSO_SOURCE_RELEASE] != "",
        "Saved object must record its Grid Stack release.");
    assert(object[GSO_STATUS] == "draft" ||
           object[GSO_STATUS] == "calibration" ||
           object[GSO_STATUS] == "printed" ||
           object[GSO_STATUS] == "retired",
        "Saved-object status must be draft, calibration, printed, or retired.");
    assert(object[GSO_PATH_ORIENTATION] == 0 ||
           object[GSO_PATH_ORIENTATION] == 90,
        "Saved-object path orientation must be 0 or 90 degrees.");

    material = object[GSO_MATERIAL];
    nozzle = object[GSO_NOZZLE];
    process = object[GSO_PROCESS];
    boundary = object[GSO_BOUNDARY];
    policy = object[GSO_PATH_POLICY];
    pattern_set = object[GSO_PATTERN_SET];
    schedule = object[GSO_SCHEDULE];

    validate_material(material);
    validate_nozzle(nozzle);
    validate_process(process, material, nozzle);
    validate_boundary(boundary, process, nozzle);
    validate_path_policy(policy);
    validate_pattern_set(pattern_set, boundary, process, nozzle);
    _validate_embedded_schedule(schedule, pattern_set);

    echo("GRID STACK SAVED OBJECT VALIDATION: PASS");
}
