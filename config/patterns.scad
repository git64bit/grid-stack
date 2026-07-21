//////////////////////////////////////////////////////////////////////
// LibFile: patterns.scad
// Project: Grid Stack
// FileGroup: Configuration
// FileSummary: Active square coupon topology plus a named mixed-pattern stub.
// Role: Freezes the rectangular square-grid pattern while preserving the
//       square-to-hex requirement for later implementation.
// Requires: pattern_zone() and pattern_set() from lib/schema.scad.
// Exports: ACTIVE_PATTERN_SETS, DEFERRED_PATTERN_SETS, and PATTERN_SETS.
//////////////////////////////////////////////////////////////////////

ACTIVE_PATTERN_SETS = [
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
                notes = "Pitch derives from clear span plus strand width."
            )
        ],
        transition = "none",
        notes = "Frozen square topology for rectangular count coupons."
    )
];

DEFERRED_PATTERN_SETS = [
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
                notes = "STUB: two square rows around the outside boundary."
            ),
            pattern_zone(
                name = "hex_interior",
                pattern = "hexagon",
                band_kind = "remaining_interior",
                band_value = 0,
                spacing_source = "fixed_pitch",
                strand_pitch = 4.0,
                connector = "hex_turn",
                notes = "STUB: hexagonal interior path grammar."
            )
        ],
        transition = "continuous_shared_boundary",
        notes = "STUB: mixed square-to-hex generation is deferred."
    )
];

PATTERN_SETS = concat(ACTIVE_PATTERN_SETS, DEFERRED_PATTERN_SETS);
