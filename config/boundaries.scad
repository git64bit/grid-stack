//////////////////////////////////////////////////////////////////////
// LibFile: boundaries.scad
// Project: Grid Stack
// FileGroup: Configuration
// FileSummary: Active mutable count boundary plus explicit future stubs.
// Role: Coupon variants are no longer hard-coded here; Customizer presets
//       provide the active count and clear-span values.
//////////////////////////////////////////////////////////////////////

ACTIVE_COUNT_BOUNDARIES = is_undef(CONFIGURABLE_GRID_BOUNDARIES)
    ? [] : CONFIGURABLE_GRID_BOUNDARIES;

DEFERRED_BOUNDARIES = [
    dimension_boundary(
        name = "RECT_200X100", kind = "rectangle",
        size_x = 200, size_y = 100, sides = 4,
        rotation = 0, edge_margin = 0,
        notes = "STUB: dimension-envelope fitting is deferred."
    ),
    dimension_boundary(
        name = "CIRCLE_150", kind = "circle",
        size_x = 150, size_y = 150, sides = 0,
        rotation = 0, edge_margin = 0,
        notes = "STUB: circular boundaries belong to future work."
    ),
    dimension_boundary(
        name = "HEX_150", kind = "regular_polygon",
        size_x = 150, size_y = 150, sides = 6,
        rotation = 30, edge_margin = 0,
        notes = "STUB: polygon boundaries belong to future work."
    )
];

DIMENSION_BOUNDARIES = DEFERRED_BOUNDARIES;
BOUNDARIES = concat(ACTIVE_COUNT_BOUNDARIES, DEFERRED_BOUNDARIES);
