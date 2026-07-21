//////////////////////////////////////////////////////////////////////
// LibFile: main.scad
// Project: Grid Stack
// FileGroup: Shared Workbench Orchestrator
// FileSummary: Routes specialized workbench wrappers to the shared rectangular
//              grid engine or to registered catalog/laboratory stubs.
// Role: Rendering engine included by default.scad, workbenches/*.scad,
//       generated web wrappers, tests, or direct command-line invocation.
// Includes: Workbench resolver, project registries, mutable catalogs, rectangular
//           grid geometry, validation, reporting, and deferred-feature stubs.
//////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////
// GRID STACK CORE CONTRACT
// - One continuous open nozzle path per deposited layer.
// - No intentional lift, idle travel, or disconnected printed subpaths.
// - Parallel traces with perpendicular square connectors and square ends.
// - Alternating X/Y structural layers inside a rectangular count_boundary().
// - Cell count and clear span derive the outside dimensions; no filler border.
// - Trace size comes from the qualified nozzle and deposited layer height.
// - Structural strands require at least two width and two height passes.
// - Clear span, Z gap, trace size, and strand size remain distinct values.
// - Saved objects are immutable SCAD recipes pinned to a versioned API.
// - Laboratory objects reach Catalog only after physical acceptance.
// - Conflicting topology or geometry grammar belongs in another project.
//////////////////////////////////////////////////////////////////////
include <grid_stack.scad>
include <lib/coupon_framework.scad>
include <config/core_contract.scad>

include <config/defaults.scad>
include <config/workbenches.scad>
include <config/materials.scad>
include <config/nozzles.scad>
include <config/process_profiles.scad>

// The laboratory registry supplies mutable boundary and path-policy records
// before the shared catalogs are assembled.
include <registries/laboratory_projects.scad>

include <config/boundaries.scad>
include <config/path_policies.scad>
include <config/patterns.scad>
include <config/schedules.scad>
include <config/coupons.scad>
include <config/deferred_features.scad>

include <registries/coupon_projects.scad>
include <registries/catalog_projects.scad>
include <config/projects.scad>

include <paths/structural_coupon_paths.scad>
include <geometry/structural_strand.scad>
include <geometry/orthogonal_stack_coupon.scad>
include <geometry/vertical_gap_coupon.scad>
include <geometry/alternating_grid_stack.scad>
include <lib/laboratory_grid_stack.scad>
include <lib/structural_coupon_validation.scad>
include <lib/coupon_reporting.scad>
include <lib/structural_coupon_reporting.scad>

