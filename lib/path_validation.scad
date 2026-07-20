//////////////////////////////////////////////////////////////////////
// LibFile: path_validation.scad
// Project: Grid Stack
// FileGroup: Validation
// FileSummary: Assertions for the first generated rectangular coupon path.
// Role: Verifies one ordered open path before any structural solid is created.
// Requires: Path math, boundary math, field indexes, and process math.
// Exports: validate_rectangular_serpentine_path().
//////////////////////////////////////////////////////////////////////

module validate_rectangular_serpentine_path(
    points, boundary, process, nozzle, policy, orientation
) {
    run_count = orientation == 0
        ? boundary_strand_count_y(boundary)
        : boundary_strand_count_x(boundary);

    assert(len(points) == expected_serpentine_point_count(run_count),
        "Unexpected serpentine point count.");
    assert(len(points) >= 3,
        "A generated nozzle path requires at least three points.");
    assert(!path_has_zero_length_segment(points),
        "Generated path contains a zero-length segment.");
    assert(path_is_axis_aligned(points),
        "Square-turn coupon path must remain axis-aligned.");
    assert(nearly_equal(point_distance_2d(points[0], points[1]), policy[PP_LEAD_IN]),
        "Generated lead-in length does not match the path policy.");
    assert(path_start(points) != path_end(points),
        "The nozzle path must remain open, with one start and one end.");

    if (orientation == 0)
        assert(points[0][0] < 0,
            "The X-running lead-in must start outside the coupon envelope.");
    else
        assert(points[0][1] < 0,
            "The Y-running lead-in must start outside the coupon envelope.");

    echo("GRID STACK GENERATED PATH VALIDATION: PASS");
}
