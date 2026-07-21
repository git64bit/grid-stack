//////////////////////////////////////////////////////////////////////
// LibFile: projects.scad
// Project: Grid Stack
// FileGroup: Configuration
// FileSummary: Printable rectangular coupon project catalog plus one deferred
//              dimension/mixed-pattern tutorial stub.
// Role: Generates project records from the frozen boundary and schedule names
//       so the workbench no longer hardcodes one Batch 008 coupon.
// Requires: project_spec(), coupon_project_name(), count_boundary_name(), and
//           coupon_schedule_name().
// Exports: DIRECT_REFERENCE_PROJECTS, COUPON_MATRIX_PROJECTS,
//          DEFERRED_PROJECTS, and PROJECTS.
//////////////////////////////////////////////////////////////////////

DIRECT_REFERENCE_PROJECTS = [
    project_spec(
        name = coupon_project_name(3, 3, 6, 0),
        process_name = "PLA_PLUS_0P4_LH0P2_W2_H2_R1",
        boundary_name = count_boundary_name(3, 3, 6),
        path_policy_name = "ONE_PATH_WITH_LEAD_IN",
        pattern_set_name = "SQUARE_COUPON",
        schedule_name = coupon_schedule_name(0),
        notes = "Physically accepted direct-contact reference coupon."
    )
];

COUPON_MATRIX_PROJECTS = [
    for (clear_span = COUPON_CLEAR_SPANS)
        for (clear_gap = COUPON_VERTICAL_GAPS)
            project_spec(
                name = coupon_project_name(3, 3, clear_span, clear_gap),
                process_name = "PLA_PLUS_0P4_LH0P2_W2_H2_R1",
                boundary_name = count_boundary_name(3, 3, clear_span),
                path_policy_name = "ONE_PATH_WITH_LEAD_IN",
                pattern_set_name = "SQUARE_COUPON",
                schedule_name = coupon_schedule_name(clear_gap),
                notes = str(
                    "Printable coupon case: ", clear_span,
                    " mm XY clear span and ", clear_gap, " mm Z clear gap."
                )
            )
];

DEFERRED_PROJECTS = [
    project_spec(
        name = "TUTORIAL_RECT_45654",
        process_name = "PLA_PLUS_0P4_LH0P2_W2_H2_R1",
        boundary_name = "RECT_200X100",
        path_policy_name = "ONE_PATH_WITH_LEAD_IN",
        pattern_set_name = "OUTER2_SQUARE_INNER_HEX",
        schedule_name = "XGRID4_YGRID5_XGRID6_YGRID5_XGRID4",
        notes = "STUB: dimension boundary, mixed pattern, and expanded stack."
    )
];

PROJECTS = concat(
    DIRECT_REFERENCE_PROJECTS,
    COUPON_MATRIX_PROJECTS,
    DEFERRED_PROJECTS
);
