//////////////////////////////////////////////////////////////////////
// LibFile: main.scad
// Project: Grid Stack
// FileGroup: Entry Point
// FileSummary: Orchestrates environment lookup, validation, reporting, first
//              continuous coupon-path generation, and diagnostic rendering.
// Role: Selects records and delegates work; generation logic remains in paths/.
// Includes: Data model, math, configuration, path, validation, and preview.
//////////////////////////////////////////////////////////////////////

include <lib/indices.scad>
include <lib/schema.scad>
include <lib/lookup.scad>
include <lib/process_math.scad>
include <lib/list_math.scad>
include <lib/boundary_math.scad>
include <lib/pattern_math.scad>
include <lib/stack_math.scad>
include <lib/path_math.scad>

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

include <paths/rectangular_serpentine.scad>
include <geometry/path_preview.scad>
include <lib/validation.scad>
include <lib/path_validation.scad>
include <lib/reporting.scad>
include <lib/coupon_reporting.scad>
include <lib/path_reporting.scad>

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

if (render_mode == "path_preview") {
    assert(boundary_is_count_driven(boundary),
        "Batch 004 path preview requires a count-driven coupon project.");
    assert(pattern_set[PS_NAME] == "SQUARE_COUPON",
        "Batch 004 path preview supports the square coupon pattern only.");

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
    echo("Batch 004 report-only mode: no geometry generated.");
}
else {
    assert(false, str("Unknown render mode: ", render_mode));
}
