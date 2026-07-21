//////////////////////////////////////////////////////////////////////
// LibFile: paths.scad
// Project: Grid Stack
// FileGroup: API v3 Path Generation
// FileSummary: Generates one open rectangular serpentine centerline from a
//              count boundary for X- or Y-running structural paths.
// Role: Preserves parallel runs, square connectors, optional single lead-in,
//       and one uninterrupted ordered point list per deposited layer.
// Requires: API v3 indexes and mathematics.
// Exports: coupon_path() and expected_coupon_point_count3().
//////////////////////////////////////////////////////////////////////

function _x_rows3(row, count, x_min, x_max, y_min, pitch) =
    row >= count
        ? []
        : let(
            y = y_min + row * pitch,
            x_end = row % 2 == 0 ? x_max : x_min,
            row_end = [x_end, y],
            connector_end = [x_end, y + pitch]
        )
        concat(
            [row_end],
            row < count - 1 ? [connector_end] : [],
            _x_rows3(row + 1, count, x_min, x_max, y_min, pitch)
        );

function _y_columns3(column, count, x_min, y_min, y_max, pitch) =
    column >= count
        ? []
        : let(
            x = x_min + column * pitch,
            y_end = column % 2 == 0 ? y_max : y_min,
            column_end = [x, y_end],
            connector_end = [x + pitch, y_end]
        )
        concat(
            [column_end],
            column < count - 1 ? [connector_end] : [],
            _y_columns3(column + 1, count, x_min, y_min, y_max, pitch)
        );

function expected_coupon_point_count3(run_count, lead_in = 0) =
    2 * run_count + (lead_in > 0 ? 1 : 0);

function coupon_path(
    boundary, process, nozzle, orientation = 0, lead_in = 0
) =
    assert(orientation == 0 || orientation == 90,
        "API v3 coupon orientation must be 0 or 90 degrees.")
    assert(lead_in >= 0,
        "API v3 coupon lead-in cannot be negative.")
    let(
        width = strand_width3(process, nozzle),
        x_min = width / 2,
        y_min = width / 2,
        x_max = boundary_size_x3(boundary, process, nozzle) - width / 2,
        y_max = boundary_size_y3(boundary, process, nozzle) - width / 2,
        entry = [x_min, y_min],
        prefix = lead_in > 0
            ? (orientation == 0
                ? [[x_min - lead_in, y_min], entry]
                : [[x_min, y_min - lead_in], entry])
            : [entry]
    )
    orientation == 0
        ? concat(
            prefix,
            _x_rows3(
                0, boundary_strand_count_y3(boundary),
                x_min, x_max, y_min,
                boundary_pitch_y3(boundary, process, nozzle)
            )
        )
        : concat(
            prefix,
            _y_columns3(
                0, boundary_strand_count_x3(boundary),
                x_min, y_min, y_max,
                boundary_pitch_x3(boundary, process, nozzle)
            )
        );
