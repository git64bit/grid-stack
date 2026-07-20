//////////////////////////////////////////////////////////////////////
// LibFile: structural_coupon_reporting.scad
// Project: Grid Stack
// FileGroup: Reporting
// FileSummary: Console report for the first printable direct-contact
//              orthogonal structural coupon.
// Role: Makes derived dimensions, path counts, bridge spans, and stack height
//       inspectable before slicing or printing.
// Requires: Boundary, process, and path mathematics plus field indexes.
// Exports: report_direct_contact_stack_coupon().
//////////////////////////////////////////////////////////////////////

// Module: report_direct_contact_stack_coupon()
// Synopsis: Reports the rational composition and physical coupon dimensions.
module report_direct_contact_stack_coupon(
    lower_points, upper_points, boundary, process, nozzle
) {
    composed_width = strand_width(process, nozzle);
    composed_height = strand_height(process);

    echo("--- Grid Stack structural coupon ---");
    echo(str("Boundary cells: ", boundary[B_CELLS_X], " x ",
        boundary[B_CELLS_Y]));
    echo(str("Clear spans: ", boundary[B_CLEAR_SPAN_X], " x ",
        boundary[B_CLEAR_SPAN_Y], " mm"));
    echo(str("Outside dimensions: ",
        boundary_size_x(boundary, process, nozzle), " x ",
        boundary_size_y(boundary, process, nozzle), " mm"));
    echo(str("Primitive trace: ", trace_width(nozzle), " x ",
        trace_height(process), " mm"));
    echo(str("Composition: ", process[PX_WIDTH_PASSES],
        " traces wide x ", process[PX_HEIGHT_PASSES], " layers high"));
    echo(str("Structural strand: ", composed_width, " x ",
        composed_height, " mm"));
    echo(str("Lower path length: ", path_length(lower_points), " mm"));
    echo(str("Upper path length: ", path_length(upper_points), " mm"));
    echo("Layer relationship: direct contact; clear vertical gap = 0 mm");
    echo(str("Total modeled stack height: ", 2 * composed_height, " mm"));
    echo(str("Intended deposited layers: ",
        2 * process[PX_HEIGHT_PASSES]));
    echo("Each deposited layer has one ordered open centerline.");
    echo("Slicer path order must be verified before qualification.");
}
