//////////////////////////////////////////////////////////////////////
// LibFile: path_preview.scad
// Project: Grid Stack
// FileGroup: Diagnostic Geometry
// FileSummary: Displays an ordered centerline, point order, start/end markers,
//              and the non-printing coupon envelope.
// Role: Supports path inspection only. It is not structural-strand geometry.
// Requires: An ordered list of XY points.
// Exports: diagnostic_path_preview().
//////////////////////////////////////////////////////////////////////

module _preview_segment_2d(a, b, width) {
    hull() {
        translate(a) circle(d = width, $fn = 16);
        translate(b) circle(d = width, $fn = 16);
    }
}

module _preview_polyline_2d(points, width) {
    for (i = [0 : len(points) - 2])
        _preview_segment_2d(points[i], points[i + 1], width);
}

module _preview_point_label(point, index, label_size) {
    translate([point[0] + label_size * 0.35, point[1] + label_size * 0.15])
        text(str(index), size = label_size, halign = "left", valign = "bottom");
}

// Module: diagnostic_path_preview()
// Synopsis: Renders a deliberately thin, non-printable path diagnostic.
// Description:
//   Point 0 is the lead-in start. The last point is the only path end.
//   The translucent rectangle is an envelope reference, not a perimeter path.
module diagnostic_path_preview(
    points,
    boundary_size,
    show_envelope = true,
    show_point_numbers = true,
    line_width = 0.18,
    marker_diameter = 1.2,
    label_size = 1.5
) {
    if (show_envelope)
        %color([0.75, 0.75, 0.75, 0.25])
            linear_extrude(height = 0.02)
                square(boundary_size);

    color("orange")
        linear_extrude(height = 0.08)
            _preview_polyline_2d(points, line_width);

    color("green")
        translate([points[0][0], points[0][1], 0])
            cylinder(h = 0.12, d = marker_diameter, $fn = 24);

    color("red")
        translate([points[len(points) - 1][0], points[len(points) - 1][1], 0])
            cylinder(h = 0.12, d = marker_diameter, $fn = 24);

    if (show_point_numbers)
        color("black")
            linear_extrude(height = 0.1)
                for (i = [0 : len(points) - 1])
                    _preview_point_label(points[i], i, label_size);
}
