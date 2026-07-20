//////////////////////////////////////////////////////////////////////
// LibFile: schedules.scad
// Project: Grid Stack
// FileGroup: Configuration
// FileSummary: Named ordered groups of completed structural strands,
//              orientations, and clear vertical gaps.
// Role: Counts reliable composed strands rather than raw deposited layers.
// Requires: strand_group(), stack_schedule(), and gap_schedule_name().
// Exports: COUPON_VERTICAL_GAPS, PRIMARY_STACK_SCHEDULES,
//          DIRECT_CONTACT_STACK_SCHEDULES, COUPON_STACK_SCHEDULES,
//          STACK_SCHEDULES
//////////////////////////////////////////////////////////////////////

PRIMARY_STACK_SCHEDULES = [
    stack_schedule(
        name = "X4_Y5_X6_Y5_X4",
        groups = [
            strand_group(0, 4, "OUTER2_SQUARE_INNER_HEX", 0,
                "Four completed X-oriented structural strands"),
            strand_group(90, 5, "OUTER2_SQUARE_INNER_HEX", 0,
                "Five completed Y-oriented structural strands"),
            strand_group(0, 6, "OUTER2_SQUARE_INNER_HEX", 0,
                "Six completed X-oriented center structural strands"),
            strand_group(90, 5, "OUTER2_SQUARE_INNER_HEX", 0,
                "Five completed Y-oriented structural strands"),
            strand_group(0, 4, "OUTER2_SQUARE_INNER_HEX", 0,
                "Four completed X-oriented structural strands")
        ],
        require_symmetry = true,
        notes = "Symmetric 4-5-6-5-4 schedule measured in completed strands."
    )
];


DIRECT_CONTACT_STACK_SCHEDULES = [
    stack_schedule(
        name = gap_schedule_name(0),
        groups = [
            strand_group(
                orientation = 0,
                strand_count = 1,
                pattern_set_name = "SQUARE_COUPON",
                clear_gap_after = 0,
                notes = "One completed lower X structural path"
            ),
            strand_group(
                orientation = 90,
                strand_count = 1,
                pattern_set_name = "SQUARE_COUPON",
                clear_gap_after = 0,
                notes = "One completed upper Y structural path in direct contact"
            )
        ],
        require_symmetry = false,
        notes = "Batch 008 direct-contact qualification schedule."
    )
];

COUPON_VERTICAL_GAPS = [1, 2, 3];

COUPON_STACK_SCHEDULES = [
    for (clear_gap = COUPON_VERTICAL_GAPS)
        stack_schedule(
            name = gap_schedule_name(clear_gap),
            groups = [
                strand_group(
                    orientation = 0,
                    strand_count = 1,
                    pattern_set_name = "SQUARE_COUPON",
                    clear_gap_after = clear_gap,
                    notes = "One completed lower X structural strand"
                ),
                strand_group(
                    orientation = 90,
                    strand_count = 1,
                    pattern_set_name = "SQUARE_COUPON",
                    clear_gap_after = 0,
                    notes = "One completed upper Y structural strand"
                )
            ],
            require_symmetry = false,
            notes = str(
                "Bridge coupon with ", clear_gap,
                " mm clear vertical separation."
            )
        )
];

STACK_SCHEDULES = concat(
    PRIMARY_STACK_SCHEDULES,
    DIRECT_CONTACT_STACK_SCHEDULES,
    COUPON_STACK_SCHEDULES
);
