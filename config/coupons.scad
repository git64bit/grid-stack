//////////////////////////////////////////////////////////////////////
// LibFile: coupons.scad
// Project: Grid Stack
// FileGroup: Configuration
// FileSummary: Frozen twelve-case positive-gap coupon matrix and the accepted
//              direct-contact reference identity.
// Role: Defines test intent without duplicating boundary, schedule, or project
//       records. Printable positive-gap support remains a geometry stub.
// Requires: coupon_series(), count_boundary_name(), coupon_schedule_name(),
//           COUPON_CLEAR_SPANS, and COUPON_VERTICAL_GAPS.
// Exports: DIRECT_CONTACT_REFERENCE_PROJECT and COUPON_SERIES.
//////////////////////////////////////////////////////////////////////

DIRECT_CONTACT_REFERENCE_PROJECT = coupon_project_name(3, 3, 6, 0);

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
                coupon_schedule_name(clear_gap)
        ],
        path_policy_name = "ONE_PATH_WITH_LEAD_IN",
        pattern_set_name = "SQUARE_COUPON",
        notes = "Twelve cases: four XY clear spans by three Z clear gaps."
    )
];
