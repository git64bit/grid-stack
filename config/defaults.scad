//////////////////////////////////////////////////////////////////////
// LibFile: defaults.scad
// Project: Grid Stack
// FileGroup: Workbench Configuration
// FileSummary: Resolves specialized wrapper inputs into internal values.
// Role: Preserves each workbench's Customizer parameter names while exposing
//       one shared internal contract to main.scad.
//////////////////////////////////////////////////////////////////////

wb_workbench_name = is_undef(workbench_name) ? "development" : workbench_name;
wb_project_name = is_undef(project_name_selected)
    ? "GRID_PANEL_LAB"
    : project_name_selected;
wb_render_mode = is_undef(render_mode) ? "structural_grid" : render_mode;
wb_show_boundary_envelope = is_undef(show_boundary_envelope)
    ? true : show_boundary_envelope;
wb_show_path_point_numbers = is_undef(show_path_point_numbers)
    ? true : show_path_point_numbers;
wb_report_deferred_features = is_undef(report_deferred_features_enabled)
    ? false : report_deferred_features_enabled;
wb_report_level = is_undef(report_level) ? "full" : report_level;

// Coupon wrapper values. No arbitrary Customizer limits are imposed here.
wb_coupon_cells_x = is_undef(coupon_cells_x) ? 3 : coupon_cells_x;
wb_coupon_cells_y = is_undef(coupon_cells_y) ? 3 : coupon_cells_y;
wb_coupon_clear_span_x = is_undef(coupon_clear_span_x) ? 6 : coupon_clear_span_x;
wb_coupon_clear_span_y = is_undef(coupon_clear_span_y) ? 6 : coupon_clear_span_y;
wb_coupon_lead_in = is_undef(coupon_lead_in) ? 30 : coupon_lead_in;
wb_coupon_deposited_layer_height = is_undef(coupon_deposited_layer_height)
    ? 0.2 : coupon_deposited_layer_height;
wb_coupon_deposited_layer_count = is_undef(coupon_deposited_layer_count)
    ? 2 : coupon_deposited_layer_count;
wb_coupon_first_layer_orientation = is_undef(coupon_first_layer_orientation)
    ? "X" : coupon_first_layer_orientation;

// Laboratory wrapper values. Names remain stable for existing JSON presets.
wb_lab_cells_x = is_undef(lab_cells_x) ? 9 : lab_cells_x;
wb_lab_cells_y = is_undef(lab_cells_y) ? 9 : lab_cells_y;
wb_lab_clear_span_x = is_undef(lab_clear_span_x) ? 6 : lab_clear_span_x;
wb_lab_clear_span_y = is_undef(lab_clear_span_y) ? 6 : lab_clear_span_y;
wb_lab_lead_in = is_undef(lab_lead_in) ? 30 : lab_lead_in;
wb_lab_deposited_layer_height = is_undef(lab_deposited_layer_height)
    ? 0.2 : lab_deposited_layer_height;
wb_lab_deposited_layer_count = is_undef(lab_deposited_layer_count)
    ? 8 : lab_deposited_layer_count;
wb_lab_first_layer_orientation = is_undef(lab_first_layer_orientation)
    ? "X" : lab_first_layer_orientation;

// The Coupon and Laboratory workbenches share one fixed geometry engine.
wb_grid_cells_x = wb_workbench_name == "coupons"
    ? wb_coupon_cells_x : wb_lab_cells_x;
wb_grid_cells_y = wb_workbench_name == "coupons"
    ? wb_coupon_cells_y : wb_lab_cells_y;
wb_grid_clear_span_x = wb_workbench_name == "coupons"
    ? wb_coupon_clear_span_x : wb_lab_clear_span_x;
wb_grid_clear_span_y = wb_workbench_name == "coupons"
    ? wb_coupon_clear_span_y : wb_lab_clear_span_y;
wb_grid_lead_in = wb_workbench_name == "coupons"
    ? wb_coupon_lead_in : wb_lab_lead_in;
wb_grid_deposited_layer_height = wb_workbench_name == "coupons"
    ? wb_coupon_deposited_layer_height : wb_lab_deposited_layer_height;
wb_grid_deposited_layer_count = wb_workbench_name == "coupons"
    ? wb_coupon_deposited_layer_count : wb_lab_deposited_layer_count;
wb_grid_first_layer_orientation = wb_workbench_name == "coupons"
    ? wb_coupon_first_layer_orientation : wb_lab_first_layer_orientation;

// Variable parallel-trace first-layer workbench values.
wb_first_layer_process_profile_name = is_undef(process_profile_name_selected)
    ? "PLA_PLUS_0P4_LH0P2_W2_H2_R1"
    : process_profile_name_selected;
wb_first_layer_trace_orientation = is_undef(trace_orientation)
    ? 0 : trace_orientation;
wb_first_layer_lead_in = is_undef(first_layer_lead_in)
    ? 30 : first_layer_lead_in;
wb_first_layer_trace_count = is_undef(trace_count) ? 5 : trace_count;

wb_trace_01 = is_undef(trace_01) ? [-10, 10, 0] : trace_01;
wb_trace_02 = is_undef(trace_02) ? [-8, 10, 5] : trace_02;
wb_trace_03 = is_undef(trace_03) ? [-8, 3, 15] : trace_03;
wb_trace_04 = is_undef(trace_04) ? [-6, 3, 16] : trace_04;
wb_trace_05 = is_undef(trace_05) ? [-6, 9, 18] : trace_05;
wb_trace_06 = is_undef(trace_06) ? [2, 9, 21] : trace_06;
wb_trace_07 = is_undef(trace_07) ? [2, 12, 25] : trace_07;
wb_trace_08 = is_undef(trace_08) ? [-4, 12, 30] : trace_08;
wb_trace_09 = is_undef(trace_09) ? [-4, 8, 32] : trace_09;
wb_trace_10 = is_undef(trace_10) ? [0, 8, 40] : trace_10;
wb_trace_11 = is_undef(trace_11) ? [0, 6, 41] : trace_11;
wb_trace_12 = is_undef(trace_12) ? [-3, 6, 44] : trace_12;

wb_first_layer_trace_catalog = [
    wb_trace_01, wb_trace_02, wb_trace_03, wb_trace_04,
    wb_trace_05, wb_trace_06, wb_trace_07, wb_trace_08,
    wb_trace_09, wb_trace_10, wb_trace_11, wb_trace_12
];
wb_first_layer_traces =
    assert(wb_first_layer_trace_count >= 1 &&
           wb_first_layer_trace_count <= len(wb_first_layer_trace_catalog),
        "First-layer trace count must be between 1 and the available record count.")
    [for (i = [0 : wb_first_layer_trace_count - 1])
        wb_first_layer_trace_catalog[i]];
