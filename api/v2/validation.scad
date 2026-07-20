//////////////////////////////////////////////////////////////////////
// LibFile: validation.scad
// Project: Grid Stack
// FileGroup: API v2 Validation
// FileSummary: Validates immutable primitive-trace print recipes.
// Role: Rejects incomplete environments, nonparallel traces, diagonal turns,
//       incompatible API/schema versions, and misleading print records.
// Requires: API v2 indexes, path math, and parallel-trace helpers.
// Exports: validate_first_layer_object().
//////////////////////////////////////////////////////////////////////

function _v2_is_integer(value) = is_num(value) && floor(value) == value;

module _validate_material(material) {
    assert(len(material) == 5,
        "API v2 material record has an unexpected field count.");
    assert(material[MAT_NAME] != "", "Material name cannot be empty.");
    assert(material[MAT_STATUS] == "in_use" ||
           material[MAT_STATUS] == "retired",
        "Material status must be in_use or retired.");
}

module _validate_nozzle(nozzle) {
    assert(len(nozzle) == 5,
        "API v2 nozzle record has an unexpected field count.");
    assert(nozzle[NZ_NAME] != "", "Nozzle name cannot be empty.");
    assert(nozzle[NZ_DIAMETER] > 0,
        "Nozzle diameter must be positive.");
    assert(nozzle[NZ_STATUS] == "in_use" ||
           nozzle[NZ_STATUS] == "retired",
        "Nozzle status must be in_use or retired.");
}

module _validate_printer(printer) {
    assert(len(printer) == 7,
        "API v2 printer record has an unexpected field count.");
    assert(printer[PRN_NAME] != "", "Printer name cannot be empty.");
    assert(printer[PRN_STATUS] == "recorded" ||
           printer[PRN_STATUS] == "unrecorded" ||
           printer[PRN_STATUS] == "retired",
        "Printer status must be recorded, unrecorded, or retired.");

    if (printer[PRN_STATUS] == "recorded") {
        assert(printer[PRN_MANUFACTURER] != "",
            "A recorded printer requires a manufacturer.");
        assert(printer[PRN_MODEL] != "",
            "A recorded printer requires a model.");
    }
}

module _validate_trace_process(process, material, nozzle, printer) {
    assert(len(process) == 8,
        "API v2 trace-process record has an unexpected field count.");
    assert(process[TP_NAME] != "",
        "Trace-process name cannot be empty.");
    assert(process[TP_MATERIAL] == material[MAT_NAME],
        "Trace process material does not match the embedded material.");
    assert(process[TP_NOZZLE] == nozzle[NZ_NAME],
        "Trace process nozzle does not match the embedded nozzle.");
    assert(process[TP_PRINTER] == printer[PRN_NAME],
        "Trace process printer does not match the embedded printer.");
    assert(process[TP_LAYER_H] > 0,
        "Deposited layer height must be positive.");
    assert(process[TP_LAYER_H] <= nozzle[NZ_DIAMETER],
        "Deposited layer height must not exceed nozzle diameter.");
    assert(process[TP_QUALIFICATION] == "owner_tested" ||
           process[TP_QUALIFICATION] == "unqualified",
        "Trace-process qualification must be owner_tested or unqualified.");
    assert(_v2_is_integer(process[TP_REVISION]) &&
           process[TP_REVISION] >= 1,
        "Trace-process revision must be a positive integer.");
}

module _validate_parallel_traces(traces, orientation, trace_width, lead_in) {
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
        "Generated path requires at least two points.");
    assert(!path_has_zero_length_segment(points),
        "Generated path contains a zero-length segment.");
    assert(path_is_axis_aligned(points),
        "Generated path must remain axis-aligned.");
    assert(path_start(points) != path_end(points),
        "Generated path must remain open.");
}

// Module: validate_first_layer_object()
// Synopsis: Validates one API v2 immutable first-layer recipe.
module validate_first_layer_object(object) {
    assert(len(object) == 15,
        "API v2 first-layer object has an unexpected field count.");
    assert(object[FLO_NAME] != "",
        "First-layer object name must not be empty.");
    assert(_v2_is_integer(object[FLO_REVISION]) &&
           object[FLO_REVISION] >= 1,
        "First-layer object revision must be a positive integer.");
    assert(object[FLO_REQUIRED_API] == GRID_STACK_API_VERSION,
        str("Recipe requires Grid Stack API ",
            object[FLO_REQUIRED_API], " but loaded API is ",
            GRID_STACK_API_VERSION, "."));
    assert(object[FLO_SCHEMA_VERSION] ==
           GRID_STACK_FIRST_LAYER_SCHEMA_VERSION,
        str("Recipe schema ", object[FLO_SCHEMA_VERSION],
            " is incompatible with loaded schema ",
            GRID_STACK_FIRST_LAYER_SCHEMA_VERSION, "."));
    assert(object[FLO_SOURCE_RELEASE] != "",
        "Recipe must record its source release.");
    assert(object[FLO_SOURCE_COMMIT] != "",
        "Recipe must record its accepted source commit.");
    assert(object[FLO_STATUS] == "calibration" ||
           object[FLO_STATUS] == "printed" ||
           object[FLO_STATUS] == "retired",
        "Recipe status must be calibration, printed, or retired.");

    material = object[FLO_MATERIAL];
    nozzle = object[FLO_NOZZLE];
    printer = object[FLO_PRINTER];
    process = object[FLO_PROCESS];

    _validate_material(material);
    _validate_nozzle(nozzle);
    _validate_printer(printer);
    _validate_trace_process(process, material, nozzle, printer);
    _validate_parallel_traces(
        object[FLO_TRACES],
        object[FLO_ORIENTATION],
        nozzle[NZ_DIAMETER],
        object[FLO_LEAD_IN]
    );

    if (object[FLO_STATUS] == "printed")
        assert(process[TP_QUALIFICATION] == "owner_tested",
            "A printed recipe must use an owner-tested trace process.");

    echo("GRID STACK API V2 FIRST-LAYER VALIDATION: PASS");
}
