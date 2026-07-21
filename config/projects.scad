//////////////////////////////////////////////////////////////////////
// LibFile: projects.scad
// Project: Grid Stack
// FileGroup: Workbench Project Router
// FileSummary: Selects only the registry exposed by the active workbench.
//////////////////////////////////////////////////////////////////////

DEVELOPMENT_PROJECTS = concat(
    COUPON_PROJECTS,
    CATALOG_PROJECTS,
    LABORATORY_PROJECTS,
    FIRST_LAYER_PROJECTS
);

PROJECTS =
    wb_workbench_name == "coupons" ? COUPON_PROJECTS :
    wb_workbench_name == "catalog" ? CATALOG_PROJECTS :
    wb_workbench_name == "laboratory" ? LABORATORY_PROJECTS :
    wb_workbench_name == "first-layer" ? FIRST_LAYER_PROJECTS :
    DEVELOPMENT_PROJECTS;
