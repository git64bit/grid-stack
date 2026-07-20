//////////////////////////////////////////////////////////////////////
// LibFile: boundaries.scad
// Project: Grid Stack
// FileGroup: Configuration
// FileSummary: Catalog of perimeter-driven and grid-count-driven boundaries.
// Role: Defines either a fixed outside contour or a required number and size
//       of clear grid openings. It does not generate geometry.
// Requires: Boundary constructors and count_boundary_name().
// Exports: DIMENSION_BOUNDARIES, COUPON_CLEAR_SPANS, COUPON_BOUNDARIES,
//          BOUNDARIES
//////////////////////////////////////////////////////////////////////

DIMENSION_BOUNDARIES = [
    dimension_boundary(
        name = "RECT_200X100",
        kind = "rectangle",
        size_x = 200,
        size_y = 100,
        sides = 4,
        rotation = 0,
        edge_margin = 0.8,
        notes = "Finished-part boundary: outside dimensions are primary."
    ),

    dimension_boundary(
        name = "CIRCLE_150",
        kind = "circle",
        size_x = 150,
        size_y = 150,
        sides = 0,
        rotation = 0,
        edge_margin = 0.8,
        notes = "Reserved for a later boundary-intersection lesson."
    ),

    dimension_boundary(
        name = "HEX_150",
        kind = "regular_polygon",
        size_x = 150,
        size_y = 150,
        sides = 6,
        rotation = 30,
        edge_margin = 0.8,
        notes = "Reserved for a later boundary-intersection lesson."
    )
];

// These values deliberately cross the current 6 mm qualified bridge limit.
// Five and six millimeters confirm the known region; seven and eight
// millimeters explore where visible sag becomes unacceptable.
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
                "Coupon boundary: 3 x 3 clear openings at ",
                clear_span, " mm clear span."
            )
        )
];

BOUNDARIES = concat(DIMENSION_BOUNDARIES, COUPON_BOUNDARIES);
