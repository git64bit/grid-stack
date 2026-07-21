//////////////////////////////////////////////////////////////////////
// LibFile: api_v3_coupon_contract.scad
// Project: Grid Stack
// FileGroup: Contract Test
// FileSummary: Exercises immutable API version 3 without mutable catalogs.
// Role: Verifies API constants, embedded records, positive-gap path alignment,
//       and derived dimensions for one representative recipe.
// Requires: Grid Stack API version 3 only.
// Output: Console assertions and report-only validation.
//////////////////////////////////////////////////////////////////////

include <../api/grid_stack_v3.scad>

material = material_spec("PLA_PLUS", "PLA+", "rigid");
nozzle = nozzle_spec("BRASS_0P4", 0.4);
printer = printer_spec("UNRECORDED_PRINTER_R1");
process = structural_process_profile(
    "PLA_PLUS_0P4_LH0P2_W2_H2_R1",
    "PLA_PLUS", "BRASS_0P4", "UNRECORDED_PRINTER_R1",
    0.2, 2, 2, 6, "owner_tested_to_6mm", 1
);
boundary = count_boundary("COUNT_3X3_SPAN8", 3, 3, 8, 8);
object = structural_coupon_object(
    "COUPON_3X3_SPAN8_GAP3_TEST", 1, 3, 1,
    "1.0.0", "4b5e564", material, nozzle, printer, process,
    boundary, 3, 30, "witness_riser_bridge", "contract_test"
);

assert(GRID_STACK_API_VERSION == 3);
assert(GRID_STACK_COUPON_SCHEMA_VERSION == 1);
assert(GRID_STACK_RECTANGULAR_FRAMEWORK_VERSION == 2);
assert(nearly_equal3(boundary_size_x3(boundary, process, nozzle), 27.2));
assert(nearly_equal3(gap_layer_count3(object), 15));
assert(nearly_equal3(coupon_total_height3(object), 3.8));

structural_coupon_render(object, mode = "report_only", report_level = "full");

echo("GRID STACK API V3 COUPON CONTRACT: PASS");
