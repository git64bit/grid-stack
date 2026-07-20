//////////////////////////////////////////////////////////////////////
// LibFile: trace_layer.scad
// Project: Grid Stack
// FileGroup: Printable Geometry
// FileSummary: Sweeps one rectangular nozzle trace along an axis-aligned path
//              using square segment ends and square perpendicular turns.
// Role: Creates the first printable Grid Stack primitive: one trace wide and
//       one deposited layer high. It is not a structural strand.
// Requires: An ordered, validated, axis-aligned XY point list.
// Exports: square_trace_path_2d() and printable_trace_layer().
//////////////////////////////////////////////////////////////////////

// Module: _square_trace_segment_2d()
// Synopsis: Creates one centered axis-aligned segment with square end caps.
module _square_trace_segment_2d(a, b, width) {
    horizontal = nearly_equal(a[1], b[1]);
    vertical = nearly_equal(a[0], b[0]);

    assert(horizontal || vertical,
        "Printable trace segments must be horizontal or vertical.");
    assert(!nearly_equal(point_distance_2d(a, b), 0),
        "Printable trace segments must have nonzero length.");

    if (horizontal)
        translate([min(a[0], b[0]) - width / 2, a[1] - width / 2])
            square([abs(b[0] - a[0]) + width, width]);
    else
        translate([a[0] - width / 2, min(a[1], b[1]) - width / 2])
            square([width, abs(b[1] - a[1]) + width]);
}

// Module: square_trace_path_2d()
// Synopsis: Unions square-ended segments into one continuous 2D trace.
module square_trace_path_2d(points, width) {
    assert(len(points) >= 2,
        "A printable trace path requires at least two points.");
    assert(width > 0,
        "Printable trace width must be positive.");

    union()
        for (i = [0 : len(points) - 2])
            _square_trace_segment_2d(points[i], points[i + 1], width);
}

// Module: printable_trace_layer()
// Synopsis: Extrudes one trace-width path to one deposited-layer height.
// Description:
//   The start, termination, and every perpendicular turn remain square.
//   This primitive intentionally represents one nozzle trace and one layer.
module printable_trace_layer(points, trace_width, trace_height) {
    assert(trace_height > 0,
        "Printable trace height must be positive.");

    linear_extrude(height = trace_height, convexity = 10)
        square_trace_path_2d(points, trace_width);
}
