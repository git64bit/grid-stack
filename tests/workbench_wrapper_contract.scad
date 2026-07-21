//////////////////////////////////////////////////////////////////////
// LibFile: workbench_wrapper_contract.scad
// Project: Grid Stack
// FileGroup: Contract Test
// FileSummary: Verifies wrapper fallback resolution and workbench identity.
//////////////////////////////////////////////////////////////////////

include <../config/defaults.scad>

assert(wb_workbench_name == "development",
    "Direct main.scad fallback must use the development workbench.");
assert(wb_project_name == "COUPON_3X3_SPAN6_GAP1",
    "Default project fallback changed unexpectedly.");
assert(wb_render_mode == "structural_coupon",
    "Default render-mode fallback changed unexpectedly.");
assert(wb_path_orientation == 0,
    "Default path orientation changed unexpectedly.");
assert(wb_report_level == "full",
    "Default report level changed unexpectedly.");

echo("GRID STACK WORKBENCH WRAPPER CONTRACT: PASS");
