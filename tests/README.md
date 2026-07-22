# Tests

Open a contract test directly in OpenSCAD and press F5. Successful tests print a `PASS` line and generate no production geometry.

Retained contracts:

- `alternating_grid_stack_contract.scad` — alternating direct-contact layer geometry;
- `first_layer_workbench_contract.scad` — First Layer workbench routing and mutable object contract;
- `laboratory_grid_contract.scad` — configurable rectangular Laboratory contract;
- `laboratory_layer_height_contract.scad` — unrestricted positive deposited-layer height and direct-contact stacking;
- `parallel_trace_contract.scad` — variable parallel-trace path semantics;
- `rectangular_grid_standalone_contract.scad` — active grid-path generation without the legacy API v1 include chain;
- `printed_first_layer_v2_contract.scad` — immutable API version 2 first-layer recipes;
- `workbench_registry_contract.scad` — project registry separation;
- `workbench_wrapper_contract.scad` — wrapper defaults and render-mode routing.

Coupon-matrix, positive-gap, and API version 3 coupon tests were retired with their implementation.
