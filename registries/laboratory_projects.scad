//////////////////////////////////////////////////////////////////////
// LibFile: laboratory_projects.scad
// Project: Grid Stack
// FileGroup: Laboratory Registry
// FileSummary: Exposes the generic Grid Panel and explicit deferred stubs.
// Role: Laboratory presets remain mutable until a physical print is accepted
//       and promoted to the Catalog.
//////////////////////////////////////////////////////////////////////

LABORATORY_PRINTABLE_PROJECTS = [
    project_spec(
        name = "GRID_PANEL_LAB",
        process_name = "WORKBENCH_GRID_PROCESS",
        boundary_name = "WORKBENCH_COUNT_BOUNDARY",
        path_policy_name = "WORKBENCH_GRID_PATH",
        pattern_set_name = "SQUARE_COUPON",
        schedule_name = "",
        notes = "Mutable count-boundary alternating-layer Grid Panel."
    )
];

LABORATORY_DEFERRED_PROJECTS = [
    project_spec(
        name = "TUTORIAL_RECT_45654",
        process_name = "",
        boundary_name = "RECT_200X100",
        path_policy_name = "",
        pattern_set_name = "OUTER2_SQUARE_INNER_HEX",
        schedule_name = "",
        notes = "STUB: dimension boundary and mixed pattern belong to deferred work."
    )
];

DEFERRED_PROJECTS = LABORATORY_DEFERRED_PROJECTS;
LABORATORY_PROJECTS = concat(
    LABORATORY_PRINTABLE_PROJECTS,
    LABORATORY_DEFERRED_PROJECTS
);
