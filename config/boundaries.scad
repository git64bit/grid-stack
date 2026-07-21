//////////////////////////////////////////////////////////////////////
// LibFile: boundaries.scad
// Project: Grid Stack
// FileGroup: Configuration
// FileSummary: Active count-driven rectangular coupon boundaries plus named
//              dimension and non-rectangular boundary stubs.
// Role: Keeps the urgent rectangular coupon catalog operational while
//       preserving deferred boundary concepts without implementing them.
// Requires: Boundary constructors and count_boundary_name().
// Exports: COUPON_CLEAR_SPANS, COUPON_BOUNDARIES, DEFERRED_BOUNDARIES,
//          DIMENSION_BOUNDARIES compatibility alias, and BOUNDARIES.
//////////////////////////////////////////////////////////////////////

// These values deliberately cross the current 6 mm owner-tested bridge limit.
// Five and six millimeters confirm the known region; seven and eight explore
// the transition into visible sag. Exceeding the current limit is a test case,
// not an invalid boundary.
COUPON_CLEAR_SPANS = [5, 6, 7, 8];

COUPON_BOUNDARIES = [
    for (clear_span = COUPON_CLEAR_SPANS)
        count_boundary(
            name = count_boundary_name(3, 3, clear_span),
            cells_x = 3,
            cells_y = 3,
            clear_span_x = clear_span,
            clear_span_y = clear_span,
            kind = "rectangle",
            sides = 4,
            rotation = 0,
            edge_margin = 0,
            notes = str(
                "Active framework boundary: 3 x 3 clear openings at ",
                clear_span, " mm clear span."
            )
        )
];

// Reserved records remain lookup-visible but fail the rectangular framework
// contract with an explicit deferred-feature message.
DEFERRED_BOUNDARIES = [
    dimension_boundary(
        name = "RECT_200X100",
        kind = "rectangle",
        size_x = 200,
        size_y = 100,
        sides = 4,
        rotation = 0,
        edge_margin = 0.8,
        notes = "STUB: dimension-envelope fitting is deferred."
    ),
    dimension_boundary(
        name = "CIRCLE_150",
        kind = "circle",
        size_x = 150,
        size_y = 150,
        sides = 0,
        rotation = 0,
        edge_margin = 0.8,
        notes = "STUB: circular boundary intersections are deferred."
    ),
    dimension_boundary(
        name = "HEX_150",
        kind = "regular_polygon",
        size_x = 150,
        size_y = 150,
        sides = 6,
        rotation = 30,
        edge_margin = 0.8,
        notes = "STUB: regular-polygon boundary intersections are deferred."
    )
];

// Compatibility alias retained for earlier lessons and references.
DIMENSION_BOUNDARIES = DEFERRED_BOUNDARIES;

BOUNDARIES = concat(COUPON_BOUNDARIES, DEFERRED_BOUNDARIES);
