//////////////////////////////////////////////////////////////////////
// LibFile: main.scad
// Project: Grid Stack
// FileGroup: Development Entry Point
// FileSummary: Orchestrates the frozen rectangular count-boundary coupon
//              framework, all thirteen coupon cases, diagnostics, and stubs.
// Role: Development and exploration entry point. Permanent printed constructs
//       belong in objects/coupons/ and import explicit API version 3.
// Includes: Current workbench foundation, mutable catalogs, direct-contact and
//           positive-gap geometry, validation, reporting, and deferred stubs.
//////////////////////////////////////////////////////////////////////

include <grid_stack.scad>

include <lib/coupon_framework.scad>

include <config/defaults.scad>
include <config/materials.scad>
include <config/nozzles.scad>
include <config/process_profiles.scad>
include <config/boundaries.scad>
include <config/path_policies.scad>
include <config/patterns.scad>
include <config/schedules.scad>
include <config/coupons.scad>
include <config/projects.scad>
include <config/deferred_features.scad>

include <paths/structural_coupon_paths.scad>
include <geometry/structural_strand.scad>
include <geometry/orthogonal_stack_coupon.scad>
include <geometry/vertical_gap_coupon.scad>
include <lib/structural_coupon_validation.scad>
include <lib/coupon_reporting.scad>
include <lib/structural_coupon_reporting.scad>

project = named_record(PROJECTS, project_name_selected, "project");
process = named_record(PROCESS_PROFILES, project[PR_PROCESS], "process profile");
material = named_record(MATERIALS, process[PX_MATERIAL], "material");
nozzle = named_record(NOZZLES, process[PX_NOZZLE], "nozzle");
boundary = named_record(BOUNDARIES, project[PR_BOUNDARY], "boundary");
path_policy_record = named_record(
    PATH_POLICIES, project[PR_PATH_POLICY], "path policy"
);
pattern_set_record = named_record(
    PATTERN_SETS, project[PR_PATTERN_SET], "pattern set"
);
schedule = named_record(STACK_SCHEDULES, project[PR_SCHEDULE], "stack schedule");

validate_grid_stack(
    project, process, material, nozzle, boundary,
    path_policy_record, pattern_set_record, schedule
);

validate_rectangular_coupon_framework(
    project, process, nozzle, boundary,
    path_policy_record, pattern_set_record, schedule
);

report_grid_stack(
    project, process, material, nozzle, boundary,
    path_policy_record, pattern_set_record, schedule, report_level
);

if (report_coupon_series_enabled) {
    selected_coupon_series = named_record(
        COUPON_SERIES,
        coupon_series_name_selected,
        "coupon series"
    );
    validate_coupon_series(selected_coupon_series);
    report_coupon_series(selected_coupon_series);
}

if (report_deferred_features_enabled)
    report_deferred_features();

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

    if (render_mode == "structural_coupon")
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

    if (render_mode == "structural_coupon")
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
    assert(false, str("Unknown coupon support strategy: ", support_strategy));
}

if (render_mode == "path_preview") {
    generated_path = rectangular_serpentine_path(
        boundary, process, nozzle, path_policy_record, path_orientation
    );

    validate_rectangular_serpentine_path(
        generated_path, boundary, process, nozzle,
        path_policy_record, path_orientation
    );

    report_generated_path(
        generated_path, boundary, process, nozzle, path_orientation
    );

    diagnostic_path_preview(
        points = generated_path,
        boundary_size = [
            boundary_size_x(boundary, process, nozzle),
            boundary_size_y(boundary, process, nozzle)
        ],
        show_envelope = show_boundary_envelope,
        show_point_numbers = show_path_point_numbers
    );
}
else if (render_mode == "report_only") {
    echo("Development report-only mode: no geometry generated.");
}
else if (render_mode != "structural_coupon") {
    assert(false, str("Unknown render mode: ", render_mode));
}
