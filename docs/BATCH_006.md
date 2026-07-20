# Batch 006 — Variable Parallel First Layer

Base commit: `890ec5c`

Batch 006 adds the first printable Grid Stack geometry without introducing a regular square-wave assumption.

## Governing record

```scad
traces = [
    [-10, 10,  0],
    [ -8, 10,  5],
    [ -8,  3, 15],
    [ -6,  3, 16],
    [ -6,  9, 18]
];
```

Each record is:

```text
[axis_min, axis_max, perpendicular_position]
```

For X-running traces, those fields mean `[x_min, x_max, y]`. For Y-running traces, they mean `[y_min, y_max, x]`.

Even traces traverse minimum to maximum. Odd traces traverse maximum to minimum. Adjacent records must share the endpoint used by the turn. The connector is therefore perpendicular and square while every trace length and repeat distance remains independent.

## Printable primitive

The output is one nozzle trace wide and one deposited layer high:

```text
trace width  = nozzle diameter
trace height = process layer height
```

For the reference environment, the geometry is `0.4 × 0.2 mm`. It is intentionally not the `0.8 × 0.4 mm` structural strand.

## Entry points

The Customizer entry exposes each trace as an individual three-number vector and assembles the active records into the nested saved-object list.

- `first-layer-0u2Z-anyXY.scad` — development and Customizer entry point.
- `objects/first-layer-0u2Z-variable-50x18-v1.scad` — permanent saved recipe.
- `tests/parallel_trace_contract.scad` — exact path-semantics assertion.

## Output modes

- `trace_layer` — printable square-ended solid with no annotations.
- `path_debug` — non-printable point numbers and start/end markers.
- `report_only` — console validation and dimensions only.
