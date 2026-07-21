//////////////////////////////////////////////////////////////////////
// LibFile: main.scad
// Project: Grid Stack
// FileGroup: Shared Workbench Orchestrator
// FileSummary: Routes preset-enabled workbenches to the fixed Grid Stack engine.
//////////////////////////////////////////////////////////////////////

include <grid_stack.scad>
include <config/core_contract.scad>
include <config/defaults.scad>
include <config/workbenches.scad>
include <config/materials.scad>
include <config/nozzles.scad>
include <config/process_profiles.scad>

include <registries/configurable_grid_projects.scad>
include <config/boundaries.scad>
include <config/path_policies.scad>
include <config/patterns.scad>
include <config/deferred_features.scad>

include <registries/coupon_projects.scad>
include <registries/catalog_projects.scad>
include <registries/laboratory_projects.scad>
include <registries/first_layer_projects.scad>
include <config/projects.scad>

include <paths/rectangular_grid.scad>
include <geometry/alternating_grid_stack.scad>
include <lib/configurable_grid_stack.scad>

module run_configurable_grid_project() {
    project = named_record(PROJECTS, wb_project_name, "project");
    process = named_record(
        CONFIGURABLE_GRID_PROCESS_PROFILES,
        project[PR_PROCESS],
        "configurable process profile"
    );
    material = named_record(MATERIALS, process[PX_MATERIAL], "material");
    nozzle = named_record(NOZZLES, process[PX_NOZZLE], "nozzle");
    boundary = named_record(BOUNDARIES, project[PR_BOUNDARY], "boundary");
    path_policy_record = named_record(
        PATH_POLICIES, project[PR_PATH_POLICY], "path policy"
    );
    pattern_set_record = named_record(
        PATTERN_SETS, project[PR_PATTERN_SET], "pattern set"
    );

    validate_configurable_grid_stack(
        project, process, material, nozzle, boundary,
        path_policy_record, pattern_set_record,
        wb_grid_deposited_layer_count,
        wb_grid_first_layer_orientation
    );

    report_configurable_grid_stack(
        project, process, material, nozzle, boundary,
        path_policy_record,
        wb_grid_deposited_layer_count,
        wb_grid_first_layer_orientation,
        wb_report_level
    );
    report_grid_stack_core_contract();

    if (wb_render_mode == "structural_grid")
        printable_alternating_grid_stack(
            boundary = boundary,
            process = process,
            nozzle = nozzle,
            deposited_layer_count = wb_grid_deposited_layer_count,
            first_orientation = grid_orientation_degrees(
                wb_grid_first_layer_orientation
            ),
            lead_in = path_policy_record[PP_LEAD_IN]
        );
    else if (wb_render_mode == "path_preview") {
        preview_orientation = grid_orientation_degrees(
            wb_grid_first_layer_orientation
        );
        generated_path = rectangular_grid_path(
            boundary, process, nozzle,
            preview_orientation,
            path_policy_record[PP_LEAD_IN]
        );

        diagnostic_path_preview(
            points = generated_path,
            boundary_size = [
                boundary_size_x(boundary, process, nozzle),
                boundary_size_y(boundary, process, nozzle)
            ],
            show_envelope = wb_show_boundary_envelope,
            show_point_numbers = wb_show_path_point_numbers
        );
    }
    else if (wb_render_mode == "report_only")
        echo("Configurable grid report-only mode: no geometry generated.");
    else
        assert(false, str("Unknown configurable-grid mode: ", wb_render_mode));
}

module run_first_layer_project() {
    project = named_record(PROJECTS, wb_project_name, "project");
    process = named_record(
        PROCESS_PROFILES,
        wb_first_layer_process_profile_name,
        "process profile"
    );
    material = named_record(MATERIALS, process[PX_MATERIAL], "material");
    nozzle = named_record(NOZZLES, process[PX_NOZZLE], "nozzle");

    assert(project[PR_NAME] == "FIRST_LAYER_TRACE_LAB",
        "Unexpected first-layer project route.");
    assert(wb_first_layer_trace_count >= 1 &&
           is_integer_value(wb_first_layer_trace_count),
        "First-layer trace count must be a positive integer.");
    assert(wb_first_layer_trace_count <= len(wb_first_layer_trace_catalog),
        "First-layer trace count exceeds the available trace records.");

    working_first_layer = first_layer_object(
        name = "FIRST_LAYER_TRACE_LAB_WORKING",
        revision = 1,
        required_api_version = 1,
        first_layer_schema_version = 1,
        source_release = GRID_STACK_RELEASE,
        material = material,
        nozzle = nozzle,
        process = process,
        traces = wb_first_layer_traces,
        orientation = wb_first_layer_trace_orientation,
        lead_in = wb_first_layer_lead_in,
        status = "calibration",
        notes = "Mutable first-layer workbench; promote accepted settings to Catalog."
    );

    first_layer_render(
        working_first_layer,
        mode = wb_render_mode,
        report_level = wb_report_level,
        show_path_point_numbers = wb_show_path_point_numbers
    );
}

module run_registered_stub(stub_kind) {
    project = named_record(PROJECTS, wb_project_name, "project");
    report_stub_workbench(stub_kind, project, wb_report_level);
    if (stub_kind == "laboratory" || wb_report_deferred_features)
        report_deferred_features();
}

validate_workbench_selection(
    wb_workbench_name,
    wb_project_name,
    PROJECTS,
    wb_render_mode
);

selected_is_coupon = len(records_named(COUPON_PROJECTS, wb_project_name)) == 1;
selected_is_catalog = len(records_named(CATALOG_PROJECTS, wb_project_name)) == 1;
selected_is_laboratory_printable =
    len(records_named(LABORATORY_PRINTABLE_PROJECTS, wb_project_name)) == 1;
selected_is_laboratory_deferred =
    len(records_named(LABORATORY_DEFERRED_PROJECTS, wb_project_name)) == 1;
selected_is_first_layer =
    len(records_named(FIRST_LAYER_PROJECTS, wb_project_name)) == 1;

if (selected_is_coupon || selected_is_laboratory_printable)
    run_configurable_grid_project();
else if (selected_is_first_layer)
    run_first_layer_project();
else if (selected_is_catalog)
    run_registered_stub("catalog");
else if (selected_is_laboratory_deferred)
    run_registered_stub("laboratory");
else
    assert(false, str("Project has no workbench route: ", wb_project_name));
