//////////////////////////////////////////////////////////////////////
// LibFile: coupon-3x3-span8-gap3-pla-plus-0p4-v1.scad
// Project: Grid Stack
// FileGroup: Immutable Structural Coupon
// FileSummary: 3 x 3 PLA+ coupon with 8 mm clear XY spans and 3 mm
//              clear vertical gap using witness_riser_bridge geometry.
// Role: Permanently reconstructs one calibration object without Customizer
//       state or mutable workbench catalog lookup.
// FrameworkBaseCommit: 4b5e564
// Requires: Grid Stack API version 3 and coupon schema version 1.
// Output: Printable continuous-path structural coupon geometry.
//////////////////////////////////////////////////////////////////////

include <../../api/grid_stack_v3.scad>

assert(GRID_STACK_API_VERSION == 3,
    "This recipe requires Grid Stack API version 3.");
assert(GRID_STACK_COUPON_SCHEMA_VERSION == 1,
    "This recipe requires coupon schema version 1.");
assert(GRID_STACK_RECTANGULAR_FRAMEWORK_VERSION == 2,
    "This recipe requires rectangular framework version 2.");

saved_material = material_spec(
    name = "PLA_PLUS",
    family = "PLA+",
    flexibility = "rigid",
    status = "in_use",
    notes = "Exact material family selected for the coupon matrix."
);

saved_nozzle = nozzle_spec(
    name = "BRASS_0P4",
    diameter = 0.4,
    construction = "brass",
    status = "in_use",
    notes = "Nominal nozzle diameter used to derive the 0.8 mm strand width."
);

saved_printer = printer_spec(
    name = "UNRECORDED_PRINTER_R1",
    manufacturer = "",
    model = "",
    motion_system = "",
    build_surface = "",
    status = "unrecorded",
    notes = "Printer identity was not frozen with this coupon framework."
);

saved_process = structural_process_profile(
    name = "PLA_PLUS_0P4_LH0P2_W2_H2_R1",
    material_name = "PLA_PLUS",
    nozzle_name = "BRASS_0P4",
    printer_name = "UNRECORDED_PRINTER_R1",
    layer_height = 0.2,
    width_passes = 2,
    height_passes = 2,
    bridge_max = 6,
    qualification = "owner_tested_to_6mm",
    revision = 1,
    notes = "Primitive trace 0.4 x 0.2 mm; structural strand 0.8 x 0.4 mm."
);

saved_boundary = count_boundary(
    name = "COUNT_3X3_SPAN8",
    cells_x = 3,
    cells_y = 3,
    clear_span_x = 8,
    clear_span_y = 8,
    notes = "Outside dimensions derive from four strands and three clear openings."
);

saved_coupon = structural_coupon_object(
    name = "COUPON_3X3_SPAN8_GAP3_PLA_PLUS_0P4_V1",
    revision = 1,
    required_api_version = 3,
    coupon_schema_version = 1,
    source_release = "1.0.0",
    framework_base_commit = "4b5e564",
    material = saved_material,
    nozzle = saved_nozzle,
    printer = saved_printer,
    process = saved_process,
    boundary = saved_boundary,
    clear_vertical_gap = 3,
    lead_in = 30,
    support_strategy = "witness_riser_bridge",
    status = "calibration_unprinted",
    notes = "Calibration recipe generated from the frozen Batch 010 framework; record results in a new revision after printing."
);

structural_coupon_render(
    saved_coupon,
    mode = "print",
    report_level = "full"
);
