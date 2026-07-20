//////////////////////////////////////////////////////////////////////
// LibFile: coupons.scad
// Project: Grid Stack
// FileGroup: Configuration
// FileSummary: Named experimental matrices combining count-driven boundaries
//              with vertical-gap stack schedules.
// Role: Defines test intent without duplicating boundary or schedule records.
// Requires: coupon_series(), count_boundary_name(), gap_schedule_name(),
//           COUPON_CLEAR_SPANS, and COUPON_VERTICAL_GAPS.
// Exports: COUPON_SERIES
//////////////////////////////////////////////////////////////////////

COUPON_SERIES = [
    coupon_series(
        name = "PLA_PLUS_BRIDGE_GAP_3X3",
        process_name = "PLA_PLUS_0P4_LH0P2_W2_H2_R1",
        boundary_names = [
            for (clear_span = COUPON_CLEAR_SPANS)
                count_boundary_name(3, 3, clear_span)
        ],
        schedule_names = [
            for (clear_gap = COUPON_VERTICAL_GAPS)
                gap_schedule_name(clear_gap)
        ],
        path_policy_name = "ONE_PATH_WITH_LEAD_IN",
        pattern_set_name = "SQUARE_COUPON",
        notes = "Twelve cases: four horizontal spans by three vertical gaps."
    )
];
