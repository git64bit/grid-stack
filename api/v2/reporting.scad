//////////////////////////////////////////////////////////////////////
// LibFile: reporting.scad
// Project: Grid Stack
// FileGroup: API v2 Reporting
// FileSummary: Console report for immutable primitive-trace print recipes.
// Role: Makes the exact material, nozzle, printer status, layer height,
//       trace lengths, repeat distances, and source identity visible.
// Requires: API v2 indexes and parallel-trace/path helpers.
// Exports: report_first_layer_object().
//////////////////////////////////////////////////////////////////////

module report_first_layer_object(object, report_level = "full") {
    material = object[FLO_MATERIAL];
    nozzle = object[FLO_NOZZLE];
    printer = object[FLO_PRINTER];
    process = object[FLO_PROCESS];
    traces = object[FLO_TRACES];
    orientation = object[FLO_ORIENTATION];
    lead_in = object[FLO_LEAD_IN];
    points = parallel_trace_path(traces, orientation, lead_in);

    assert(report_level == "summary" || report_level == "full",
        "Report level must be summary or full.");

    echo("------------------------------------------------------------");
    echo("GRID STACK API V2 SAVED FIRST-LAYER OBJECT");
    echo(str("Object: ", object[FLO_NAME]));
    echo(str("Revision: ", object[FLO_REVISION]));
    echo(str("Source release: ", object[FLO_SOURCE_RELEASE]));
    echo(str("Source commit: ", object[FLO_SOURCE_COMMIT]));
    echo(str("Status: ", object[FLO_STATUS]));
    echo(str("Material: ", material[MAT_FAMILY]));
    echo(str("Nozzle: ", nozzle[NZ_DIAMETER], " mm"));
    echo(str("Layer height: ", process[TP_LAYER_H], " mm"));
    echo(str("Printer record: ", printer[PRN_NAME],
        " (", printer[PRN_STATUS], ")"));
    echo(str("Trace orientation: ", orientation, " degrees"));
    echo(str("Trace count: ", len(traces)));
    echo(str("Trace lengths: ", parallel_trace_lengths(traces)));
    echo(str("Repeat distances: ", trace_repeat_distances(traces)));
    echo(str("Clear gaps: ",
        trace_clear_gaps(traces, nozzle[NZ_DIAMETER])));
    echo(str("Lead-in: ", lead_in, " mm"));
    echo(str("Continuous path length: ", path_length(points), " mm"));

    if (report_level == "full") {
        echo(str("Material record: ", material));
        echo(str("Nozzle record: ", nozzle));
        echo(str("Printer record: ", printer));
        echo(str("Trace-process record: ", process));
        echo(str("Trace records: ", traces));
        echo(str("Ordered path: ", points));
        echo(str("Notes: ", object[FLO_NOTES]));
    }

    echo("------------------------------------------------------------");
}
