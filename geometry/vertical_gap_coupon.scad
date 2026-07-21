//////////////////////////////////////////////////////////////////////
// LibFile: vertical_gap_coupon.scad
// Project: Grid Stack
// FileGroup: Printable Geometry
// FileSummary: Builds a positive-clearance bridge coupon from one lower
//              witness grid, continuous orthogonal riser walls, and one upper
//              test grid aligned above the witness grid.
// Role: Implements the frozen rectangular count-boundary gap coupon without
//       travel moves, nozzle lifts, perimeter borders, or floating geometry.
// Requires: printable_structural_strand_path(), square_trace_path_2d(),
//           process_math.scad, and list_math.scad.
// Exports: printable_vertical_gap_stack_coupon().
//////////////////////////////////////////////////////////////////////

// Module: printable_vertical_gap_stack_coupon()
// Synopsis: Renders one printable positive-gap structural coupon.
// Arguments:
//   witness_points = Lower Y-running path with the external lead-in.
//   riser_points = X-running path without a lead-in, repeated through the gap.
//   test_points = Upper Y-running path aligned directly above the witness.
//   process = Qualified structural-strand process record.
//   nozzle = Nozzle hardware record.
//   clear_vertical_gap = Empty Z distance between witness and test strands.
// Description:
//   The witness grid occupies the first composed structural-strand height.
//   The orthogonal riser path is extruded through the requested clear gap.
//   Every deposited riser layer is therefore the same continuous open path.
//   The upper test grid rests on the riser-wall tops and bridges each clear
//   opening. It is aligned above the witness grid so measurable sag can reach
//   the known lower strand when the requested clearance is exceeded.
module printable_vertical_gap_stack_coupon(
    witness_points,
    riser_points,
    test_points,
    process,
    nozzle,
    clear_vertical_gap
) {
    composed_height = strand_height(process);
    composed_width = strand_width(process, nozzle);
    deposited_height = trace_height(process);
    gap_layers = clear_vertical_gap / deposited_height;

    assert(clear_vertical_gap > 0,
        "Vertical-gap coupon geometry requires a positive clear gap.");
    assert(nearly_equal(gap_layers, round(gap_layers)),
        str(
            "Clear vertical gap must be an integer deposited-layer count: ",
            clear_vertical_gap, " / ", deposited_height, "."
        ));

    union() {
        printable_structural_strand_path(
            points = witness_points,
            process = process,
            nozzle = nozzle
        );

        translate([0, 0, composed_height])
            linear_extrude(height = clear_vertical_gap, convexity = 10)
                square_trace_path_2d(riser_points, composed_width);

        translate([0, 0, composed_height + clear_vertical_gap])
            printable_structural_strand_path(
                points = test_points,
                process = process,
                nozzle = nozzle
            );
    }
}
