//////////////////////////////////////////////////////////////////////
// LibFile: projects.scad
// Project: Grid Stack
// FileGroup: Configuration
// FileSummary: Named project specifications that reference an exact process
//              environment and independent geometry policies.
// Role: Selects records by name without duplicating their dimensions.
// Requires: project_spec() from lib/schema.scad, loaded first by main.scad.
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
        notes = "Batch 002 reference specification."
    )
];
