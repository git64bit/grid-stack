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

## Batch 008

Batch 008 adds the first printable composed structural stack. In `main.scad`,
the default project is:

```text
COUPON_3X3_SPAN6_GAP0_DIRECT
```

The lower X path and upper Y path are each composed from the qualified process:

```text
0.4 × 0.2 mm primitive trace
2 traces wide × 2 layers high
0.8 × 0.4 mm structural strand
```

The two structural paths are in direct contact, producing a total modeled stack
height of 0.8 mm. Positive vertical gaps remain disabled until an anchor/support
strategy is defined.

Batch 007 immutable first-layer recipes remain under `objects/printed/`.

## Output modes

```text
structural_coupon   printable direct-contact X/Y structural stack in main.scad
path_preview        numbered non-printable coupon centerline diagnostic
report_only         validation and dimensions only
```

The separate first-layer entry point retains `trace_layer` and `path_debug`.

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
├── geometry/trace_layer.scad               Square-ended primitive trace solid
├── geometry/structural_strand.scad          Composed structural ribbon
├── geometry/orthogonal_stack_coupon.scad    Direct-contact X/Y coupon
├── paths/structural_coupon_paths.scad        Lower/upper ordered paths
├── objects/printed/                         Immutable successful print recipes
├── config/                                 Mutable development catalogs
├── lib/                                    Shared math and API v1 implementation
├── tests/                                  Path and saved-object contracts
└── docs/                                    Specification and tutorial lessons
```

Read `docs/LESSON_001.md` through `docs/LESSON_008.md` in order.
