//////////////////////////////////////////////////////////////////////
// LibFile: defaults.scad
// Project: Grid Stack
// FileGroup: Workbench Configuration
// FileSummary: Resolves wrapper inputs into internal workbench values.
// Role: Provides fallback values when main.scad is opened directly and accepts
//       values supplied by default.scad, another generated wrapper, or -D.
// Exports: wb_* values consumed only by main.scad.
//////////////////////////////////////////////////////////////////////

wb_project_name = is_undef(project_name_selected)
    ? "COUPON_3X3_SPAN6_GAP1"
    : project_name_selected;

wb_render_mode = is_undef(render_mode)
    ? "structural_coupon"
    : render_mode;

wb_path_orientation = is_undef(path_orientation)
    ? 0
    : path_orientation;

wb_show_boundary_envelope = is_undef(show_boundary_envelope)
    ? true
    : show_boundary_envelope;

wb_show_path_point_numbers = is_undef(show_path_point_numbers)
    ? true
    : show_path_point_numbers;

wb_report_coupon_series = is_undef(report_coupon_series_enabled)
    ? false
    : report_coupon_series_enabled;

wb_coupon_series_name = is_undef(coupon_series_name_selected)
    ? "PLA_PLUS_BRIDGE_GAP_3X3"
    : coupon_series_name_selected;

wb_report_deferred_features = is_undef(report_deferred_features_enabled)
    ? false
    : report_deferred_features_enabled;

wb_report_level = is_undef(report_level)
    ? "full"
    : report_level;
