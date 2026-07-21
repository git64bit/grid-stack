//////////////////////////////////////////////////////////////////////
// LibFile: structural_coupon_reporting.scad
// Project: Grid Stack
// FileGroup: Reporting
// FileSummary: Console report for rectangular orthogonal structural coupons,
//              including exploratory bridge status and positive-gap stubs.
// Role: Makes dimensions, path counts, composition, and implementation status
//       inspectable before slicing or saving a permanent recipe.
// Requires: Boundary, process, path, and framework mathematics plus indexes.
// Exports: report_rectangular_stack_coupon() and direct-contact wrapper.
//////////////////////////////////////////////////////////////////////

// Function: _span_qualification_status()
// Synopsis: Classifies a span without rejecting exploratory coupons.
function _span_qualification_status(clear_span, process) =
    clear_span <= process[PX_BRIDGE_MAX]
        ? "within_owner_tested_limit"
        : "exploratory_beyond_owner_tested_limit";

// Module: report_rectangular_stack_coupon()
// Synopsis: Reports one complete lower-X/upper-Y coupon specification.
module report_rectangular_stack_coupon(
    lower_points,
    upper_points,
    boundary,
    process,
    nozzle,
    clear_vertical_gap = 0
) {
    composed_width = strand_width(process, nozzle);
    composed_height = strand_height(process);

    echo("--- Grid Stack rectangular structural coupon ---");
    echo(str("Boundary cells: ", boundary[B_CELLS_X], " x ",
        boundary[B_CELLS_Y]));
    echo(str("Clear spans: ", boundary[B_CLEAR_SPAN_X], " x ",
        boundary[B_CLEAR_SPAN_Y], " mm"));
    echo(str("X span status: ",
        _span_qualification_status(boundary[B_CLEAR_SPAN_X], process)));
    echo(str("Y span status: ",
        _span_qualification_status(boundary[B_CLEAR_SPAN_Y], process)));
    echo(str("Outside dimensions: ",
        boundary_size_x(boundary, process, nozzle), " x ",
        boundary_size_y(boundary, process, nozzle), " mm"));
    echo(str("Primitive trace: ", trace_width(nozzle), " x ",
        trace_height(process), " mm"));
    echo(str("Composition: ", process[PX_WIDTH_PASSES],
        " traces wide x ", process[PX_HEIGHT_PASSES], " layers high"));
    echo(str("Structural strand section: ", composed_width, " x ",
        composed_height, " mm"));
    echo(str("Complete structural path layers: 2"));
    echo(str("Lower path length: ", path_length(lower_points), " mm"));
    echo(str("Upper path length: ", path_length(upper_points), " mm"));
    echo(str("Clear vertical gap: ", clear_vertical_gap, " mm"));
    echo(str("Total modeled stack height: ",
        2 * composed_height + clear_vertical_gap, " mm"));
    echo(str("Intended deposited slicer layers: ",
        2 * process[PX_HEIGHT_PASSES]));
    echo(str("Printable geometry status: ",
        nearly_equal(clear_vertical_gap, 0)
            ? "implemented_direct_contact"
            : "stub_requires_anchor_support"));
    echo("Each deposited layer has one ordered open centerline.");
    echo("Slicer path order must be verified before qualification.");
}

// Module: report_direct_contact_stack_coupon()
// Synopsis: Compatibility wrapper for the accepted Batch 008 report.
module report_direct_contact_stack_coupon(
    lower_points, upper_points, boundary, process, nozzle
) {
    report_rectangular_stack_coupon(
        lower_points, upper_points, boundary, process, nozzle, 0
    );
}
