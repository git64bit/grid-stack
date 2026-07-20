//////////////////////////////////////////////////////////////////////
// LibFile: main.scad
// Project: Grid Stack
// FileGroup: Entry Point
// FileSummary: Orchestrates selection, lookup, validation, project reporting,
//              and coupon-series reporting.
// Role: Resolves exact records while Batch 003 still intentionally generates
//       no geometry.
// Includes: Data model, math, configuration catalogs, validation, reporting.
//////////////////////////////////////////////////////////////////////

include <lib/indices.scad>
include <lib/schema.scad>
include <lib/lookup.scad>
include <lib/process_math.scad>
include <lib/list_math.scad>
include <lib/boundary_math.scad>
include <lib/pattern_math.scad>
include <lib/stack_math.scad>

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

include <lib/validation.scad>
include <lib/reporting.scad>
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
