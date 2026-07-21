//////////////////////////////////////////////////////////////////////
// LibFile: deferred_features.scad
// Project: Grid Stack
// FileGroup: Reserved Extension Points
// FileSummary: Machine-readable registry of intentionally deferred framework
//              features retained so later work does not lose their names.
// Role: Documents stubs only. These records do not generate geometry and are
//       rejected by the rectangular coupon framework validation contract.
// Exports: DEFERRED_FEATURES and report_deferred_features().
//////////////////////////////////////////////////////////////////////

DEFERRED_FEATURES = [
    [
        "dimension_boundary",
        "boundary_stub",
        "Fit a requested outside envelope without adding a perimeter border."
    ],
    [
        "circle_boundary",
        "boundary_stub",
        "Intersect continuous paths with a circular contour."
    ],
    [
        "regular_polygon_boundary",
        "boundary_stub",
        "Support hexagonal and other regular-polygon outer contours."
    ],
    [
        "custom_polygon_boundary",
        "boundary_stub",
        "Support arbitrary user-supplied outer contours."
    ],
    [
        "mixed_square_hex_pattern",
        "pattern_stub",
        "Transition continuously from two outer square rows to a hex interior."
    ],
    [
        "positive_vertical_gap_support",
        "geometry_stub",
        "Build printable support or anchor geometry for 1-3 mm clear Z gaps."
    ]
];

// Module: report_deferred_features()
// Synopsis: Prints every reserved extension point and its current status.
module report_deferred_features() {
    echo("--- Grid Stack deferred feature stubs ---");
    for (feature = DEFERRED_FEATURES)
        echo(feature);
}
