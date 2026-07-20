//////////////////////////////////////////////////////////////////////
// LibFile: projects.scad
// Project: Grid Stack
// FileGroup: Configuration
// FileSummary: Named project specifications that reference exact environments,
//              boundaries, path policies, patterns, and stack schedules.
// Role: Selects records by name without duplicating their dimensions.
// Requires: project_spec() and generated boundary/schedule naming helpers.
// Exports: PROJECTS
//////////////////////////////////////////////////////////////////////

PROJECTS = [
    project_spec(
        name = "TUTORIAL_RECT_45654",
        process_name = "PLA_PLUS_0P4_LH0P2_W2_H2_R1",
        boundary_name = "RECT_200X100",
        path_policy_name = "ONE_PATH_WITH_LEAD_IN",
        pattern_set_name = "OUTER2_SQUARE_INNER_HEX",
        schedule_name = "X4_Y5_X6_Y5_X4",
        notes = "Dimension-driven tutorial specification."
    ),

    project_spec(
        name = "COUPON_3X3_SPAN5_GAP1",
        process_name = "PLA_PLUS_0P4_LH0P2_W2_H2_R1",
        boundary_name = count_boundary_name(3, 3, 5),
        path_policy_name = "ONE_PATH_WITH_LEAD_IN",
        pattern_set_name = "SQUARE_COUPON",
        schedule_name = gap_schedule_name(1),
        notes = "One selectable member of the complete coupon series."
    )
];
