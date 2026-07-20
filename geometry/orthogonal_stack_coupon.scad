//////////////////////////////////////////////////////////////////////
// LibFile: orthogonal_stack_coupon.scad
// Project: Grid Stack
// FileGroup: Printable Geometry
// FileSummary: Places one X-running structural path directly beneath one
//              Y-running structural path to form a two-orientation coupon.
// Role: Provides the first printable Grid Stack structural-stack geometry
//       without introducing unsupported vertical-gap behavior.
// Requires: printable_structural_strand_path() and process_math.scad.
// Exports: printable_direct_contact_stack_coupon().
//////////////////////////////////////////////////////////////////////

// Module: printable_direct_contact_stack_coupon()
// Synopsis: Renders two orthogonal composed paths in direct Z contact.
// Arguments:
//   lower_points = Ordered path for the lower structural layer.
//   upper_points = Ordered path for the upper structural layer.
//   process = Qualified structural-strand process record.
//   nozzle = Nozzle hardware record.
// Description:
//   The upper path begins at the shared lower-left crossing. Its first trace
//   is therefore supported. Positive clear vertical gaps are deliberately not
//   accepted until a separate support/anchor strategy is designed and tested.
module printable_direct_contact_stack_coupon(
    lower_points, upper_points, process, nozzle
) {
    composed_height = strand_height(process);

    union() {
        printable_structural_strand_path(
            points = lower_points,
            process = process,
            nozzle = nozzle
        );

        translate([0, 0, composed_height])
            printable_structural_strand_path(
                points = upper_points,
                process = process,
                nozzle = nozzle
            );
    }
}
