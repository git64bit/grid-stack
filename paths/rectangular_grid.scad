//////////////////////////////////////////////////////////////////////
// LibFile: rectangular_grid.scad
// Project: Grid Stack
// FileGroup: Path Generation
// FileSummary: Generates one continuous rectangular count-grid layer.
// Role: Core path generator shared by coupons, panels, and presets.
//////////////////////////////////////////////////////////////////////

function expected_rectangular_grid_point_count(run_count, lead_in = 0) =
    2 * run_count + (lead_in > 0 ? 1 : 0);

function rectangular_grid_path(
    boundary, process, nozzle, orientation = 0, lead_in = 0
) =
    assert(boundary_is_count_driven(boundary),
        "Rectangular grid generation requires count_boundary().")
    assert(boundary[B_KIND] == "rectangle",
        "Rectangular grid generation requires a rectangle.")
    assert(orientation == 0 || orientation == 90,
        "Rectangular grid orientation must be 0 or 90 degrees.")
    assert(lead_in >= 0,
        "Rectangular grid lead-in cannot be negative.")
    let(
        strand_w = strand_width(process, nozzle),
        margin = boundary[B_EDGE_MARGIN],
        x_min = margin + strand_w / 2,
        y_min = margin + strand_w / 2,
        x_max = boundary_size_x(boundary, process, nozzle)
            - margin - strand_w / 2,
        y_max = boundary_size_y(boundary, process, nozzle)
            - margin - strand_w / 2,
        pitch_x = boundary_strand_pitch_x(boundary, process, nozzle),
        pitch_y = boundary_strand_pitch_y(boundary, process, nozzle),
        entry = [x_min, y_min],
        prefix = lead_in > 0
            ? (orientation == 0
                ? [[x_min - lead_in, y_min], entry]
                : [[x_min, y_min - lead_in], entry])
            : [entry]
    )
    orientation == 0
        ? concat(prefix,
            _x_serpentine_rows(
                0, boundary_strand_count_y(boundary),
                x_min, x_max, y_min, pitch_y
            ))
        : concat(prefix,
            _y_serpentine_columns(
                0, boundary_strand_count_x(boundary),
                x_min, y_min, y_max, pitch_x
            ));
