//////////////////////////////////////////////////////////////////////
// LibFile: main.scad
// Project: Grid Stack
// FileGroup: Development Entry Point
// FileSummary: Orchestrates the frozen rectangular count-boundary coupon
//              framework, diagnostics, direct-contact geometry, and stubs.
// Role: Development and exploration entry point. Permanent printed constructs
//       belong in objects/ and must import an explicit versioned API.
// Includes: Current workbench API, mutable catalogs, framework contract,
//           rectangular coupon paths/geometry, validation, and reporting.
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

lower_group = schedule[SS_GROUPS][0];
upper_group = schedule[SS_GROUPS][1];
lower_orientation = lower_group[PLG_ORIENTATION];
upper_orientation = upper_group[PLG_ORIENTATION];
clear_vertical_gap = coupon_schedule_clear_gap(schedule);
lower_lead_in = path_policy_record[PP_LEAD_IN];

lower_path = structural_coupon_path(
    boundary, process, nozzle, lower_orientation, lower_lead_in
);
upper_path = structural_coupon_path(
    boundary, process, nozzle, upper_orientation, 0
);

validate_rectangular_stack_coupon(
    lower_points = lower_path,
    upper_points = upper_path,
    boundary = boundary,
    process = process,
    nozzle = nozzle,
    lower_orientation = lower_orientation,
    upper_orientation = upper_orientation,
    lower_lead_in = lower_lead_in,
    clear_vertical_gap = clear_vertical_gap
);

report_rectangular_stack_coupon(
    lower_path,
    upper_path,
    boundary,
    process,
    nozzle,
    clear_vertical_gap
);

if (render_mode == "structural_coupon") {
    assert_coupon_print_geometry_supported(schedule);

    printable_direct_contact_stack_coupon(
        lower_path, upper_path, process, nozzle
    );
}
else if (render_mode == "path_preview") {
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
else {
    assert(false, str("Unknown render mode: ", render_mode));
}
