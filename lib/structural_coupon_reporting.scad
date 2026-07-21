//////////////////////////////////////////////////////////////////////
// LibFile: structural_coupon_reporting.scad
// Project: Grid Stack
// FileGroup: Reporting
// FileSummary: Console report for direct-contact and positive-gap rectangular
//              structural coupons.
// Role: Makes dimensions, path composition, support strategy, deposited-layer
//       counts, and exploratory bridge status inspectable before slicing.
// Requires: Boundary, process, path, and framework mathematics plus indexes.
// Exports: report_rectangular_stack_coupon(),
//          report_positive_gap_stack_coupon(), and compatibility wrapper.
//////////////////////////////////////////////////////////////////////

function _span_qualification_status(clear_span, process) =
    clear_span <= process[PX_BRIDGE_MAX]
        ? "within_owner_tested_limit"
        : "exploratory_beyond_owner_tested_limit";

module _report_coupon_common(boundary, process, nozzle) {
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
    echo(str("Structural strand section: ",
        strand_width(process, nozzle), " x ", strand_height(process), " mm"));
}

// Module: report_rectangular_stack_coupon()
// Synopsis: Reports the accepted direct-contact orthogonal coupon.
module report_rectangular_stack_coupon(
    lower_points,
    upper_points,
    boundary,
    process,
    nozzle,
    clear_vertical_gap = 0
) {
    composed_height = strand_height(process);

    echo("--- Grid Stack direct-contact structural coupon ---");
    _report_coupon_common(boundary, process, nozzle);
    echo("Support strategy: direct_orthogonal");
    echo(str("Lower path length: ", path_length(lower_points), " mm"));
    echo(str("Upper path length: ", path_length(upper_points), " mm"));
    echo(str("Clear vertical gap: ", clear_vertical_gap, " mm"));
    echo(str("Total modeled stack height: ", 2 * composed_height, " mm"));
    echo(str("Intended deposited slicer layers: ",
        2 * process[PX_HEIGHT_PASSES]));
    echo("Each deposited layer has one ordered open centerline.");
    echo("Slicer path order must be verified before qualification.");
}

// Module: report_positive_gap_stack_coupon()
// Synopsis: Reports witness/riser/bridge positive-gap geometry.
module report_positive_gap_stack_coupon(
    witness_points,
    riser_points,
    test_points,
    boundary,
    process,
    nozzle,
    clear_vertical_gap
) {
    gap_layers = round(clear_vertical_gap / trace_height(process));
    composed_height = strand_height(process);

    echo("--- Grid Stack positive-gap structural coupon ---");
    _report_coupon_common(boundary, process, nozzle);
    echo("Support strategy: witness_riser_bridge");
    echo(str("Witness Y path length: ", path_length(witness_points), " mm"));
    echo(str("Riser X path length per gap layer: ",
        path_length(riser_points), " mm"));
    echo(str("Upper test Y path length: ", path_length(test_points), " mm"));
    echo(str("Clear vertical gap: ", clear_vertical_gap, " mm"));
    echo(str("Riser deposited layers: ", gap_layers));
    echo(str("Total modeled stack height: ",
        2 * composed_height + clear_vertical_gap, " mm"));
    echo(str("Total intended deposited layers: ",
        2 * process[PX_HEIGHT_PASSES] + gap_layers));
    echo("Witness and upper test paths are vertically aligned.");
    echo("Every riser layer repeats one continuous orthogonal open path.");
    echo("Slicer path order must be verified before qualification.");
}

module report_direct_contact_stack_coupon(
    lower_points, upper_points, boundary, process, nozzle
) {
    report_rectangular_stack_coupon(
        lower_points, upper_points, boundary, process, nozzle, 0
    );
}
