//////////////////////////////////////////////////////////////////////
// LibFile: object_reporting.scad
// Project: Grid Stack
// FileGroup: Saved Objects
// FileSummary: Reports saved-object identity before delegating the embedded
//              engineering records to the normal Grid Stack report.
// Role: Makes a recipe auditable without consulting external catalogs.
// Requires: schema.scad, reporting.scad, and saved-object field indexes.
// Exports: report_grid_stack_object().
//////////////////////////////////////////////////////////////////////

module report_grid_stack_object(object, level = "summary") {
    material = object[GSO_MATERIAL];
    nozzle = object[GSO_NOZZLE];
    process = object[GSO_PROCESS];
    boundary = object[GSO_BOUNDARY];
    path_policy = object[GSO_PATH_POLICY];
    pattern_set = object[GSO_PATTERN_SET];
    schedule = object[GSO_SCHEDULE];

    project = project_spec(
        name = object[GSO_NAME],
        process_name = process[PX_NAME],
        boundary_name = boundary[B_NAME],
        path_policy_name = path_policy[PP_NAME],
        pattern_set_name = pattern_set[PS_NAME],
        schedule_name = schedule[SS_NAME],
        notes = object[GSO_NOTES]
    );

    echo("================ SAVED GRID STACK OBJECT ================");
    echo(str("Object: ", object[GSO_NAME]));
    echo(str("Object revision: ", object[GSO_REVISION]));
    echo(str("Required API: ", object[GSO_REQUIRED_API]));
    echo(str("Object schema: ", object[GSO_SCHEMA_VERSION]));
    echo(str("Source release: ", object[GSO_SOURCE_RELEASE]));
    echo(str("Status: ", object[GSO_STATUS]));
    echo(str("Path orientation: ", object[GSO_PATH_ORIENTATION], " degrees"));

    report_grid_stack(
        project, process, material, nozzle, boundary,
        path_policy, pattern_set, schedule, level
    );
}
