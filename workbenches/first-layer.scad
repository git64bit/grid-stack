//////////////////////////////////////////////////////////////////////
// LibFile: first-layer.scad
// Project: Grid Stack
// FileGroup: Executable Workbench
// FileSummary: Variable parallel-trace first-layer generator.
// Role: Saves calibration sheets and sacrificial underlays as named presets.
//////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////
// GRID STACK FIRST-LAYER CONTRACT
// - Exactly one deposited layer and one continuous open path.
// - Parallel traces with independently configured lengths and offsets.
// - Perpendicular square connectors and square terminations.
// - No lift, idle travel, or disconnected geometry.
//////////////////////////////////////////////////////////////////////

/* [First-layer project] */
project_name_selected = "FIRST_LAYER_TRACE_LAB"; // [FIRST_LAYER_TRACE_LAB]

/* [Output] */
render_mode = "trace_layer"; // [trace_layer,path_debug,report_only]
show_path_point_numbers = true;

/* [Qualified print environment] */
process_profile_name_selected = "PLA_PLUS_0P4_LH0P2_W2_H2_R1"; // [PLA_PLUS_0P4_LH0P2_W2_H2_R1]

/* [Path orientation] */
trace_orientation = 0; // [0:X-running,90:Y-running]
first_layer_lead_in = 30;

/* [Parallel trace sequence] */
// Each record is [axis_min, axis_max, perpendicular_position].
trace_count = 5;
trace_01 = [-10, 10, 0];
trace_02 = [-8, 10, 5];
trace_03 = [-8, 3, 15];
trace_04 = [-6, 3, 16];
trace_05 = [-6, 9, 18];
trace_06 = [2, 9, 21];
trace_07 = [2, 12, 25];
trace_08 = [-4, 12, 30];
trace_09 = [-4, 8, 32];
trace_10 = [0, 8, 40];
trace_11 = [0, 6, 41];
trace_12 = [-3, 6, 44];

/* [Console report] */
report_level = "full"; // [summary,full]

/* [Hidden] */
workbench_name = "first-layer";
include <../main.scad>
