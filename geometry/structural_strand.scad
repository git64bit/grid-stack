//////////////////////////////////////////////////////////////////////
// LibFile: structural_strand.scad
// Project: Grid Stack
// FileGroup: Printable Geometry
// FileSummary: Sweeps the qualified composed structural-strand section along
//              one ordered axis-aligned path.
// Role: Converts the rational process definition into printable geometry:
//       nozzle diameter times width passes, and deposited layer height times
//       height passes.
// Requires: process_math.scad and square_trace_path_2d() from trace_layer.scad.
// Exports: printable_structural_strand_path().
//////////////////////////////////////////////////////////////////////

// Module: printable_structural_strand_path()
// Synopsis: Extrudes one composed structural-strand ribbon along a path.
// Description:
//   For the current PLA+ 0.4 mm process, this creates a 0.8 mm wide by
//   0.4 mm high ribbon. Square terminations and square turns are preserved.
//   The slicer must still be inspected to verify the intended two traces per
//   deposited layer and one uninterrupted path per deposited layer.
module printable_structural_strand_path(points, process, nozzle) {
    composed_width = strand_width(process, nozzle);
    composed_height = strand_height(process);

    assert(process[PX_WIDTH_PASSES] >= 2,
        "A structural strand requires at least two width passes.");
    assert(process[PX_HEIGHT_PASSES] >= 2,
        "A structural strand requires at least two height passes.");
    assert(composed_width > 0 && composed_height > 0,
        "Structural-strand dimensions must be positive.");

    linear_extrude(height = composed_height, convexity = 10)
        square_trace_path_2d(points, composed_width);
}
