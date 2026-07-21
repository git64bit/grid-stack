//////////////////////////////////////////////////////////////////////
// LibFile: laboratory_projects.scad
// Project: Grid Stack
// FileGroup: Laboratory Registry
// FileSummary: Deferred and experimental projects exposed only by the
//              laboratory workbench.
// Role: Preserves future boundary, pattern, and schedule concepts without
//       mixing them into the urgent rectangular coupon workflow.
// Exports: DEFERRED_PROJECTS and LABORATORY_PROJECTS.
//////////////////////////////////////////////////////////////////////

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

LABORATORY_PROJECTS = DEFERRED_PROJECTS;
