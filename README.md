# Grid Stack

Grid Stack is an OpenSCAD project for continuous-nozzle-path structures, calibration sheets, and composite reinforcement grids.

## Current printable primitive

Open:

```text
first-layer-0u2Z-anyXY.scad
```

The first layer is defined by variable parallel-trace records:

```scad
traces = [
    [-10, 10,  0],
    [ -8, 10,  5],
    [ -8,  3, 15],
    [ -6,  3, 16],
    [ -6,  9, 18]
];
```

Each record is `[axis_min, axis_max, perpendicular_position]`. Trace lengths and repeat distances are independently configured. Alternating records share a turn endpoint, producing one continuous path with perpendicular square connectors.

For the current 0.4 mm nozzle and 0.2 mm deposited layer, the output is one `0.4 × 0.2 mm` primitive trace. It is not the qualified `0.8 × 0.4 mm` structural strand.

## Batch 007

Batch 007 promotes the accepted first-layer object into immutable PLA+ and TPU recipes:

```text
objects/printed/first-layer-0u2Z-variable-50x18-pla-plus-0p4-v1.scad
objects/printed/first-layer-0u2Z-variable-50x18-tpu-0p4-v1.scad
```

These files use API version 2, embed source commit `79f36da`, and separate primitive-trace process data from structural-strand bridge/pass data.

## Output modes

```text
trace_layer   printable geometry, no numbers
path_debug    numbered non-printable centerline diagnostic
report_only   validation and dimensions only
```

## Versioned APIs

```text
api/grid_stack_v1.scad   Existing stack and first-layer schema version 1
api/grid_stack_v2.scad   Primitive first-layer print schema version 2
```

Permanent objects import an explicit API file and assert its version. Development files may continue using the current workbench interfaces.

## Repository map

```text
grid-stack/
├── main.scad                              Stack-development orchestrator
├── first-layer-0u2Z-anyXY.scad            First-layer development entry point
├── api/grid_stack_v1.scad                 Existing versioned interface
├── api/grid_stack_v2.scad                 Immutable printed first-layer API
├── api/v2/                                API v2 schema, indexes, validation
├── paths/parallel_traces.scad              Variable parallel-trace path model
├── geometry/trace_layer.scad               Square-ended printable trace solid
├── objects/printed/                        Immutable successful print recipes
├── config/                                 Mutable development catalogs
├── lib/                                    Shared math and API v1 implementation
├── tests/                                  Path and saved-object contracts
└── docs/                                    Specification and tutorial lessons
```

Read `docs/LESSON_001.md` through `docs/LESSON_007.md` in order.
