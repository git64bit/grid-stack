//////////////////////////////////////////////////////////////////////
// LibFile: defaults.scad
// Project: Grid Stack
// FileGroup: Workbench Configuration
// FileSummary: Resolves wrapper inputs into internal workbench values.
// Role: Provides fallback values when main.scad is opened directly and accepts
//       values supplied by a specialized workbench, generated wrapper, or -D.
// Exports: wb_* values consumed only by main.scad.
//////////////////////////////////////////////////////////////////////

wb_workbench_name = is_undef(workbench_name)
    ? "development"
    : workbench_name;

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

// Laboratory grid-panel wrapper inputs. These remain inactive outside the
// laboratory workbench but allow generated wrappers and -D calls to use the
// same parameter contract.
wb_lab_cells_x = is_undef(lab_cells_x) ? 9 : lab_cells_x;
wb_lab_cells_y = is_undef(lab_cells_y) ? 9 : lab_cells_y;
wb_lab_clear_span_x = is_undef(lab_clear_span_x) ? 6 : lab_clear_span_x;
wb_lab_clear_span_y = is_undef(lab_clear_span_y) ? 6 : lab_clear_span_y;
wb_lab_lead_in = is_undef(lab_lead_in) ? 30 : lab_lead_in;
wb_lab_deposited_layer_count = is_undef(lab_deposited_layer_count)
    ? 8
    : lab_deposited_layer_count;
wb_lab_first_layer_orientation = is_undef(lab_first_layer_orientation)
    ? "X"
    : lab_first_layer_orientation;
