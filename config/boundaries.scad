//////////////////////////////////////////////////////////////////////
// LibFile: boundaries.scad
// Project: Grid Stack
// FileGroup: Configuration
// FileSummary: Named outer contours independent of path and pattern logic.
// Role: Supplies declarative records; it does not generate geometry.
// Requires: boundary_profile() from lib/schema.scad, loaded first by main.scad.
// Exports: BOUNDARIES
//////////////////////////////////////////////////////////////////////

BOUNDARIES = [
    boundary_profile(
        name = "RECT_200X100",
        kind = "rectangle",
        size_x = 200,
        size_y = 100,
        sides = 4,
        rotation = 0,
        edge_margin = 0.8,
        notes = "Tutorial boundary only; no geometry is generated in Batch 001."
    ),

    boundary_profile(
        name = "CIRCLE_150",
        kind = "circle",
        size_x = 150,
        size_y = 150,
        sides = 0,
        rotation = 0,
        edge_margin = 0.8,
        notes = "Reserved for a later boundary-intersection lesson."
    ),

    boundary_profile(
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
