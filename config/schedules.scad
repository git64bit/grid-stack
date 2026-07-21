//////////////////////////////////////////////////////////////////////
// LibFile: schedules.scad
// Project: Grid Stack
// FileGroup: Configuration
// FileSummary: Frozen rectangular coupon specifications plus the deferred
//              multi-layer 4-5-6-5-4 schedule.
// Role: Counts complete continuous structural path layers, not individual
//       parallel strands and not raw slicer layers.
// Requires: path_layer_group(), stack_schedule(), coupon_schedule_name().
// Exports: COUPON_REFERENCE_VERTICAL_GAPS, COUPON_VERTICAL_GAPS,
//          COUPON_ALL_VERTICAL_GAPS, COUPON_STACK_SCHEDULES,
//          DEFERRED_STACK_SCHEDULES, compatibility aliases, STACK_SCHEDULES.
//////////////////////////////////////////////////////////////////////

COUPON_REFERENCE_VERTICAL_GAPS = [0];
COUPON_VERTICAL_GAPS = [1, 2, 3];
COUPON_ALL_VERTICAL_GAPS = concat(
    COUPON_REFERENCE_VERTICAL_GAPS,
    COUPON_VERTICAL_GAPS
);

COUPON_STACK_SCHEDULES = [
    for (clear_gap = COUPON_ALL_VERTICAL_GAPS)
        stack_schedule(
            name = coupon_schedule_name(clear_gap),
            groups = clear_gap == 0
                ? [
                    path_layer_group(
                        orientation = 0,
                        layer_count = 1,
                        pattern_set_name = "SQUARE_COUPON",
                        clear_gap_after = 0,
                        notes = "Accepted lower X direct-contact grid."
                    ),
                    path_layer_group(
                        orientation = 90,
                        layer_count = 1,
                        pattern_set_name = "SQUARE_COUPON",
                        clear_gap_after = 0,
                        notes = "Accepted upper Y direct-contact grid."
                    )
                  ]
                : [
                    path_layer_group(
                        orientation = 90,
                        layer_count = 1,
                        pattern_set_name = "SQUARE_COUPON",
                        clear_gap_after = clear_gap,
                        notes = "Lower Y witness grid; the X riser occupies the declared gap."
                    ),
                    path_layer_group(
                        orientation = 90,
                        layer_count = 1,
                        pattern_set_name = "SQUARE_COUPON",
                        clear_gap_after = 0,
                        notes = "Upper Y test grid aligned above the witness."
                    )
                  ],
            require_symmetry = false,
            notes = clear_gap == 0
                ? "Accepted direct-contact reference schedule."
                : str(
                    "Printable ", clear_gap,
                    " mm Y-witness/X-riser/Y-test calibration schedule."
                )
        )
];

DEFERRED_STACK_SCHEDULES = [
    stack_schedule(
        name = "XGRID4_YGRID5_XGRID6_YGRID5_XGRID4",
        groups = [
            path_layer_group(0, 4, "OUTER2_SQUARE_INNER_HEX", 0,
                "Four complete X-running grid layers"),
            path_layer_group(90, 5, "OUTER2_SQUARE_INNER_HEX", 0,
                "Five complete Y-running grid layers"),
            path_layer_group(0, 6, "OUTER2_SQUARE_INNER_HEX", 0,
                "Six complete X-running center grid layers"),
            path_layer_group(90, 5, "OUTER2_SQUARE_INNER_HEX", 0,
                "Five complete Y-running grid layers"),
            path_layer_group(0, 4, "OUTER2_SQUARE_INNER_HEX", 0,
                "Four complete X-running grid layers")
        ],
        require_symmetry = true,
        notes = "STUB: multi-layer mixed-pattern schedule is deferred."
    )
];

// Compatibility aliases retained for earlier lesson text.
DIRECT_CONTACT_STACK_SCHEDULES = [COUPON_STACK_SCHEDULES[0]];
PRIMARY_STACK_SCHEDULES = DEFERRED_STACK_SCHEDULES;

STACK_SCHEDULES = concat(
    COUPON_STACK_SCHEDULES,
    DEFERRED_STACK_SCHEDULES
);
