//////////////////////////////////////////////////////////////////////
// LibFile: first_layer_validation.scad
// Project: Grid Stack
// FileGroup: Validation
// FileSummary: Validates saved first-layer objects and their configurable
//              parallel-trace records before printable geometry is produced.
// Role: Enforces parallel traces, variable but monotonic repeat positions,
//       endpoint-aligned square turns, one continuous path, and API identity.
// Requires: API constants, engineering validation, path math, and indexes.
// Exports: validate_parallel_traces() and validate_first_layer_object().
//////////////////////////////////////////////////////////////////////

module validate_parallel_traces(traces, orientation, trace_width, lead_in = 0) {
    assert(len(traces) >= 1,
        "At least one parallel trace must be configured.");
    assert(orientation == 0 || orientation == 90,
        "Trace orientation must be 0 or 90 degrees.");
    assert(trace_width > 0,
        "Trace width must be positive.");
    assert(lead_in >= 0,
        "Lead-in must be zero or positive.");

    for (i = [0 : len(traces) - 1]) {
        trace = traces[i];
        assert(len(trace) == 3,
            str("Trace ", i,
                " must be [axis_min, axis_max, perpendicular_position]."));
        assert(is_num(trace[PTR_AXIS_MIN]) &&
               is_num(trace[PTR_AXIS_MAX]) &&
               is_num(trace[PTR_OFFSET]),
            str("Trace ", i, " fields must be numeric."));
        assert(trace[PTR_AXIS_MAX] > trace[PTR_AXIS_MIN],
            str("Trace ", i,
                " axis_max must be greater than axis_min."));
    }

    if (len(traces) >= 2) {
        offset_direction = traces[1][PTR_OFFSET] > traces[0][PTR_OFFSET]
            ? 1 : -1;

        for (i = [0 : len(traces) - 2]) {
            repeat_distance = abs(
                traces[i + 1][PTR_OFFSET] - traces[i][PTR_OFFSET]
            );
            next_direction = traces[i + 1][PTR_OFFSET] -
                             traces[i][PTR_OFFSET];

            assert(next_direction * offset_direction > 0,
                "Parallel-trace offsets must remain strictly monotonic.");
            assert(repeat_distance >= trace_width,
                str("Trace repeat distance ", repeat_distance,
                    " is smaller than trace width ", trace_width, "."));
            assert(nearly_equal(
                    trace_path_end_axis(traces[i], i),
                    trace_path_start_axis(traces[i + 1], i + 1)
                ),
                str("Traces ", i, " and ", i + 1,
                    " do not share the endpoint required for a square turn."));
        }
    }

    points = parallel_trace_path(traces, orientation, lead_in);
    assert(len(points) >= 2,
        "Generated first-layer path requires at least two points.");
    assert(!path_has_zero_length_segment(points),
        "Generated first-layer path contains a zero-length segment.");
    assert(path_is_axis_aligned(points),
        "Generated first-layer path must remain axis-aligned.");
    assert(path_start(points) != path_end(points),
        "Generated first-layer path must remain open.");

    echo("GRID STACK PARALLEL TRACE VALIDATION: PASS");
}

module validate_first_layer_object(object) {
    assert(len(object) == 13,
        "First-layer object record has an unexpected field count.");
    assert(object[FLO_NAME] != "",
        "First-layer object name must not be empty.");
    assert(object[FLO_REVISION] >= 1 &&
           floor(object[FLO_REVISION]) == object[FLO_REVISION],
        "First-layer object revision must be a positive integer.");
    assert(object[FLO_REQUIRED_API] == GRID_STACK_API_VERSION,
        str("First-layer object requires Grid Stack API ",
            object[FLO_REQUIRED_API], " but loaded API is ",
            GRID_STACK_API_VERSION, "."));
    assert(object[FLO_SCHEMA_VERSION] == GRID_STACK_FIRST_LAYER_SCHEMA_VERSION,
        str("First-layer schema ", object[FLO_SCHEMA_VERSION],
            " is incompatible with loaded schema ",
            GRID_STACK_FIRST_LAYER_SCHEMA_VERSION, "."));
    assert(object[FLO_SOURCE_RELEASE] != "",
        "First-layer object must record its source release.");
    assert(object[FLO_STATUS] == "draft" ||
           object[FLO_STATUS] == "calibration" ||
           object[FLO_STATUS] == "printed" ||
           object[FLO_STATUS] == "retired",
        "First-layer status must be draft, calibration, printed, or retired.");

    material = object[FLO_MATERIAL];
    nozzle = object[FLO_NOZZLE];
    process = object[FLO_PROCESS];

    validate_material(material);
    validate_nozzle(nozzle);
    validate_process(process, material, nozzle);
    validate_parallel_traces(
        object[FLO_TRACES],
        object[FLO_ORIENTATION],
        nozzle[NZ_DIAMETER],
        object[FLO_LEAD_IN]
    );

    echo("GRID STACK FIRST-LAYER OBJECT VALIDATION: PASS");
}
