/*
    Grid Stack
    Batch 001: specification and data model

    This file orchestrates the project. It intentionally produces no geometry.
    Open the OpenSCAD Console after F5 to inspect validation and the active
    project report.
*/

include <lib/indices.scad>
include <lib/schema.scad>
include <lib/lookup.scad>
include <lib/list_math.scad>

include <config/defaults.scad>
include <config/materials.scad>
include <config/boundaries.scad>
include <config/path_policies.scad>
include <config/patterns.scad>
include <config/schedules.scad>
include <config/projects.scad>

include <lib/validation.scad>
include <lib/reporting.scad>

project = named_record(PROJECTS, project_name_selected, "project");
material = named_record(MATERIAL_PROFILES, project[PR_MATERIAL], "material");
boundary = named_record(BOUNDARIES, project[PR_BOUNDARY], "boundary");
path_policy = named_record(PATH_POLICIES, project[PR_PATH_POLICY], "path policy");
pattern_set = named_record(PATTERN_SETS, project[PR_PATTERN_SET], "pattern set");
schedule = named_record(LAYER_SCHEDULES, project[PR_SCHEDULE], "layer schedule");

validate_grid_stack(
    project,
    material,
    boundary,
    path_policy,
    pattern_set,
    schedule
);

report_grid_stack(
    project,
    material,
    boundary,
    path_policy,
    pattern_set,
    schedule,
    report_level
);
