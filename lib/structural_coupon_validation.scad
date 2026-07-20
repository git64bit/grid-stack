//////////////////////////////////////////////////////////////////////
// LibFile: structural_coupon_validation.scad
// Project: Grid Stack
// FileGroup: Validation
// FileSummary: Assertions for the first direct-contact orthogonal structural
//              coupon and its two continuous layer paths.
// Role: Rejects unsupported gaps, weak one-pass process definitions, broken
//       paths, nonorthogonal orientations, and unqualified bridge spans.
// Requires: Path, boundary, and process mathematics plus field indexes.
// Exports: validate_direct_contact_stack_coupon().
//////////////////////////////////////////////////////////////////////

// Module: _validate_structural_coupon_path()
// Synopsis: Validates one lower or upper ordered coupon path.
module _validate_structural_coupon_path(
    points, boundary, orientation, lead_in
) {
    run_count = orientation == 0
        ? boundary_strand_count_y(boundary)
        : boundary_strand_count_x(boundary);

    assert(len(points) ==
        expected_structural_coupon_point_count(run_count, lead_in),
        "Unexpected structural coupon path point count.");
    assert(len(points) >= 2,
        "A structural coupon path requires at least two points.");
    assert(!path_has_zero_length_segment(points),
        "Structural coupon path contains a zero-length segment.");
    assert(path_is_axis_aligned(points),
        "Structural coupon paths must remain axis-aligned.");
    assert(path_start(points) != path_end(points),
        "Structural coupon paths must remain open.");
}

// Module: validate_direct_contact_stack_coupon()
// Synopsis: Validates one lower X path and one upper Y path at zero gap.
module validate_direct_contact_stack_coupon(
    lower_points,
    upper_points,
    boundary,
    process,
    nozzle,
    lower_orientation = 0,
    upper_orientation = 90,
    lower_lead_in = 0,
    clear_vertical_gap = 0
) {
    assert(boundary_is_count_driven(boundary),
        "The first structural coupon requires a count-driven boundary.");
    assert(boundary[B_KIND] == "rectangle",
        "The first structural coupon requires a rectangular boundary.");
    assert(abs(lower_orientation - upper_orientation) == 90,
        "Structural coupon layers must be orthogonal.");
    assert(nearly_equal(clear_vertical_gap, 0),
        "Batch 008 supports direct contact only; vertical gaps need anchors.");
    assert(process[PX_WIDTH_PASSES] >= 2,
        "Structural width requires at least two nozzle passes.");
    assert(process[PX_HEIGHT_PASSES] >= 2,
        "Structural height requires at least two deposited layers.");
    assert(boundary[B_CLEAR_SPAN_X] <= process[PX_BRIDGE_MAX],
        "Coupon X clear span exceeds the qualified bridge maximum.");
    assert(boundary[B_CLEAR_SPAN_Y] <= process[PX_BRIDGE_MAX],
        "Coupon Y clear span exceeds the qualified bridge maximum.");

    _validate_structural_coupon_path(
        lower_points, boundary, lower_orientation, lower_lead_in
    );
    _validate_structural_coupon_path(
        upper_points, boundary, upper_orientation, 0
    );

    lower_entry_index = lower_lead_in > 0 ? 1 : 0;

    assert(nearly_equal(point_distance_2d(
            lower_points[lower_entry_index],
            upper_points[0]
        ), 0),
        "Upper path must start at the lower path boundary-entry crossing.");

    echo("GRID STACK STRUCTURAL COUPON VALIDATION: PASS");
}
