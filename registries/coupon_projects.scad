//////////////////////////////////////////////////////////////////////
// LibFile: coupon_projects.scad
// Project: Grid Stack
// FileGroup: Coupon Registry
// FileSummary: Exposes one generic rectangular coupon generator.
// Role: Coupon variations are saved as Customizer presets instead of being
//       hard-coded as one project or source file per case.
//////////////////////////////////////////////////////////////////////

COUPON_PROJECTS = [
    project_spec(
        name = "GRID_COUPON",
        process_name = "WORKBENCH_GRID_PROCESS",
        boundary_name = "WORKBENCH_COUNT_BOUNDARY",
        path_policy_name = "WORKBENCH_GRID_PATH",
        pattern_set_name = "SQUARE_COUPON",
        schedule_name = "",
        notes = "Generic count-boundary coupon configured and saved through Customizer presets."
    )
];
