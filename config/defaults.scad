//////////////////////////////////////////////////////////////////////
// LibFile: defaults.scad
// Project: Grid Stack
// FileGroup: User Interface
// FileSummary: OpenSCAD Customizer selections for project and coupon reports.
// Role: Contains only user-facing selectors; engineering records live in
//       the other configuration files.
// Exports: project_name_selected, coupon_series_name_selected,
//          report_coupon_series_enabled, report_level
//////////////////////////////////////////////////////////////////////

/* [Project selection] */
project_name_selected = "TUTORIAL_RECT_45654"; // [TUTORIAL_RECT_45654,COUPON_3X3_SPAN5_GAP1]

/* [Coupon series] */
report_coupon_series_enabled = true;
coupon_series_name_selected = "PLA_PLUS_BRIDGE_GAP_3X3"; // [PLA_PLUS_BRIDGE_GAP_3X3]

/* [Console report] */
report_level = "full"; // [summary,full]
