//////////////////////////////////////////////////////////////////////
// LibFile: parallel_traces.scad
// Project: Grid Stack
// FileGroup: Path Generation
// FileSummary: Converts configurable parallel-trace records into one ordered,
//              continuous path with square perpendicular connectors.
// Role: Treats every trace length and repeat distance as independent data.
//       No equal spacing, equal length, symmetry, or square-wave repetition is
//       implied by this generator.
// Requires: Path mathematics and parallel-trace field indexes.
// Exports: parallel_trace_path(), trace_axis_length(), trace_repeat_distances(),
//          trace_clear_gaps(), and trace-path endpoint helpers.
//////////////////////////////////////////////////////////////////////

// Function: trace_axis_length()
// Synopsis: Returns the independently configured length of one parallel trace.
function trace_axis_length(trace) = trace[PTR_AXIS_MAX] - trace[PTR_AXIS_MIN];

// Function: trace_path_start_axis()
// Synopsis: Returns the traversal start coordinate for a trace by parity.
// Description:
//   Even traces run from axis_min to axis_max. Odd traces run from axis_max
//   to axis_min. This alternation preserves one continuous serpentine path.
function trace_path_start_axis(trace, index) =
    index % 2 == 0 ? trace[PTR_AXIS_MIN] : trace[PTR_AXIS_MAX];

// Function: trace_path_end_axis()
// Synopsis: Returns the traversal end coordinate for a trace by parity.
function trace_path_end_axis(trace, index) =
    index % 2 == 0 ? trace[PTR_AXIS_MAX] : trace[PTR_AXIS_MIN];

// Function: _parallel_trace_point()
// Synopsis: Maps one axis coordinate and one perpendicular offset into XY.
function _parallel_trace_point(axis_value, offset, orientation) =
    orientation == 0 ? [axis_value, offset] : [offset, axis_value];

// Function: _parallel_trace_points()
// Synopsis: Recursively expands trace records into entry and exit points.
function _parallel_trace_points(traces, orientation, index = 0) =
    index >= len(traces)
        ? []
        : let(
            trace = traces[index],
            offset = trace[PTR_OFFSET],
            start_point = _parallel_trace_point(
                trace_path_start_axis(trace, index), offset, orientation
            ),
            end_point = _parallel_trace_point(
                trace_path_end_axis(trace, index), offset, orientation
            )
        )
        concat(
            [start_point, end_point],
            _parallel_trace_points(traces, orientation, index + 1)
        );

// Function: parallel_trace_path()
// Synopsis: Returns one open ordered path through all configured traces.
// Arguments:
//   traces = Records of [axis_min, axis_max, perpendicular_position].
//   orientation = 0 for X-running traces or 90 for Y-running traces.
//   lead_in = Straight entry length before the first trace, in millimeters.
// Description:
//   Adjacent records must share the alternating endpoint used by their turn.
//   The path therefore connects traces only with perpendicular square turns.
//   Every trace length and every offset difference may be different.
function parallel_trace_path(traces, orientation = 0, lead_in = 0) =
    assert(len(traces) >= 1,
        "A parallel-trace path requires at least one trace record.")
    assert(orientation == 0 || orientation == 90,
        "Parallel-trace orientation must be 0 or 90 degrees.")
    assert(lead_in >= 0,
        "Parallel-trace lead-in must be zero or positive.")
    let(
        body = _parallel_trace_points(traces, orientation),
        first = body[0],
        lead_start = orientation == 0
            ? [first[0] - lead_in, first[1]]
            : [first[0], first[1] - lead_in]
    )
    lead_in > 0 ? concat([lead_start], body) : body;

// Function: trace_repeat_distances()
// Synopsis: Returns centerline-to-centerline repeat distances between traces.
function trace_repeat_distances(traces) =
    len(traces) < 2
        ? []
        : [for (i = [0 : len(traces) - 2])
            abs(traces[i + 1][PTR_OFFSET] - traces[i][PTR_OFFSET])];

// Function: trace_clear_gaps()
// Synopsis: Returns clear edge-to-edge gaps for a specified trace width.
function trace_clear_gaps(traces, trace_width) =
    [for (distance = trace_repeat_distances(traces))
        distance - trace_width];

// Function: parallel_trace_lengths()
// Synopsis: Returns the independently configured lengths of all traces.
function parallel_trace_lengths(traces) =
    [for (trace = traces) trace_axis_length(trace)];

// Function: path_bounds_2d()
// Synopsis: Returns [min_x, max_x, min_y, max_y] for an ordered XY path.
function path_bounds_2d(points) = [
    min([for (point = points) point[0]]),
    max([for (point = points) point[0]]),
    min([for (point = points) point[1]]),
    max([for (point = points) point[1]])
];
