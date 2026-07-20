//////////////////////////////////////////////////////////////////////
// LibFile: defaults.scad
// Project: Grid Stack
// FileGroup: User Interface
// FileSummary: OpenSCAD Customizer selections for project, path diagnostic,
//              coupon-series reporting, and console detail.
// Role: Contains only user-facing selectors; engineering records live in
//       the other configuration files.
// Exports: Project, render, path-preview, coupon, and report selectors.
//////////////////////////////////////////////////////////////////////

/* [Project selection] */
project_name_selected = "COUPON_3X3_SPAN6_GAP0_DIRECT"; // [COUPON_3X3_SPAN6_GAP0_DIRECT,COUPON_3X3_SPAN5_GAP1,TUTORIAL_RECT_45654]

/* [Render mode] */
render_mode = "structural_coupon"; // [structural_coupon,path_preview,report_only]

/* [Path diagnostic] */
path_orientation = 0; // [0:X-running,90:Y-running]
show_boundary_envelope = true;
show_path_point_numbers = true;

/* [Coupon series] */
report_coupon_series_enabled = false;
coupon_series_name_selected = "PLA_PLUS_BRIDGE_GAP_3X3"; // [PLA_PLUS_BRIDGE_GAP_3X3]

/* [Console report] */
report_level = "full"; // [summary,full]
