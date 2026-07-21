//////////////////////////////////////////////////////////////////////
// LibFile: geometry.scad
// Project: Grid Stack
// FileGroup: API v3 Printable Geometry
// FileSummary: Creates square-ended structural paths, direct-contact coupons,
//              positive witness/riser/bridge coupons, and simple diagnostics.
// Role: Supplies all geometry used by immutable API v3 recipes without
//       importing mutable workbench geometry.
// Requires: API v3 mathematics and ordered axis-aligned paths.
// Exports: render_direct_coupon(), render_positive_gap_coupon(), and
//          render_coupon_path_debug().
//////////////////////////////////////////////////////////////////////

module _segment_2d3(a, b, width) {
    horizontal = nearly_equal3(a[1], b[1]);
    vertical = nearly_equal3(a[0], b[0]);

    assert(horizontal || vertical,
        "API v3 printable segments must be horizontal or vertical.");
    assert(!nearly_equal3(point_distance_2d3(a, b), 0),
        "API v3 printable segments must have nonzero length.");

    if (horizontal)
        translate([min(a[0], b[0]) - width / 2, a[1] - width / 2])
            square([abs(b[0] - a[0]) + width, width]);
    else
        translate([a[0] - width / 2, min(a[1], b[1]) - width / 2])
            square([width, abs(b[1] - a[1]) + width]);
}

module _path_2d3(points, width) {
    union()
        for (i = [0 : len(points) - 2])
            _segment_2d3(points[i], points[i + 1], width);
}

module _structural_path3(points, process, nozzle) {
    linear_extrude(height = strand_height3(process), convexity = 10)
        _path_2d3(points, strand_width3(process, nozzle));
}

module render_direct_coupon(lower, upper, process, nozzle) {
    union() {
        _structural_path3(lower, process, nozzle);
        translate([0, 0, strand_height3(process)])
            _structural_path3(upper, process, nozzle);
    }
}

module render_positive_gap_coupon(
    witness, riser, test, process, nozzle, clear_gap
) {
    union() {
        _structural_path3(witness, process, nozzle);

        translate([0, 0, strand_height3(process)])
            linear_extrude(height = clear_gap, convexity = 10)
                _path_2d3(riser, strand_width3(process, nozzle));

        translate([0, 0, strand_height3(process) + clear_gap])
            _structural_path3(test, process, nozzle);
    }
}

module _debug_path3(points, z, width) {
    translate([0, 0, z])
        linear_extrude(height = 0.04)
            _path_2d3(points, width);
}

module render_coupon_path_debug(
    lower, upper, riser, process, clear_gap = 0
) {
    width = max(0.12, trace_height3(process));
    _debug_path3(lower, 0, width);
    if (len(riser) > 0)
        _debug_path3(riser, strand_height3(process), width);
    _debug_path3(
        upper,
        strand_height3(process) + clear_gap,
        width
    );
}
