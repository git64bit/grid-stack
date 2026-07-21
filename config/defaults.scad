//////////////////////////////////////////////////////////////////////
// LibFile: defaults.scad
// Project: Grid Stack
// FileGroup: User Interface
// FileSummary: Customizer selection for the accepted direct reference, all
//              twelve positive-gap coupons, diagnostics, and reporting.
// Role: Contains user-facing selectors only. Engineering records remain in
//       the configuration catalogs and immutable files under objects/.
// Exports: Project, render, path-preview, coupon-series, and report selectors.
//////////////////////////////////////////////////////////////////////

/* [Project selection] */
project_name_selected = "COUPON_3X3_SPAN6_GAP1"; // [COUPON_3X3_SPAN6_GAP0_DIRECT,COUPON_3X3_SPAN5_GAP1,COUPON_3X3_SPAN5_GAP2,COUPON_3X3_SPAN5_GAP3,COUPON_3X3_SPAN6_GAP1,COUPON_3X3_SPAN6_GAP2,COUPON_3X3_SPAN6_GAP3,COUPON_3X3_SPAN7_GAP1,COUPON_3X3_SPAN7_GAP2,COUPON_3X3_SPAN7_GAP3,COUPON_3X3_SPAN8_GAP1,COUPON_3X3_SPAN8_GAP2,COUPON_3X3_SPAN8_GAP3,TUTORIAL_RECT_45654]

/* [Render mode] */
render_mode = "structural_coupon"; // [structural_coupon,path_preview,report_only]

/* [Path diagnostic] */
path_orientation = 0; // [0:X-running,90:Y-running]
show_boundary_envelope = true;
show_path_point_numbers = true;

/* [Coupon series] */
report_coupon_series_enabled = false;
coupon_series_name_selected = "PLA_PLUS_BRIDGE_GAP_3X3"; // [PLA_PLUS_BRIDGE_GAP_3X3]

/* [Framework audit] */
report_deferred_features_enabled = false;

/* [Console report] */
report_level = "full"; // [summary,full]
