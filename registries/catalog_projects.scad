//////////////////////////////////////////////////////////////////////
// LibFile: catalog_projects.scad
// Project: Grid Stack
// FileGroup: Catalog Registry
// FileSummary: Reserved registry for finished products intended for sale.
// Role: Establishes a separate workbench and future web route without exposing
//       coupon or laboratory controls at the catalog entry point.
// Exports: CATALOG_PROJECTS.
//////////////////////////////////////////////////////////////////////

CATALOG_PROJECTS = [
    project_spec(
        name = "CATALOG_WORKBENCH_STUB",
        process_name = "",
        boundary_name = "",
        path_policy_name = "",
        pattern_set_name = "",
        schedule_name = "",
        notes = "STUB: finished catalog products will be registered here."
    )
];
