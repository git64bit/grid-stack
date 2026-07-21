//////////////////////////////////////////////////////////////////////
// LibFile: workbench_registry_contract.scad
// Project: Grid Stack
// FileGroup: Contract Test
// FileSummary: Verifies preset-native project-family isolation.
//////////////////////////////////////////////////////////////////////

include <../grid_stack.scad>
include <../config/core_contract.scad>
include <../config/defaults.scad>
include <../config/materials.scad>
include <../config/nozzles.scad>
include <../config/process_profiles.scad>
include <../registries/configurable_grid_projects.scad>
include <../registries/coupon_projects.scad>
include <../registries/catalog_projects.scad>
include <../registries/laboratory_projects.scad>
include <../registries/first_layer_projects.scad>
include <../config/workbenches.scad>

assert(len(COUPON_PROJECTS) == 1);
assert(COUPON_PROJECTS[0][PR_NAME] == "GRID_COUPON");
assert(len(CATALOG_PROJECTS) == 1);
assert(len(LABORATORY_PRINTABLE_PROJECTS) == 1);
assert(len(LABORATORY_DEFERRED_PROJECTS) == 1);
assert(len(FIRST_LAYER_PROJECTS) == 1);

assert(len(records_named(COUPON_PROJECTS, "GRID_PANEL_LAB")) == 0);
assert(len(records_named(CATALOG_PROJECTS, "GRID_COUPON")) == 0);
assert(len(records_named(FIRST_LAYER_PROJECTS, "GRID_COUPON")) == 0);

assert(workbench_render_mode_allowed("coupons", "structural_grid"));
assert(workbench_render_mode_allowed("laboratory", "structural_grid"));
assert(workbench_render_mode_allowed("first-layer", "trace_layer"));
assert(!workbench_render_mode_allowed("catalog", "structural_grid"));
assert(GRID_STACK_CORE_CONTRACT_VERSION == 2);

echo("GRID STACK WORKBENCH REGISTRY CONTRACT: PASS");
