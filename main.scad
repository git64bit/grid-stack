//////////////////////////////////////////////////////////////////////
// LibFile: main.scad
// Project: Grid Stack
// FileGroup: Entry Point
// FileSummary: Orchestrates selection, lookup, validation, and reporting.
// Role: Resolves one exact printing environment and independent project
//       policies. Batch 002 intentionally produces no geometry.
// Includes: lib/, config/, validation, and reporting files listed below.
//////////////////////////////////////////////////////////////////////

include <lib/indices.scad>
include <lib/schema.scad>
include <lib/lookup.scad>
include <lib/process_math.scad>
include <lib/list_math.scad>

include <config/defaults.scad>
include <config/materials.scad>
include <config/nozzles.scad>
include <config/process_profiles.scad>
include <config/boundaries.scad>
include <config/path_policies.scad>
include <config/patterns.scad>
include <config/schedules.scad>
include <config/projects.scad>

include <lib/validation.scad>
include <lib/reporting.scad>

project = named_record(PROJECTS, project_name_selected, "project");
process = named_record(PROCESS_PROFILES, project[PR_PROCESS], "process profile");
material = named_record(MATERIALS, process[PX_MATERIAL], "material");
nozzle = named_record(NOZZLES, process[PX_NOZZLE], "nozzle");
boundary = named_record(BOUNDARIES, project[PR_BOUNDARY], "boundary");
path_policy = named_record(PATH_POLICIES, project[PR_PATH_POLICY], "path policy");
pattern_set = named_record(PATTERN_SETS, project[PR_PATTERN_SET], "pattern set");
schedule = named_record(LAYER_SCHEDULES, project[PR_SCHEDULE], "layer schedule");

validate_grid_stack(
    project, process, material, nozzle, boundary,
    path_policy, pattern_set, schedule
);

report_grid_stack(
    project, process, material, nozzle, boundary,
    path_policy, pattern_set, schedule, report_level
);
