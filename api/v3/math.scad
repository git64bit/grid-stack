//////////////////////////////////////////////////////////////////////
// LibFile: math.scad
// Project: Grid Stack
// FileGroup: API v3 Mathematics
// FileSummary: Pure trace, strand, boundary, path, and layer-count helpers.
// Role: Keeps API v3 calculations isolated and reproducible without importing
//       mutable workbench mathematics.
// Requires: API v3 indexes.
// Exports: nearly_equal3(), trace/strand dimensions, boundary dimensions,
//          path inspection, gap-layer count, and total-height helpers.
//////////////////////////////////////////////////////////////////////

function nearly_equal3(a, b, epsilon = 0.000001) = abs(a - b) <= epsilon;

function trace_width3(nozzle) = nozzle[NZ3_DIAMETER];
function trace_height3(process) = process[PX3_LAYER_H];
function strand_width3(process, nozzle) =
    trace_width3(nozzle) * process[PX3_WIDTH_PASSES];
function strand_height3(process) =
    trace_height3(process) * process[PX3_HEIGHT_PASSES];

function boundary_strand_count_x3(boundary) = boundary[B3_CELLS_X] + 1;
function boundary_strand_count_y3(boundary) = boundary[B3_CELLS_Y] + 1;
function boundary_pitch_x3(boundary, process, nozzle) =
    boundary[B3_CLEAR_SPAN_X] + strand_width3(process, nozzle);
function boundary_pitch_y3(boundary, process, nozzle) =
    boundary[B3_CLEAR_SPAN_Y] + strand_width3(process, nozzle);
function boundary_size_x3(boundary, process, nozzle) =
    boundary[B3_CELLS_X] * boundary[B3_CLEAR_SPAN_X] +
    boundary_strand_count_x3(boundary) * strand_width3(process, nozzle);
function boundary_size_y3(boundary, process, nozzle) =
    boundary[B3_CELLS_Y] * boundary[B3_CLEAR_SPAN_Y] +
    boundary_strand_count_y3(boundary) * strand_width3(process, nozzle);

function point_distance_2d3(a, b) =
    sqrt(pow(b[0] - a[0], 2) + pow(b[1] - a[1], 2));
function path_length3(points, i = 0) =
    i >= len(points) - 1
        ? 0
        : point_distance_2d3(points[i], points[i + 1]) +
          path_length3(points, i + 1);
function path_has_zero_segment3(points, i = 0) =
    i >= len(points) - 1
        ? false
        : nearly_equal3(point_distance_2d3(points[i], points[i + 1]), 0)
            ? true
            : path_has_zero_segment3(points, i + 1);
function segment_axis_aligned3(a, b) =
    nearly_equal3(a[0], b[0]) || nearly_equal3(a[1], b[1]);
function path_axis_aligned3(points, i = 0) =
    i >= len(points) - 1
        ? true
        : segment_axis_aligned3(points[i], points[i + 1]) &&
          path_axis_aligned3(points, i + 1);

function gap_layer_count3(object) =
    object[SCO_CLEAR_GAP] / trace_height3(object[SCO_PROCESS]);
function coupon_total_height3(object) =
    2 * strand_height3(object[SCO_PROCESS]) + object[SCO_CLEAR_GAP];
