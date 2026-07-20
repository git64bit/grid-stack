//////////////////////////////////////////////////////////////////////
// LibFile: rectangular_serpentine.scad
// Project: Grid Stack
// FileGroup: Path Generation
// FileSummary: Generates one ordered open serpentine centerline for a
//              count-driven rectangular coupon.
// Role: Produces path points only. It does not create printable solids.
// Requires: Boundary and process field indexes plus boundary/process math.
// Exports: rectangular_serpentine_path(), expected_serpentine_point_count().
//////////////////////////////////////////////////////////////////////

// Function: _x_serpentine_rows()
// Synopsis: Recursively appends X-running rows and their square connectors.
function _x_serpentine_rows(row, row_count, x_min, x_max, y_min, pitch) =
    row >= row_count
        ? []
        : let(
            y = y_min + row * pitch,
            x_end = row % 2 == 0 ? x_max : x_min,
            row_end = [x_end, y],
            connector_end = [x_end, y + pitch]
        )
        concat(
            [row_end],
            row < row_count - 1 ? [connector_end] : [],
            _x_serpentine_rows(
                row + 1, row_count, x_min, x_max, y_min, pitch
            )
        );

// Function: _y_serpentine_columns()
// Synopsis: Recursively appends Y-running columns and square connectors.
function _y_serpentine_columns(
    column, column_count, x_min, y_min, y_max, pitch
) =
    column >= column_count
        ? []
        : let(
            x = x_min + column * pitch,
            y_end = column % 2 == 0 ? y_max : y_min,
            column_end = [x, y_end],
            connector_end = [x + pitch, y_end]
        )
        concat(
            [column_end],
            column < column_count - 1 ? [connector_end] : [],
            _y_serpentine_columns(
                column + 1, column_count, x_min, y_min, y_max, pitch
            )
        );

// Function: expected_serpentine_point_count()
// Synopsis: Point count for lead-in start, boundary entry, runs, and turns.
function expected_serpentine_point_count(run_count) = 2 * run_count + 1;

// Function: rectangular_serpentine_path()
// Synopsis: Returns exactly one open, ordered, axis-aligned nozzle centerline.
// Arguments:
//   boundary = Count-driven rectangular boundary record.
//   process = Qualified printing-process record.
//   nozzle = Nozzle hardware record.
//   policy = Path policy containing the lead-in length.
//   orientation = 0 for X-running rows or 90 for Y-running columns.
// Description:
//   The path starts outside the coupon, enters without a lift, traverses every
//   required structural-strand centerline, and ends once. Square connectors
//   join adjacent runs. There is no perimeter border and no closed subpath.
function rectangular_serpentine_path(
    boundary, process, nozzle, policy, orientation = 0
) =
    assert(boundary_is_count_driven(boundary),
        "Rectangular serpentine generation requires a count boundary.")
    assert(boundary[B_KIND] == "rectangle",
        "Rectangular serpentine generation requires a rectangle.")
    assert(orientation == 0 || orientation == 90,
        "Path orientation must be 0 or 90 degrees.")
    let(
        strand_w = strand_width(process, nozzle),
        margin = boundary[B_EDGE_MARGIN],
        x_min = margin + strand_w / 2,
        y_min = margin + strand_w / 2,
        x_max = boundary_size_x(boundary, process, nozzle) - margin - strand_w / 2,
        y_max = boundary_size_y(boundary, process, nozzle) - margin - strand_w / 2,
        pitch_x = boundary_strand_pitch_x(boundary, process, nozzle),
        pitch_y = boundary_strand_pitch_y(boundary, process, nozzle),
        lead_in = policy[PP_LEAD_IN]
    )
    orientation == 0
        ? concat(
            [[x_min - lead_in, y_min], [x_min, y_min]],
            _x_serpentine_rows(
                0,
                boundary_strand_count_y(boundary),
                x_min, x_max, y_min, pitch_y
            )
        )
        : concat(
            [[x_min, y_min - lead_in], [x_min, y_min]],
            _y_serpentine_columns(
                0,
                boundary_strand_count_x(boundary),
                x_min, y_min, y_max, pitch_x
            )
        );
