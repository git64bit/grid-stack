//////////////////////////////////////////////////////////////////////
// LibFile: grid_stack_v3.scad
// Project: Grid Stack
// FileGroup: Versioned Public Interface
// FileSummary: Immutable API version 3 for rectangular count-boundary
//              structural coupons, including positive witness/riser gaps.
// Role: Reconstructs saved coupon recipes without Customizer state or mutable
//       workbench catalogs. Incompatible behavior requires a new API file.
// Exports: API/schema constants, record constructors, validation, reporting,
//          and structural_coupon_render().
//////////////////////////////////////////////////////////////////////

GRID_STACK_API_VERSION = 3;
GRID_STACK_COUPON_SCHEMA_VERSION = 1;
GRID_STACK_RECTANGULAR_FRAMEWORK_VERSION = 2;
GRID_STACK_RELEASE = "1.0.0";

include <v3/indices.scad>
include <v3/schema.scad>
include <v3/math.scad>
include <v3/paths.scad>
include <v3/geometry.scad>
include <v3/validation.scad>
include <v3/reporting.scad>

// Module: structural_coupon_render()
// Synopsis: Validates, reports, and renders one immutable coupon recipe.
// Arguments:
//   object = Record returned by structural_coupon_object().
//   mode = print, path_debug, or report_only.
//   report_level = summary or full.
module structural_coupon_render(
    object,
    mode = "print",
    report_level = "full"
) {
    validate_structural_coupon_object(object);
    report_structural_coupon_object(object, report_level);

    boundary = object[SCO_BOUNDARY];
    process = object[SCO_PROCESS];
    nozzle = object[SCO_NOZZLE];
    lead_in = object[SCO_LEAD_IN];
    clear_gap = object[SCO_CLEAR_GAP];
    strategy = object[SCO_SUPPORT_STRATEGY];

    if (strategy == "direct_orthogonal") {
        lower = coupon_path(boundary, process, nozzle, 0, lead_in);
        upper = coupon_path(boundary, process, nozzle, 90, 0);

        if (mode == "print")
            render_direct_coupon(lower, upper, process, nozzle);
        else if (mode == "path_debug")
            render_coupon_path_debug(lower, upper, [], process);
        else if (mode == "report_only")
            echo("Grid Stack API v3 report-only mode: no geometry generated.");
        else
            assert(false, str("Unknown API v3 render mode: ", mode));
    }
    else if (strategy == "witness_riser_bridge") {
        witness = coupon_path(boundary, process, nozzle, 90, lead_in);
        riser = coupon_path(boundary, process, nozzle, 0, 0);
        test = coupon_path(boundary, process, nozzle, 90, 0);

        if (mode == "print")
            render_positive_gap_coupon(
                witness, riser, test, process, nozzle, clear_gap
            );
        else if (mode == "path_debug")
            render_coupon_path_debug(witness, test, riser, process, clear_gap);
        else if (mode == "report_only")
            echo("Grid Stack API v3 report-only mode: no geometry generated.");
        else
            assert(false, str("Unknown API v3 render mode: ", mode));
    }
    else
        assert(false, str("Unknown coupon support strategy: ", strategy));
}
