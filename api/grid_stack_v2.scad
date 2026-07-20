//////////////////////////////////////////////////////////////////////
// LibFile: grid_stack_v2.scad
// Project: Grid Stack
// FileGroup: Versioned Public Interface
// FileSummary: Immutable API version 2 for primitive first-layer print
//              recipes with material, nozzle, printer, and trace-process data.
// Role: Lets saved first-layer objects avoid the structural-strand process
//       fields required by API version 1 while preserving the v1 interface.
// Exports: API/schema constants, record constructors,
//          validate_first_layer_object(), report_first_layer_object(), and
//          first_layer_render().
//////////////////////////////////////////////////////////////////////

GRID_STACK_API_VERSION = 2;
GRID_STACK_FIRST_LAYER_SCHEMA_VERSION = 2;
GRID_STACK_RELEASE = "0.7.0";

include <v2/indices.scad>
include <v2/schema.scad>

include <../lib/list_math.scad>
include <../lib/path_math.scad>
include <../paths/parallel_traces.scad>
include <../geometry/path_preview.scad>
include <../geometry/trace_layer.scad>

include <v2/validation.scad>
include <v2/reporting.scad>

// Module: first_layer_render()
// Synopsis: Validates, reports, and renders one API v2 first-layer recipe.
// Arguments:
//   object = Record returned by first_layer_object().
//   mode = trace_layer, path_debug, or report_only.
//   report_level = summary or full.
//   show_path_point_numbers = Diagnostic-only point labels.
module first_layer_render(
    object,
    mode = "trace_layer",
    report_level = "full",
    show_path_point_numbers = true
) {
    validate_first_layer_object(object);
    report_first_layer_object(object, report_level);

    nozzle = object[FLO_NOZZLE];
    process = object[FLO_PROCESS];
    points = parallel_trace_path(
        object[FLO_TRACES],
        object[FLO_ORIENTATION],
        object[FLO_LEAD_IN]
    );

    if (mode == "trace_layer")
        printable_trace_layer(
            points = points,
            trace_width = nozzle[NZ_DIAMETER],
            trace_height = process[TP_LAYER_H]
        );
    else if (mode == "path_debug")
        diagnostic_path_preview(
            points = points,
            boundary_size = [0, 0],
            show_envelope = false,
            show_point_numbers = show_path_point_numbers
        );
    else if (mode == "report_only")
        echo("Grid Stack API v2 report-only mode: no geometry generated.");
    else
        assert(false, str("Unknown API v2 first-layer mode: ", mode));
}