module run_rectangular_grid_project() {
    project = named_record(PROJECTS, wb_project_name, "project");
    process = named_record(
        PROCESS_PROFILES, project[PR_PROCESS], "process profile"
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
    schedule = named_record(
        STACK_SCHEDULES, project[PR_SCHEDULE], "stack schedule"
    );

    validate_grid_stack(
        project, process, material, nozzle, boundary,
        path_policy_record, pattern_set_record, schedule
    );

    validate_grid_stack_core_contract(
        project, process, nozzle, boundary,
        path_policy_record, pattern_set_record, schedule
    );

    report_grid_stack(
        project, process, material, nozzle, boundary,
        path_policy_record, pattern_set_record, schedule, wb_report_level
    );

    report_grid_stack_core_contract();

    if (wb_report_coupon_series) {
        selected_coupon_series = named_record(
            COUPON_SERIES,
            wb_coupon_series_name,
            "coupon series"
        );
        validate_coupon_series(selected_coupon_series);
        report_coupon_series(selected_coupon_series);
    }

    clear_vertical_gap = coupon_schedule_clear_gap(schedule);
    lower_lead_in = path_policy_record[PP_LEAD_IN];
    support_strategy = coupon_support_strategy(schedule);

    if (support_strategy == "direct_orthogonal") {
        lower_path = structural_coupon_path(
            boundary, process, nozzle, 0, lower_lead_in
        );
        upper_path = structural_coupon_path(
            boundary, process, nozzle, 90, 0
        );

        validate_direct_contact_stack_coupon(
            lower_points = lower_path,
            upper_points = upper_path,
            boundary = boundary,
            process = process,
            nozzle = nozzle,
            lower_orientation = 0,
            upper_orientation = 90,
            lower_lead_in = lower_lead_in,
            clear_vertical_gap = 0
        );

        report_direct_contact_stack_coupon(
            lower_path, upper_path, boundary, process, nozzle
        );

        if (wb_render_mode == "structural_coupon" ||
            wb_render_mode == "structural_grid")
            printable_direct_contact_stack_coupon(
                lower_path, upper_path, process, nozzle
            );
    }
    else if (support_strategy == "witness_riser_bridge") {
        witness_path = structural_coupon_path(
            boundary, process, nozzle, 90, lower_lead_in
        );
        riser_path = structural_coupon_path(
            boundary, process, nozzle, 0, 0
        );
        test_path = structural_coupon_path(
            boundary, process, nozzle, 90, 0
        );

        validate_positive_gap_stack_coupon(
            witness_points = witness_path,
            riser_points = riser_path,
            test_points = test_path,
            boundary = boundary,
            process = process,
            nozzle = nozzle,
            lead_in = lower_lead_in,
            clear_vertical_gap = clear_vertical_gap
        );

        report_positive_gap_stack_coupon(
            witness_path,
            riser_path,
            test_path,
            boundary,
            process,
            nozzle,
            clear_vertical_gap
        );

        if (wb_render_mode == "structural_coupon" ||
            wb_render_mode == "structural_grid")
            printable_vertical_gap_stack_coupon(
                witness_path,
                riser_path,
                test_path,
                process,
                nozzle,
                clear_vertical_gap
            );
    }
    else {
        assert(false, str("Unknown rectangular-grid support strategy: ", support_strategy));
    }

    if (wb_render_mode == "path_preview") {
        generated_path = rectangular_serpentine_path(
            boundary, process, nozzle, path_policy_record, wb_path_orientation
        );

        validate_rectangular_serpentine_path(
            generated_path, boundary, process, nozzle,
            path_policy_record, wb_path_orientation
        );

        report_generated_path(
            generated_path, boundary, process, nozzle, wb_path_orientation
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
    else if (wb_render_mode == "report_only") {
        echo("Rectangular-grid report-only mode: no geometry generated.");
    }
    else if (wb_render_mode != "structural_coupon" &&
             wb_render_mode != "structural_grid") {
        assert(false, str("Unknown rectangular-grid render mode: ", wb_render_mode));
    }
}


module run_laboratory_grid_panel() {
    project = named_record(PROJECTS, wb_project_name, "project");
    process = named_record(
        PROCESS_PROFILES, project[PR_PROCESS], "process profile"
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

    validate_material(material);
    validate_nozzle(nozzle);
    validate_process(process, material, nozzle);
    validate_boundary(boundary, process, nozzle);
    validate_path_policy(path_policy_record);
    validate_pattern_set(pattern_set_record, boundary, process, nozzle);

    validate_laboratory_grid_stack(
        project,
        process,
        nozzle,
        boundary,
        path_policy_record,
        pattern_set_record,
        wb_lab_deposited_layer_count,
        wb_lab_first_layer_orientation
    );

    report_laboratory_grid_stack(
        project,
        process,
        material,
        nozzle,
        boundary,
        path_policy_record,
        wb_lab_deposited_layer_count,
        wb_lab_first_layer_orientation,
        wb_report_level
    );

    report_grid_stack_core_contract();

    if (wb_render_mode == "structural_grid")
        printable_alternating_grid_stack(
            boundary = boundary,
            process = process,
            nozzle = nozzle,
            deposited_layer_count = wb_lab_deposited_layer_count,
            first_orientation = laboratory_orientation_degrees(
                wb_lab_first_layer_orientation
            ),
            lead_in = path_policy_record[PP_LEAD_IN]
        );
    else if (wb_render_mode == "path_preview") {
        preview_orientation = laboratory_orientation_degrees(
            wb_lab_first_layer_orientation
        );
        generated_path = structural_coupon_path(
            boundary,
            process,
            nozzle,
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
        echo("Laboratory grid report-only mode: no geometry generated.");
    else
        assert(false, str(
            "Unknown laboratory grid render mode: ", wb_render_mode
        ));
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

if (selected_is_coupon)
    run_rectangular_grid_project();
else if (selected_is_laboratory_printable)
    run_laboratory_grid_panel();
else if (selected_is_catalog)
    run_registered_stub("catalog");
else if (selected_is_laboratory_deferred)
    run_registered_stub("laboratory");
else
    assert(false, str("Project has no workbench route: ", wb_project_name));
