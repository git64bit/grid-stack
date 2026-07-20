//////////////////////////////////////////////////////////////////////
// LibFile: first-layer-0u2Z-variable-50x18-pla-plus-0p4-v1.scad
// Project: Grid Stack
// FileGroup: Immutable Printed Object
// FileSummary: Exact PLA+ 0.4 mm nozzle, 0.2 mm layer recipe for the accepted
//              five-trace variable first-layer calibration/underlay object.
// Role: Permanently reconstructs the reported successful PLA+ print without
//       Customizer state or mutable catalog lookup.
// SourceCommit: 79f36da
// Requires: Grid Stack API version 2 and first-layer schema version 2.
// Output: One continuous 0.4 mm wide by 0.2 mm high trace layer.
//////////////////////////////////////////////////////////////////////

include <../../api/grid_stack_v2.scad>

assert(GRID_STACK_API_VERSION == 2,
    "This recipe requires Grid Stack API version 2.");
assert(GRID_STACK_FIRST_LAYER_SCHEMA_VERSION == 2,
    "This recipe requires first-layer schema version 2.");

saved_material = material_spec(
    name = "PLA_PLUS",
    family = "PLA+",
    flexibility = "rigid",
    status = "in_use",
    notes = "Material family reported successful for this first-layer object."
);

saved_nozzle = nozzle_spec(
    name = "BRASS_0P4",
    diameter = 0.4,
    construction = "brass",
    status = "in_use",
    notes = "Exact nominal nozzle diameter used by the geometry recipe."
);

saved_printer = printer_spec(
    name = "UNRECORDED_PRINTER_R1",
    manufacturer = "",
    model = "",
    motion_system = "",
    build_surface = "",
    status = "unrecorded",
    notes = "The successful printer hardware was not identified when this recipe was promoted."
);

saved_process = trace_process_profile(
    name = "PLA_PLUS_0P4_LH0P2_TRACE_R1",
    material_name = "PLA_PLUS",
    nozzle_name = "BRASS_0P4",
    printer_name = "UNRECORDED_PRINTER_R1",
    layer_height = 0.2,
    qualification = "owner_tested",
    revision = 1,
    notes = "Primitive trace process only; no structural-strand or bridge claim."
);

saved_traces = [
    [-10, 10,  0],
    [ -8, 10,  5],
    [ -8,  3, 15],
    [ -6,  3, 16],
    [ -6,  9, 18]
];

saved_first_layer = first_layer_object(
    name = "FIRST_LAYER_0U2Z_VARIABLE_50X18_PLA_PLUS_0P4_V1",
    revision = 1,
    required_api_version = 2,
    first_layer_schema_version = 2,
    source_release = "0.7.0",
    source_commit = "79f36da",
    material = saved_material,
    nozzle = saved_nozzle,
    printer = saved_printer,
    process = saved_process,
    traces = saved_traces,
    orientation = 0,
    lead_in = 30,
    status = "printed",
    notes = "Reported successful in PLA+. Create a new file and revision for any change."
);

first_layer_render(
    saved_first_layer,
    mode = "trace_layer",
    report_level = "full",
    show_path_point_numbers = false
);
