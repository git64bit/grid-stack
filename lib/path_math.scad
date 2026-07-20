//////////////////////////////////////////////////////////////////////
// LibFile: path_math.scad
// Project: Grid Stack
// FileGroup: Path Mathematics
// FileSummary: Pure helpers for ordered two-dimensional nozzle paths.
// Role: Measures and inspects point lists without creating geometry or
//       selecting project records.
// Requires: None.
// Exports: Point, segment, path-length, and continuity helpers.
//////////////////////////////////////////////////////////////////////

// Function: point_distance_2d()
// Synopsis: Returns the Euclidean distance between two XY points.
function point_distance_2d(a, b) =
    sqrt(pow(b[0] - a[0], 2) + pow(b[1] - a[1], 2));

// Function: nearly_equal()
// Synopsis: Compares calculated dimensions with a small numeric tolerance.
function nearly_equal(a, b, tolerance = 0.000001) =
    abs(a - b) <= tolerance;

// Function: segment_is_axis_aligned()
// Synopsis: True when a segment is horizontal or vertical.
function segment_is_axis_aligned(a, b) =
    nearly_equal(a[0], b[0]) || nearly_equal(a[1], b[1]);

// Function: path_segment_lengths()
// Synopsis: Returns one length for every consecutive point pair.
function path_segment_lengths(points) =
    len(points) < 2
        ? []
        : [for (i = [0 : len(points) - 2])
            point_distance_2d(points[i], points[i + 1])];

// Function: path_length()
// Synopsis: Returns the total centerline length of an ordered path.
function path_length(points, i = 0) =
    i >= len(points) - 1
        ? 0
        : point_distance_2d(points[i], points[i + 1]) +
          path_length(points, i + 1);

// Function: path_has_zero_length_segment()
// Synopsis: Detects repeated consecutive points.
function path_has_zero_length_segment(points, i = 0) =
    i >= len(points) - 1
        ? false
        : nearly_equal(point_distance_2d(points[i], points[i + 1]), 0)
            ? true
            : path_has_zero_length_segment(points, i + 1);

// Function: path_is_axis_aligned()
// Synopsis: Verifies that every segment is horizontal or vertical.
function path_is_axis_aligned(points, i = 0) =
    i >= len(points) - 1
        ? true
        : segment_is_axis_aligned(points[i], points[i + 1]) &&
          path_is_axis_aligned(points, i + 1);

function path_start(points) = points[0];
function path_end(points) = points[len(points) - 1];
