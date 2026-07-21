//////////////////////////////////////////////////////////////////////
// LibFile: workbench_registry_contract.scad
// Project: Grid Stack
// FileGroup: Contract Test
// FileSummary: Verifies project-family isolation and workbench routing.
//////////////////////////////////////////////////////////////////////

include <../grid_stack.scad>
include <../lib/coupon_framework.scad>
include <../config/materials.scad>
include <../config/nozzles.scad>
include <../config/process_profiles.scad>
include <../config/boundaries.scad>
include <../config/path_policies.scad>
include <../config/patterns.scad>
include <../config/schedules.scad>
include <../config/coupons.scad>
include <../registries/coupon_projects.scad>
include <../registries/catalog_projects.scad>
include <../registries/laboratory_projects.scad>
include <../config/workbenches.scad>

assert(len(COUPON_PROJECTS) == 13,
    "Coupon workbench must contain the direct reference plus twelve cases.");
assert(len(CATALOG_PROJECTS) == 1,
    "Catalog workbench currently requires exactly one explicit stub.");
assert(len(LABORATORY_PROJECTS) == 1,
    "Laboratory workbench currently requires exactly one deferred project.");

assert(len(records_named(COUPON_PROJECTS, "CATALOG_WORKBENCH_STUB")) == 0,
    "Catalog projects must not leak into the coupon registry.");
assert(len(records_named(COUPON_PROJECTS, "TUTORIAL_RECT_45654")) == 0,
    "Laboratory projects must not leak into the coupon registry.");
assert(len(records_named(CATALOG_PROJECTS, "COUPON_3X3_SPAN6_GAP1")) == 0,
    "Coupon projects must not leak into the catalog registry.");

assert(workbench_render_mode_allowed("coupons", "structural_coupon"),
    "Coupon workbench must permit printable coupon rendering.");
assert(!workbench_render_mode_allowed("catalog", "structural_coupon"),
    "Catalog stub must not expose coupon rendering.");
assert(workbench_render_mode_allowed("laboratory", "report_only"),
    "Laboratory stub must remain safely reportable.");

echo("GRID STACK WORKBENCH REGISTRY CONTRACT: PASS");
