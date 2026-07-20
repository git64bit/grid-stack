//////////////////////////////////////////////////////////////////////
// LibFile: first_layer_reporting.scad
// Project: Grid Stack
// FileGroup: Reporting
// FileSummary: Reports a saved first-layer object's exact trace sequence,
//              repeat distances, clear gaps, path length, and print envelope.
// Role: Makes variable-length and variable-repeat patterns auditable before
//       slicing or printing.
// Requires: First-layer indexes, process/path math, and parallel path helpers.
// Exports: report_first_layer_object().
//////////////////////////////////////////////////////////////////////

module report_first_layer_object(object, level = "summary") {
    material = object[FLO_MATERIAL];
    nozzle = object[FLO_NOZZLE];
    process = object[FLO_PROCESS];
    traces = object[FLO_TRACES];
    orientation = object[FLO_ORIENTATION];
    lead_in = object[FLO_LEAD_IN];
    points = parallel_trace_path(traces, orientation, lead_in);
    bounds = path_bounds_2d(points);
    trace_w = nozzle[NZ_DIAMETER];
    trace_h = process[PX_LAYER_H];
    repeats = trace_repeat_distances(traces);
    clear_gaps = trace_clear_gaps(traces, trace_w);

    echo("================ GRID STACK FIRST LAYER =================");
    echo(str("Object: ", object[FLO_NAME]));
    echo(str("Revision: ", object[FLO_REVISION]));
    echo(str("Required API: ", object[FLO_REQUIRED_API]));
    echo(str("First-layer schema: ", object[FLO_SCHEMA_VERSION]));
    echo(str("Source release: ", object[FLO_SOURCE_RELEASE]));
    echo(str("Status: ", object[FLO_STATUS]));
    echo(str("Material: ", material[MAT_FAMILY]));
    echo(str("Nozzle trace: ", trace_w, " x ", trace_h, " mm"));
    echo("Purpose: one trace and one deposited layer; not a structural strand.");
    echo(str("Parallel orientation: ", orientation, " degrees"));
    echo(str("Trace count: ", len(traces)));
    echo(str("Square connectors: ", max(0, len(traces) - 1)));
    echo(str("Lead-in: ", lead_in, " mm"));
    echo(str("Trace lengths: ", parallel_trace_lengths(traces), " mm"));
    echo(str("Repeat distances: ", repeats, " mm center-to-center"));
    echo(str("Clear gaps: ", clear_gaps, " mm edge-to-edge"));
    echo(str("Path points: ", len(points)));
    echo(str("Centerline path length: ", path_length(points), " mm"));
    echo(str("Centerline bounds: X ", bounds[0], " to ", bounds[1],
             ", Y ", bounds[2], " to ", bounds[3], " mm"));
    echo(str("Printed envelope including trace width: ",
             bounds[1] - bounds[0] + trace_w, " x ",
             bounds[3] - bounds[2] + trace_w, " mm"));

    if (level == "full")
        for (i = [0 : len(traces) - 1])
            echo(str("Trace ", i, ": ", traces[i],
                     "; length=", trace_axis_length(traces[i]), " mm"));
}
