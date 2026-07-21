//////////////////////////////////////////////////////////////////////
// LibFile: workbenches.scad
// Project: Grid Stack
// FileGroup: Workbench Routing
// FileSummary: Defines the supported user-interface workbenches and their
//              permitted render modes.
// Role: Separates exposed controls and project registries without changing the
//       shared geometry engine. Future web routes can generate the same wrapper
//       assignments used by the OpenSCAD Customizer.
// Exports: WORKBENCH_NAMES, workbench_render_mode_allowed(),
//          validate_workbench_selection(), and report_stub_workbench().
//////////////////////////////////////////////////////////////////////

WORKBENCH_NAMES = [
    "development",
    "coupons",
    "catalog",
    "laboratory"
];

function workbench_name_valid(name) =
    len([for (candidate = WORKBENCH_NAMES) if (candidate == name) candidate]) == 1;

function workbench_render_mode_allowed(name, mode) =
    name == "development"
        ? (mode == "structural_coupon" ||
           mode == "path_preview" ||
           mode == "report_only")
    : name == "coupons"
        ? (mode == "structural_coupon" ||
           mode == "path_preview" ||
           mode == "report_only")
    : name == "catalog"
        ? mode == "report_only"
    : name == "laboratory"
        ? mode == "report_only"
    : false;

module validate_workbench_selection(
    workbench_name,
    project_name,
    project_registry,
    render_mode
) {
    assert(workbench_name_valid(workbench_name),
        str("Unknown Grid Stack workbench: ", workbench_name));
    assert(len(records_named(project_registry, project_name)) == 1,
        str(
            "Project '", project_name,
            "' is not registered in workbench '", workbench_name, "'."
        ));
    assert(workbench_render_mode_allowed(workbench_name, render_mode),
        str(
            "Render mode '", render_mode,
            "' is not allowed in workbench '", workbench_name, "'."
        ));

    echo(str("GRID STACK WORKBENCH: ", workbench_name));
    echo("GRID STACK WORKBENCH VALIDATION: PASS");
}

module report_stub_workbench(workbench_name, project, report_level = "full") {
    echo(str("--- Grid Stack ", workbench_name, " workbench ---"));
    echo(str("Project: ", project[PR_NAME]));
    echo("Status: registered stub; no printable geometry is implemented.");

    if (report_level == "full")
        echo(str("Notes: ", project[PR_NOTES]));
}
