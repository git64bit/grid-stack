//////////////////////////////////////////////////////////////////////
// LibFile: structural_coupon_validation.scad
// Project: Grid Stack
// FileGroup: Validation
// FileSummary: Assertions for rectangular count-boundary orthogonal coupons
//              and their two continuous complete grid-layer paths.
// Role: Separates valid coupon specifications from currently printable gap
//       geometry. Exploratory spans beyond the owner-tested limit remain valid.
// Requires: Path, boundary, process, and framework mathematics plus indexes.
// Exports: validate_rectangular_stack_coupon() and the direct-contact wrapper.
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

// Module: validate_rectangular_stack_coupon()
// Synopsis: Validates geometry-independent coupon path and process contracts.
// Description:
//   clear_vertical_gap may be zero or positive. This module validates the
//   specification and both XY paths but does not claim that positive-gap
//   support geometry exists. The framework stub controls print availability.
module validate_rectangular_stack_coupon(
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
        "Structural coupons require a count-driven boundary.");
    assert(boundary[B_KIND] == "rectangle",
        "Structural coupons require a rectangular boundary.");
    assert(abs(lower_orientation - upper_orientation) == 90,
        "Structural coupon layers must be orthogonal.");
    assert(clear_vertical_gap >= 0,
        "Clear vertical gap cannot be negative.");
    assert(process[PX_WIDTH_PASSES] >= 2,
        "Structural width requires at least two nozzle passes.");
    assert(process[PX_HEIGHT_PASSES] >= 2,
        "Structural height requires at least two deposited layers.");

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
        "Upper path XY start must match the lower boundary-entry crossing.");

    echo("GRID STACK RECTANGULAR COUPON SPECIFICATION: PASS");
}

// Module: validate_direct_contact_stack_coupon()
// Synopsis: Compatibility wrapper for the accepted zero-gap coupon.
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
    validate_rectangular_stack_coupon(
        lower_points,
        upper_points,
        boundary,
        process,
        nozzle,
        lower_orientation,
        upper_orientation,
        lower_lead_in,
        clear_vertical_gap
    );

    assert(nearly_equal(clear_vertical_gap, 0),
        "Direct-contact coupon validation requires zero vertical gap.");

    echo("GRID STACK DIRECT-CONTACT COUPON VALIDATION: PASS");
}
