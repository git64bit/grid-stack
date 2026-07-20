//////////////////////////////////////////////////////////////////////
// LibFile: first-layer-0u2Z-anyXY.scad
// Project: Grid Stack
// FileGroup: Development Entry Point
// FileSummary: Customizer-driven generator for one 0.2 mm deposited layer
//              composed from configurable parallel traces with variable
//              lengths and variable repeat distances.
// Role: Develops first-layer calibration sheets and sacrificial underlays.
//       Permanent printed configurations belong in objects/ as saved recipes.
// Requires: Grid Stack API version 1 and mutable environment catalogs.
// Output: Printable single-trace layer, numbered path diagnostic, or report.
//////////////////////////////////////////////////////////////////////

/* [Output] */
render_mode = "trace_layer"; // [trace_layer,path_debug,report_only]
show_path_point_numbers = true;

/* [Qualified print environment] */
process_profile_name_selected = "PLA_PLUS_0P4_LH0P2_W2_H2_R1"; // [PLA_PLUS_0P4_LH0P2_W2_H2_R1]

/* [Path orientation] */
trace_orientation = 0; // [0:X-running,90:Y-running]
lead_in = 30; // [0:1:100]

/* [Parallel trace sequence] */
// Each record is [axis_min, axis_max, perpendicular_position].
// Even traces travel min-to-max; odd traces travel max-to-min.
// Adjacent records share the alternating endpoint used by the square turn.
// Lengths and offset differences are intentionally independent.
trace_count = 5; // [1:1:12]
trace_01 = [-10, 10,  0];
trace_02 = [ -8, 10,  5];
trace_03 = [ -8,  3, 15];
trace_04 = [ -6,  3, 16];
trace_05 = [ -6,  9, 18];
trace_06 = [  2,  9, 21];
trace_07 = [  2, 12, 25];
trace_08 = [ -4, 12, 30];
trace_09 = [ -4,  8, 32];
trace_10 = [  0,  8, 40];
trace_11 = [  0,  6, 41];
trace_12 = [ -3,  6, 44];

/* [Console report] */
report_level = "full"; // [summary,full]

/* [Hidden] */
include <grid_stack.scad>
include <config/materials.scad>
include <config/nozzles.scad>
include <config/process_profiles.scad>

trace_catalog = [
    trace_01, trace_02, trace_03, trace_04, trace_05, trace_06,
    trace_07, trace_08, trace_09, trace_10, trace_11, trace_12
];
traces = [for (i = [0 : trace_count - 1]) trace_catalog[i]];

selected_process = named_record(
    PROCESS_PROFILES,
    process_profile_name_selected,
    "process profile"
);
selected_material = named_record(
    MATERIALS,
    selected_process[PX_MATERIAL],
    "material"
);
selected_nozzle = named_record(
    NOZZLES,
    selected_process[PX_NOZZLE],
    "nozzle"
);

working_first_layer = first_layer_object(
    name = "FIRST_LAYER_0U2Z_ANYXY_WORKING",
    revision = 1,
    required_api_version = 1,
    first_layer_schema_version = 1,
    source_release = GRID_STACK_RELEASE,
    material = selected_material,
    nozzle = selected_nozzle,
    process = selected_process,
    traces = traces,
    orientation = trace_orientation,
    lead_in = lead_in,
    status = "draft",
    notes = "Development recipe; promote accepted settings into objects/."
);

first_layer_render(
    working_first_layer,
    mode = render_mode,
    report_level = report_level,
    show_path_point_numbers = show_path_point_numbers
);
