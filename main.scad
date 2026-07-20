//////////////////////////////////////////////////////////////////////
// LibFile: main.scad
// Project: Grid Stack
// FileGroup: Development Entry Point
// FileSummary: Orchestrates Customizer-driven catalog selection, validation,
//              reporting, path diagnostics, and the first printable
//              direct-contact orthogonal structural coupon.
// Role: Development and exploration entry point. Permanent printed constructs
//       belong in objects/ as self-contained saved-object recipes.
// Includes: Current public API, mutable catalogs, structural coupon geometry,
//           validation, reporting, and coupon-series reporting.
//////////////////////////////////////////////////////////////////////

include <grid_stack.scad>

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

include <paths/structural_coupon_paths.scad>
include <geometry/structural_strand.scad>
include <geometry/orthogonal_stack_coupon.scad>
include <lib/structural_coupon_validation.scad>
include <lib/structural_coupon_reporting.scad>
include <lib/coupon_reporting.scad>

project = named_record(PROJECTS, project_name_selected, "project");
process = named_record(PROCESS_PROFILES, project[PR_PROCESS], "process profile");
material = named_record(MATERIALS, process[PX_MATERIAL], "material");
nozzle = named_record(NOZZLES, process[PX_NOZZLE], "nozzle");
boundary = named_record(BOUNDARIES, project[PR_BOUNDARY], "boundary");
path_policy = named_record(PATH_POLICIES, project[PR_PATH_POLICY], "path policy");
pattern_set = named_record(PATTERN_SETS, project[PR_PATTERN_SET], "pattern set");
schedule = named_record(STACK_SCHEDULES, project[PR_SCHEDULE], "stack schedule");

validate_grid_stack(
    project, process, material, nozzle, boundary,
    path_policy, pattern_set, schedule
);

report_grid_stack(
    project, process, material, nozzle, boundary,
    path_policy, pattern_set, schedule, report_level
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

if (render_mode == "structural_coupon") {
    assert(project[PR_NAME] == "COUPON_3X3_SPAN6_GAP0_DIRECT",
        "Structural coupon mode requires the direct-contact Batch 008 project.");
    assert(pattern_set[PS_NAME] == "SQUARE_COUPON",
        "Structural coupon mode supports the square coupon pattern only.");
    assert(len(schedule[SS_GROUPS]) == 2,
        "Structural coupon mode requires exactly two orientation groups.");

    lower_orientation = schedule[SS_GROUPS][0][SG_ORIENTATION];
    upper_orientation = schedule[SS_GROUPS][1][SG_ORIENTATION];
    lower_lead_in = path_policy[PP_LEAD_IN];

    lower_path = structural_coupon_path(
        boundary, process, nozzle, lower_orientation, lower_lead_in
    );
    upper_path = structural_coupon_path(
        boundary, process, nozzle, upper_orientation, 0
    );

    validate_direct_contact_stack_coupon(
        lower_points = lower_path,
        upper_points = upper_path,
        boundary = boundary,
        process = process,
        nozzle = nozzle,
        lower_orientation = lower_orientation,
        upper_orientation = upper_orientation,
        lower_lead_in = lower_lead_in,
        clear_vertical_gap = 0
    );

    report_direct_contact_stack_coupon(
        lower_path, upper_path, boundary, process, nozzle
    );

    printable_direct_contact_stack_coupon(
        lower_path, upper_path, process, nozzle
    );
}
else if (render_mode == "path_preview") {
    assert(boundary_is_count_driven(boundary),
        "Current path preview requires a count-driven coupon project.");
    assert(pattern_set[PS_NAME] == "SQUARE_COUPON",
        "Current path preview supports the square coupon pattern only.");

    generated_path = rectangular_serpentine_path(
        boundary, process, nozzle, path_policy, path_orientation
    );

    validate_rectangular_serpentine_path(
        generated_path, boundary, process, nozzle,
        path_policy, path_orientation
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
