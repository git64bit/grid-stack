//////////////////////////////////////////////////////////////////////
// LibFile: printed_first_layer_v2_contract.scad
// Project: Grid Stack
// FileGroup: Contract Test
// FileSummary: Minimal API v2 primitive-trace object and validation contract.
// Role: Confirms that trace-process records do not require structural pass or
//       bridge fields and that the accepted variable trace sequence remains
//       one continuous square-turn path.
// Requires: Grid Stack API version 2.
// Output: Console validation only.
//////////////////////////////////////////////////////////////////////

include <../api/grid_stack_v2.scad>

assert(GRID_STACK_API_VERSION == 2);
assert(GRID_STACK_FIRST_LAYER_SCHEMA_VERSION == 2);

_test_material = material_spec(
    "PLA_PLUS", "PLA+", "rigid", "in_use", "contract test"
);
_test_nozzle = nozzle_spec(
    "BRASS_0P4", 0.4, "brass", "in_use", "contract test"
);
_test_printer = printer_spec(
    "TEST_PRINTER", "Test", "Test", "cartesian", "plate",
    "recorded", "contract test"
);
_test_process = trace_process_profile(
    "TEST_TRACE", "PLA_PLUS", "BRASS_0P4", "TEST_PRINTER",
    0.2, "owner_tested", 1, "contract test"
);
_test_traces = [
    [-10, 10,  0],
    [ -8, 10,  5],
    [ -8,  3, 15],
    [ -6,  3, 16],
    [ -6,  9, 18]
];
_test_object = first_layer_object(
    "API_V2_CONTRACT", 1, 2, 2, "0.7.0", "79f36da",
    _test_material, _test_nozzle, _test_printer, _test_process,
    _test_traces, 0, 30, "calibration", "contract test"
);

validate_first_layer_object(_test_object);

echo("GRID STACK API V2 CONTRACT TEST: PASS");
