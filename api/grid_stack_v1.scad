//////////////////////////////////////////////////////////////////////
// LibFile: grid_stack_v1.scad
// Project: Grid Stack
// FileGroup: Versioned Public Interface
// FileSummary: Public constructors, validation, reporting, and diagnostic
//              rendering contract for Grid Stack API version 1.
// Role: Gives saved-object recipes a stable import target. Incompatible public
//       changes require a new API file rather than modifying this contract.
// Exports: API/schema constants, saved-object constructors,
//          grid_stack_render(), and first_layer_render().
//////////////////////////////////////////////////////////////////////

GRID_STACK_API_VERSION = 1;
GRID_STACK_OBJECT_SCHEMA_VERSION = 1;
GRID_STACK_FIRST_LAYER_SCHEMA_VERSION = 1;
GRID_STACK_RELEASE = "0.6.0";

include <../lib/indices.scad>
include <../lib/schema.scad>
include <../lib/lookup.scad>
include <../lib/process_math.scad>
include <../lib/list_math.scad>
include <../lib/boundary_math.scad>
include <../lib/pattern_math.scad>
include <../lib/stack_math.scad>
include <../lib/path_math.scad>

include <../paths/rectangular_serpentine.scad>
include <../paths/parallel_traces.scad>
include <../geometry/path_preview.scad>
include <../geometry/trace_layer.scad>

include <../lib/validation.scad>
include <../lib/path_validation.scad>
include <../lib/reporting.scad>
include <../lib/path_reporting.scad>
include <../lib/object_validation.scad>
include <../lib/object_reporting.scad>
include <../lib/first_layer_validation.scad>
include <../lib/first_layer_reporting.scad>

// Module: grid_stack_render()
// Synopsis: Validates and reports one self-contained saved object, then
//           delegates to a supported output mode.
// Arguments:
//   object = Record returned by grid_stack_object().
//   mode = report_only or path_preview in API version 1.
//   report_level = summary or full.
//   show_boundary_envelope = Diagnostic preview option.
//   show_path_point_numbers = Diagnostic preview option.
// Description:
//   This is the single public execution module used by saved-object recipes.
//   API version 1 does not yet create printable structural-strand solids.
module grid_stack_render(
    object,
    mode = "report_only",
    report_level = "full",
    show_boundary_envelope = true,
    show_path_point_numbers = true
) {
    validate_grid_stack_object(object);
    report_grid_stack_object(object, report_level);

    process = object[GSO_PROCESS];
    nozzle = object[GSO_NOZZLE];
    boundary = object[GSO_BOUNDARY];
    policy = object[GSO_PATH_POLICY];
    orientation = object[GSO_PATH_ORIENTATION];

    if (mode == "path_preview") {
        assert(boundary_is_count_driven(boundary),
            "API v1 path preview requires a count-driven boundary.");
        assert(object[GSO_PATTERN_SET][PS_NAME] == "SQUARE_COUPON",
            "API v1 path preview supports the square coupon pattern only.");

        generated_path = rectangular_serpentine_path(
            boundary, process, nozzle, policy, orientation
        );

        validate_rectangular_serpentine_path(
            generated_path, boundary, process, nozzle, policy, orientation
        );

        report_generated_path(
            generated_path, boundary, process, nozzle, orientation
        );

        diagnostic_path_preview(
            points = generated_path,
            boundary_size = [
                boundary_size_x(boundary, process, nozzle),
                boundary_size_y(boundary, process, nozzle)
            ],
            show_envelope = show_boundary_envelope,
            show_point_numbers = show_path_point_numbers
        );
    }
    else if (mode == "report_only") {
        echo("Grid Stack saved object report-only mode: no geometry generated.");
    }
    else {
        assert(false, str("Unknown Grid Stack API v1 mode: ", mode));
    }
}

// Module: first_layer_render()
// Synopsis: Validates, reports, and renders one saved first-layer trace object.
// Arguments:
//   object = Record returned by first_layer_object().
//   mode = trace_layer, path_debug, or report_only.
//   report_level = summary or full.
//   show_path_point_numbers = Diagnostic-only point labels.
// Description:
//   trace_layer creates printable geometry exactly one nozzle trace wide and
//   one deposited layer high. path_debug renders non-printable annotations.
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
            trace_height = process[PX_LAYER_H]
        );
    else if (mode == "path_debug")
        diagnostic_path_preview(
            points = points,
            boundary_size = [0, 0],
            show_envelope = false,
            show_point_numbers = show_path_point_numbers
        );
    else if (mode == "report_only")
        echo("Grid Stack first-layer report-only mode: no geometry generated.");
    else
        assert(false, str("Unknown first-layer render mode: ", mode));
}
