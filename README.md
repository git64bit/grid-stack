# Grid Stack

Grid Stack is an OpenSCAD project for continuous-nozzle-path structures, calibration sheets, and composite reinforcement grids.

## Batch 006

Batch 006 adds the first printable primitive: one nozzle trace wide and one deposited layer high.

The first layer is defined by parallel-trace records rather than a regular square wave:

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

Open:

```text
first-layer-0u2Z-anyXY.scad
```

The default pattern has trace lengths of `20, 18, 11, 9, 15 mm` and repeat distances of `5, 10, 1, 2 mm`. It is intentionally irregular.

## Output modes

```text
trace_layer   printable geometry, no numbers
path_debug    numbered non-printable centerline diagnostic
report_only   validation and dimensions only
```

For the reference PLA+ environment, the first-layer geometry is one `0.4 × 0.2 mm` trace. It is not the qualified `0.8 × 0.4 mm` structural strand.

## Saved objects

Permanent printed configurations are dedicated source files under `objects/`. They import an explicit API version, assert their schema, embed the exact print environment and trace records, and call one public rendering module.

Example:

```text
objects/first-layer-0u2Z-variable-50x18-v1.scad
```

## Repository map

```text
grid-stack/
├── main.scad                              Stack-development orchestrator
├── first-layer-0u2Z-anyXY.scad            First-layer development entry point
├── grid_stack.scad                        Current public API alias
├── api/grid_stack_v1.scad                 Versioned public interface
├── paths/parallel_traces.scad              Variable parallel-trace path model
├── geometry/trace_layer.scad               Square-ended printable trace solid
├── objects/                                Permanent self-contained recipes
├── config/                                 Mutable development catalogs
├── lib/                                    Schema, validation, math, reporting
├── tests/parallel_trace_contract.scad       Exact path-semantics assertion
└── docs/                                    Specification and tutorial lessons
```

Read `docs/LESSON_001.md` through `docs/LESSON_006.md` in order.
