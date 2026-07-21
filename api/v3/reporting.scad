//////////////////////////////////////////////////////////////////////
// LibFile: reporting.scad
// Project: Grid Stack
// FileGroup: API v3 Reporting
// FileSummary: Console report for immutable direct and positive-gap coupons.
// Role: Records the exact environment, dimensions, support strategy, path
//       lengths, qualification status, and deposited-layer counts.
// Requires: API v3 indexes, mathematics, and path generator.
// Exports: report_structural_coupon_object().
//////////////////////////////////////////////////////////////////////

function _bridge_status3(span, process) =
    span <= process[PX3_BRIDGE_MAX]
        ? "within_owner_tested_limit"
        : "exploratory_beyond_owner_tested_limit";

module report_structural_coupon_object(object, report_level = "full") {
    material = object[SCO_MATERIAL];
    nozzle = object[SCO_NOZZLE];
    printer = object[SCO_PRINTER];
    process = object[SCO_PROCESS];
    boundary = object[SCO_BOUNDARY];
    gap = object[SCO_CLEAR_GAP];
    strategy = object[SCO_SUPPORT_STRATEGY];

    echo("--- Grid Stack immutable structural coupon ---");
    echo(str("Object: ", object[SCO_NAME], " revision ", object[SCO_REVISION]));
    echo(str("API/schema: ", object[SCO_REQUIRED_API], "/",
        object[SCO_SCHEMA_VERSION]));
    echo(str("Release/base commit: ", object[SCO_SOURCE_RELEASE], " / ",
        object[SCO_FRAMEWORK_BASE_COMMIT]));
    echo(str("Material/nozzle/printer: ", material[MAT3_FAMILY], " / ",
        nozzle[NZ3_DIAMETER], " mm / ", printer[PRN3_NAME]));
    echo(str("Cells: ", boundary[B3_CELLS_X], " x ", boundary[B3_CELLS_Y]));
    echo(str("Clear spans: ", boundary[B3_CLEAR_SPAN_X], " x ",
        boundary[B3_CLEAR_SPAN_Y], " mm"));
    echo(str("Span status: ",
        _bridge_status3(boundary[B3_CLEAR_SPAN_X], process)));
    echo(str("Outside size: ", boundary_size_x3(boundary, process, nozzle),
        " x ", boundary_size_y3(boundary, process, nozzle), " mm"));
    echo(str("Primitive trace: ", trace_width3(nozzle), " x ",
        trace_height3(process), " mm"));
    echo(str("Structural strand: ", strand_width3(process, nozzle), " x ",
        strand_height3(process), " mm"));
    echo(str("Clear vertical gap: ", gap, " mm"));
    echo(str("Support strategy: ", strategy));
    echo(str("Total modeled height: ", coupon_total_height3(object), " mm"));

    if (report_level == "full") {
        if (strategy == "direct_orthogonal") {
            lower = coupon_path(
                boundary, process, nozzle, 0, object[SCO_LEAD_IN]
            );
            upper = coupon_path(boundary, process, nozzle, 90, 0);
            echo(str("Lower/upper path lengths: ", path_length3(lower),
                " / ", path_length3(upper), " mm"));
            echo(str("Deposited layers: ", 2 * process[PX3_HEIGHT_PASSES]));
        }
        else {
            witness = coupon_path(
                boundary, process, nozzle, 90, object[SCO_LEAD_IN]
            );
            riser = coupon_path(boundary, process, nozzle, 0, 0);
            test = coupon_path(boundary, process, nozzle, 90, 0);
            echo(str("Witness/riser/test path lengths: ",
                path_length3(witness), " / ", path_length3(riser), " / ",
                path_length3(test), " mm"));
            echo(str("Riser deposited layers: ", round(gap_layer_count3(object))));
            echo(str("Total deposited layers: ",
                2 * process[PX3_HEIGHT_PASSES] +
                round(gap_layer_count3(object))));
        }
        echo(str("Status: ", object[SCO_STATUS]));
        echo(str("Notes: ", object[SCO_NOTES]));
    }
}
