//////////////////////////////////////////////////////////////////////
// LibFile: workbench_registry_contract.scad
// Project: Grid Stack
// FileGroup: Contract Test
// FileSummary: Verifies project-family isolation and workbench routing.
//////////////////////////////////////////////////////////////////////

include <../grid_stack.scad>
include <../lib/coupon_framework.scad>
include <../config/core_contract.scad>
include <../config/defaults.scad>
include <../config/materials.scad>
include <../config/nozzles.scad>
include <../config/process_profiles.scad>
include <../registries/laboratory_projects.scad>
include <../config/boundaries.scad>
include <../config/path_policies.scad>
include <../config/patterns.scad>
include <../config/schedules.scad>
include <../config/coupons.scad>
include <../registries/coupon_projects.scad>
include <../registries/catalog_projects.scad>
include <../config/workbenches.scad>

assert(len(COUPON_PROJECTS) == 13,
    "Coupon workbench must contain the direct reference plus twelve cases.");
assert(len(CATALOG_PROJECTS) == 1,
    "Catalog workbench currently requires exactly one explicit stub.");
assert(len(LABORATORY_PRINTABLE_PROJECTS) == 1,
    "Laboratory must contain one printable grid-panel experiment.");
assert(len(LABORATORY_DEFERRED_PROJECTS) == 1,
    "Laboratory must retain one explicit deferred project.");
assert(len(LABORATORY_PROJECTS) == 2,
    "Laboratory registry must combine printable and deferred projects.");

assert(len(records_named(COUPON_PROJECTS, "CATALOG_WORKBENCH_STUB")) == 0,
    "Catalog projects must not leak into the coupon registry.");
assert(len(records_named(COUPON_PROJECTS, "GRID_PANEL_LAB")) == 0,
    "Laboratory projects must not leak into the coupon registry.");
assert(len(records_named(CATALOG_PROJECTS, "COUPON_3X3_SPAN6_GAP1")) == 0,
    "Coupon projects must not leak into the catalog registry.");
assert(len(records_named(CATALOG_PROJECTS, "GRID_PANEL_LAB")) == 0,
    "Laboratory projects must not leak into the catalog registry.");

assert(workbench_render_mode_allowed("coupons", "structural_coupon"),
    "Coupon workbench must permit printable coupon rendering.");
assert(workbench_render_mode_allowed("laboratory", "structural_grid"),
    "Laboratory workbench must permit printable grid rendering.");
assert(workbench_render_mode_allowed("laboratory", "path_preview"),
    "Laboratory workbench must permit path diagnostics.");
assert(!workbench_render_mode_allowed("catalog", "structural_grid"),
    "Catalog stub must not expose unaccepted laboratory geometry.");

assert(GRID_STACK_CORE_CONTRACT_VERSION == 1,
    "Unexpected Grid Stack core-contract version.");

echo("GRID STACK WORKBENCH REGISTRY CONTRACT: PASS");
