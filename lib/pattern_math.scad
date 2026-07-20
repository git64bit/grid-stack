//////////////////////////////////////////////////////////////////////
// LibFile: pattern_math.scad
// Project: Grid Stack
// FileGroup: Pattern Mathematics
// FileSummary: Resolves pattern spacing from either a fixed pitch or a
//              count-driven boundary clear span.
// Role: Prevents pattern topology from duplicating coupon dimensions.
// Requires: Field indexes, process_math.scad, and boundary_math.scad.
// Exports: zone_clear_span() and zone_strand_pitch().
//////////////////////////////////////////////////////////////////////

function zone_clear_span(zone, boundary, process, nozzle, axis = "x") =
    zone[Z_SPACING_SOURCE] == "boundary_clear_span"
        ? (axis == "x"
            ? boundary[B_CLEAR_SPAN_X]
            : boundary[B_CLEAR_SPAN_Y])
        : zone[Z_STRAND_PITCH] - strand_width(process, nozzle);

function zone_strand_pitch(zone, boundary, process, nozzle, axis = "x") =
    zone_clear_span(zone, boundary, process, nozzle, axis) +
    strand_width(process, nozzle);
