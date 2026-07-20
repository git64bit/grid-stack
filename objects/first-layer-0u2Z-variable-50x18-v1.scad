//////////////////////////////////////////////////////////////////////
// LibFile: first-layer-0u2Z-variable-50x18-v1.scad
// Project: Grid Stack
// FileGroup: Saved Object Recipe
// FileSummary: Permanent PLA+ first-layer recipe with five parallel traces,
//              independently configured lengths, and 5/10/1/2 mm repeats.
// Role: Demonstrates a path that is parallel and square-terminated without
//       being equally spaced, equal length, balanced, or symmetrical.
// Requires: Grid Stack API version 1 and first-layer schema version 1.
// Output: One printable 0.4 mm wide by 0.2 mm high continuous trace layer.
//////////////////////////////////////////////////////////////////////

include <../api/grid_stack_v1.scad>

assert(GRID_STACK_API_VERSION == 1,
    "This recipe requires Grid Stack API version 1.");
assert(GRID_STACK_FIRST_LAYER_SCHEMA_VERSION == 1,
    "This recipe requires Grid Stack first-layer schema version 1.");

saved_material = material_spec(
    name = "PLA_PLUS",
    family = "PLA+",
    flexibility = "rigid",
    status = "in_use",
    notes = "Exact material family used by this saved object."
);

saved_nozzle = nozzle_spec(
    name = "BRASS_0P4",
    diameter = 0.4,
    construction = "brass",
    status = "in_use",
    notes = "Exact nozzle hardware used by this saved object."
);

saved_process = process_profile(
    name = "PLA_PLUS_0P4_LH0P2_W2_H2_R1",
    material_name = "PLA_PLUS",
    nozzle_name = "BRASS_0P4",
    layer_height = 0.2,
    width_passes = 2,
    height_passes = 2,
    bridge_max = 6.0,
    qualification = "owner_tested",
    revision = 1,
    notes = "This object intentionally uses one primitive trace, not the composed strand."
);

saved_traces = [
    [-10, 10,  0],
    [ -8, 10,  5],
    [ -8,  3, 15],
    [ -6,  3, 16],
    [ -6,  9, 18]
];

saved_first_layer = first_layer_object(
    name = "FIRST_LAYER_0U2Z_VARIABLE_50X18_V1",
    revision = 1,
    required_api_version = 1,
    first_layer_schema_version = 1,
    source_release = "0.6.0",
    material = saved_material,
    nozzle = saved_nozzle,
    process = saved_process,
    traces = saved_traces,
    orientation = 0,
    lead_in = 30,
    status = "calibration",
    notes = "Create V2 rather than editing this recipe after printing."
);

first_layer_render(
    saved_first_layer,
    mode = "trace_layer",
    report_level = "full",
    show_path_point_numbers = false
);
