//////////////////////////////////////////////////////////////////////
// LibFile: coupon_projects.scad
// Project: Grid Stack
// FileGroup: Coupon Registry
// FileSummary: Projects exposed by the coupon workbench.
// Role: Keeps calibration and qualification objects out of catalog and
//       laboratory project selectors.
// Exports: DIRECT_REFERENCE_PROJECTS, COUPON_MATRIX_PROJECTS,
//          and COUPON_PROJECTS.
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

COUPON_PROJECTS = concat(
    DIRECT_REFERENCE_PROJECTS,
    COUPON_MATRIX_PROJECTS
);
