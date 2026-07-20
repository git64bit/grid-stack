//////////////////////////////////////////////////////////////////////
// LibFile: patterns.scad
// Project: Grid Stack
// FileGroup: Configuration
// FileSummary: Named pattern zones and transition requirements.
// Role: Supplies declarative records; it does not generate geometry.
// Requires: pattern_zone() and pattern_set() from lib/schema.scad, loaded first by main.scad.
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
                strand_pitch = 4.0,
                connector = "square_turn",
                notes = "Two rows around the outside boundary."
            ),
            pattern_zone(
                name = "hex_interior",
                pattern = "hexagon",
                band_kind = "remaining_interior",
                band_value = 0,
                strand_pitch = 4.0,
                connector = "hex_turn",
                notes = "Interior region after the two-row square band."
            )
        ],
        transition = "continuous_shared_boundary",
        notes = "The transition strategy is specified but not implemented in Batch 001."
    )
];
