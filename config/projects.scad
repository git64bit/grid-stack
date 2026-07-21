//////////////////////////////////////////////////////////////////////
// LibFile: projects.scad
// Project: Grid Stack
// FileGroup: Workbench Project Router
// FileSummary: Selects the project registry exposed by the active workbench.
// Role: Keeps one shared renderer while allowing each executable wrapper and
//       future web route to expose only its own project family.
// Requires: wb_workbench_name and the coupon, catalog, and laboratory registries.
// Exports: DEVELOPMENT_PROJECTS and PROJECTS.
//////////////////////////////////////////////////////////////////////

DEVELOPMENT_PROJECTS = concat(
    COUPON_PROJECTS,
    CATALOG_PROJECTS,
    LABORATORY_PROJECTS
);

PROJECTS =
    wb_workbench_name == "coupons" ? COUPON_PROJECTS :
    wb_workbench_name == "catalog" ? CATALOG_PROJECTS :
    wb_workbench_name == "laboratory" ? LABORATORY_PROJECTS :
    DEVELOPMENT_PROJECTS;
