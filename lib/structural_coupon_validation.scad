//////////////////////////////////////////////////////////////////////
// LibFile: structural_coupon_validation.scad
// Project: Grid Stack
// FileGroup: Validation
// FileSummary: Assertions for direct-contact and positive-gap rectangular
//              coupons built from continuous complete grid-layer paths.
// Role: Validates path topology, process composition, layer quantization,
//       witness alignment, and riser support without creating geometry.
// Requires: Path, boundary, process, and framework mathematics plus indexes.
// Exports: validate_rectangular_stack_coupon(),
//          validate_positive_gap_stack_coupon(), and compatibility wrapper.
//////////////////////////////////////////////////////////////////////

// Module: _validate_structural_coupon_path()
// Synopsis: Validates one ordered coupon path.
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
// Synopsis: Validates the shared rectangular coupon process and boundary.
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
        "Direct-contact coupon layers must be orthogonal.");
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

// Module: validate_positive_gap_stack_coupon()
// Synopsis: Validates witness, riser, and aligned upper-test paths.
module validate_positive_gap_stack_coupon(
    witness_points,
    riser_points,
    test_points,
    boundary,
    process,
    nozzle,
    lead_in,
    clear_vertical_gap
) {
    gap_layers = clear_vertical_gap / trace_height(process);

    assert(clear_vertical_gap > 0,
        "Positive-gap coupon requires a clear gap greater than zero.");
    assert(nearly_equal(gap_layers, round(gap_layers)),
        "Positive gap must equal a whole deposited-layer count.");

    _validate_structural_coupon_path(
        witness_points, boundary, 90, lead_in
    );
    _validate_structural_coupon_path(
        riser_points, boundary, 0, 0
    );
    _validate_structural_coupon_path(
        test_points, boundary, 90, 0
    );

    witness_entry_index = lead_in > 0 ? 1 : 0;

    assert(nearly_equal(point_distance_2d(
            witness_points[witness_entry_index], riser_points[0]
        ), 0),
        "Riser path must start on the witness entry crossing.");
    assert(nearly_equal(point_distance_2d(
            riser_points[0], test_points[0]
        ), 0),
        "Upper test path must start on the riser entry crossing.");
    assert(len(test_points) == len(witness_points) - (lead_in > 0 ? 1 : 0),
        "Upper test path must match the witness path without its lead-in.");

    for (i = [0 : len(test_points) - 1])
        assert(nearly_equal(point_distance_2d(
                test_points[i],
                witness_points[i + (lead_in > 0 ? 1 : 0)]
            ), 0),
            "Upper test path must align directly above the witness path.");

    echo("GRID STACK POSITIVE-GAP COUPON VALIDATION: PASS");
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
