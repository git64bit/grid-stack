//////////////////////////////////////////////////////////////////////
// LibFile: validation.scad
// Project: Grid Stack
// FileGroup: API v3 Validation
// FileSummary: Validates immutable environment records, count boundaries,
//              support strategy, path continuity, and layer quantization.
// Role: Rejects incompatible or physically floating recipes before geometry
//       is generated.
// Requires: API v3 indexes, mathematics, and path generator.
// Exports: validate_structural_coupon_object().
//////////////////////////////////////////////////////////////////////

module _validate_path3(points, boundary, orientation, lead_in) {
    run_count = orientation == 0
        ? boundary_strand_count_y3(boundary)
        : boundary_strand_count_x3(boundary);

    assert(len(points) == expected_coupon_point_count3(run_count, lead_in),
        "API v3 coupon path has an unexpected point count.");
    assert(!path_has_zero_segment3(points),
        "API v3 coupon path contains a zero-length segment.");
    assert(path_axis_aligned3(points),
        "API v3 coupon path must remain axis-aligned.");
    assert(points[0] != points[len(points) - 1],
        "API v3 coupon path must remain open.");
}

module validate_structural_coupon_object(object) {
    assert(object[SCO_REQUIRED_API] == GRID_STACK_API_VERSION,
        "Saved coupon requires a different Grid Stack API version.");
    assert(object[SCO_SCHEMA_VERSION] == GRID_STACK_COUPON_SCHEMA_VERSION,
        "Saved coupon requires a different coupon schema version.");
    assert(GRID_STACK_RECTANGULAR_FRAMEWORK_VERSION == 2,
        "Saved coupon requires rectangular framework version 2.");

    material = object[SCO_MATERIAL];
    nozzle = object[SCO_NOZZLE];
    printer = object[SCO_PRINTER];
    process = object[SCO_PROCESS];
    boundary = object[SCO_BOUNDARY];
    gap = object[SCO_CLEAR_GAP];
    lead_in = object[SCO_LEAD_IN];
    strategy = object[SCO_SUPPORT_STRATEGY];

    assert(nozzle[NZ3_DIAMETER] > 0,
        "Saved coupon nozzle diameter must be positive.");
    assert(process[PX3_LAYER_H] > 0,
        "Saved coupon layer height must be positive.");
    assert(process[PX3_WIDTH_PASSES] >= 2,
        "Saved coupon structural width requires at least two passes.");
    assert(process[PX3_HEIGHT_PASSES] >= 2,
        "Saved coupon structural height requires at least two layers.");
    assert(process[PX3_MATERIAL] == material[MAT3_NAME],
        "Saved coupon process/material references do not match.");
    assert(process[PX3_NOZZLE] == nozzle[NZ3_NAME],
        "Saved coupon process/nozzle references do not match.");
    assert(process[PX3_PRINTER] == printer[PRN3_NAME],
        "Saved coupon process/printer references do not match.");
    assert(boundary[B3_CELLS_X] > 0 && boundary[B3_CELLS_Y] > 0,
        "Saved coupon cell counts must be positive.");
    assert(boundary[B3_CLEAR_SPAN_X] > 0 &&
           boundary[B3_CLEAR_SPAN_Y] > 0,
        "Saved coupon clear spans must be positive.");
    assert(lead_in >= 0,
        "Saved coupon lead-in cannot be negative.");
    assert(gap >= 0,
        "Saved coupon clear gap cannot be negative.");
    assert(nearly_equal3(gap_layer_count3(object), round(gap_layer_count3(object))),
        "Saved coupon clear gap must equal a whole deposited-layer count.");
    assert(
        (strategy == "direct_orthogonal" && nearly_equal3(gap, 0)) ||
        (strategy == "witness_riser_bridge" && gap > 0),
        "Saved coupon support strategy does not match its clear gap."
    );

    if (strategy == "direct_orthogonal") {
        lower = coupon_path(boundary, process, nozzle, 0, lead_in);
        upper = coupon_path(boundary, process, nozzle, 90, 0);
        _validate_path3(lower, boundary, 0, lead_in);
        _validate_path3(upper, boundary, 90, 0);
        entry = lead_in > 0 ? 1 : 0;
        assert(nearly_equal3(point_distance_2d3(lower[entry], upper[0]), 0),
            "Direct upper path must start on the lower entry crossing.");
    }
    else {
        witness = coupon_path(boundary, process, nozzle, 90, lead_in);
        riser = coupon_path(boundary, process, nozzle, 0, 0);
        test = coupon_path(boundary, process, nozzle, 90, 0);
        _validate_path3(witness, boundary, 90, lead_in);
        _validate_path3(riser, boundary, 0, 0);
        _validate_path3(test, boundary, 90, 0);
        entry = lead_in > 0 ? 1 : 0;
        assert(nearly_equal3(point_distance_2d3(witness[entry], riser[0]), 0),
            "Riser path must start on the witness entry crossing.");
        assert(nearly_equal3(point_distance_2d3(riser[0], test[0]), 0),
            "Upper test path must start on the riser entry crossing.");
        for (i = [0 : len(test) - 1])
            assert(nearly_equal3(point_distance_2d3(test[i], witness[i + entry]), 0),
                "Upper test path must align directly above the witness path.");
    }

    echo("GRID STACK API V3 COUPON VALIDATION: PASS");
}
