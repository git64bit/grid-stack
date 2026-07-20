//////////////////////////////////////////////////////////////////////
// LibFile: patterns.scad
// Project: Grid Stack
// FileGroup: Configuration
// FileSummary: Named pattern topologies, zones, spacing sources, and
//              transition requirements.
// Role: Defines how a path is organized. Count-driven coupon dimensions remain
//       in boundaries.scad instead of being duplicated here.
// Requires: pattern_zone() and pattern_set() from lib/schema.scad.
// Exports: PATTERN_SETS
//////////////////////////////////////////////////////////////////////

PATTERN_SETS = [
    pattern_set(
        name = "OUTER2_SQUARE_INNER_HEX",
        zones = [
            pattern_zone(
                name = "outer_square_band",
                pattern = "square",
                band_kind = "outer_rows",
                band_value = 2,
                spacing_source = "fixed_pitch",
                strand_pitch = 4.0,
                connector = "square_turn",
                notes = "Two rows around the outside boundary."
            ),
            pattern_zone(
                name = "hex_interior",
                pattern = "hexagon",
                band_kind = "remaining_interior",
                band_value = 0,
                spacing_source = "fixed_pitch",
                strand_pitch = 4.0,
                connector = "hex_turn",
                notes = "Interior region after the two-row square band."
            )
        ],
        transition = "continuous_shared_boundary",
        notes = "The transition strategy is specified but not yet generated."
    ),

    pattern_set(
        name = "SQUARE_COUPON",
        zones = [
            pattern_zone(
                name = "coupon_square_grid",
                pattern = "square",
                band_kind = "entire_boundary",
                band_value = 0,
                spacing_source = "boundary_clear_span",
                strand_pitch = 0,
                connector = "square_turn",
                notes = "Pitch derives from coupon clear span plus strand width."
            )
        ],
        transition = "none",
        notes = "Simple square topology for bridge and vertical-gap coupons."
    )
];
