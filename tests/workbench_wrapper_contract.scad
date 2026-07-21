//////////////////////////////////////////////////////////////////////
// LibFile: workbench_wrapper_contract.scad
// Project: Grid Stack
// FileGroup: Contract Test
// FileSummary: Proves that an executable wrapper can supply workbench inputs.
// Role: Mimics a future generated wrapper without modifying main.scad.
// Expected: Report-only validation completes for the selected project.
//////////////////////////////////////////////////////////////////////

project_name_selected = "COUPON_3X3_SPAN5_GAP2";
render_mode = "report_only";
path_orientation = 90;
show_boundary_envelope = false;
show_path_point_numbers = false;
report_coupon_series_enabled = false;
coupon_series_name_selected = "PLA_PLUS_BRIDGE_GAP_3X3";
report_deferred_features_enabled = false;
report_level = "summary";

include <../main.scad>
