//////////////////////////////////////////////////////////////////////
// LibFile: structural_coupon_paths.scad
// Project: Grid Stack
// FileGroup: Path Generation
// FileSummary: Generates lower and upper rectangular coupon paths for a
//              direct-contact orthogonal structural-strand stack.
// Role: Keeps each deposited layer as one ordered open path while allowing
//       only the lower layer to use an external lead-in.
// Requires: Boundary/process indexes, boundary_math.scad, process_math.scad,
//           and the row/column helpers from rectangular_serpentine.scad.
// Exports: structural_coupon_path() and
//          expected_structural_coupon_point_count().
//////////////////////////////////////////////////////////////////////

// Function: expected_structural_coupon_point_count()
// Synopsis: Returns the point count for a rectangular path with optional
//           external lead-in.
function expected_structural_coupon_point_count(run_count, lead_in = 0) =
    2 * run_count + (lead_in > 0 ? 1 : 0);

// Function: structural_coupon_path()
// Synopsis: Generates one axis-aligned open path for one structural layer.
// Arguments:
//   boundary = Count-driven rectangular boundary record.
//   process = Qualified structural-strand process record.
//   nozzle = Nozzle hardware record.
//   orientation = 0 for X-running rows or 90 for Y-running columns.
//   lead_in = External lead-in length. Use zero for an upper layer.
// Description:
//   With lead_in > 0, the path starts outside the coupon and enters at the
//   lower-left strand crossing. With lead_in == 0, it starts directly at that
//   crossing so an upper layer begins on already deposited material.
function structural_coupon_path(
    boundary, process, nozzle, orientation = 0, lead_in = 0
) =
    assert(boundary_is_count_driven(boundary),
        "Structural coupon generation requires a count boundary.")
    assert(boundary[B_KIND] == "rectangle",
        "Structural coupon generation requires a rectangle.")
    assert(orientation == 0 || orientation == 90,
        "Structural coupon orientation must be 0 or 90 degrees.")
    assert(lead_in >= 0,
        "Structural coupon lead-in cannot be negative.")
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
        ? concat(
            prefix,
            _x_serpentine_rows(
                0,
                boundary_strand_count_y(boundary),
                x_min, x_max, y_min, pitch_y
            )
        )
        : concat(
            prefix,
            _y_serpentine_columns(
                0,
                boundary_strand_count_x(boundary),
                x_min, y_min, y_max, pitch_x
            )
        );
