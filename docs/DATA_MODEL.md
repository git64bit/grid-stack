# Data Model

## Environment records

### Material specification

Identifies a filament family such as PLA+ or TPU.

### Nozzle specification

Identifies installed nozzle hardware and its nominal diameter.

### Printer specification

Identifies machine and build surface. API version 3 requires the field even when its value is explicitly unrecorded.

### Process profile

Joins material, nozzle, and printer with deposited layer height, horizontal and vertical pass counts, bridge observation, qualification, and revision.

Derived values are never stored independently:

```text
trace width       = nozzle diameter
trace height      = deposited layer height
strand width      = trace width × horizontal passes
strand height     = trace height × vertical passes
```

## Boundary records

The frozen coupon API supports only count-driven rectangles:

```scad
count_boundary(
    name,
    cells_x,
    cells_y,
    clear_span_x,
    clear_span_y
);
```

Outside dimensions derive from clear-opening count and structural-strand width.

Dimension and non-rectangular boundary records remain workbench stubs and are not part of API version 3.

## Workbench project records

The mutable workbench resolves named process, boundary, path-policy, pattern, and schedule records. These records are useful for Customizer exploration and matrix reporting, but they are not permanent saved objects.

## Positive-gap support strategy

The workbench and API version 3 derive three paths:

```text
witness path: orientation 90°, with lead-in
riser path:   orientation 0°, no lead-in
upper test:   orientation 90°, no lead-in
```

The witness and upper test point lists are identical after removing the witness lead-in point. The riser begins at their shared lower-left crossing.

## Immutable API version 3 coupon

`structural_coupon_object()` embeds:

- object identity and revision;
- required API version;
- coupon-schema version;
- source release;
- framework base commit;
- material record;
- nozzle record;
- printer record;
- structural process record;
- count boundary record;
- clear vertical gap;
- lead-in length;
- support strategy;
- lifecycle status and notes.

No mutable catalog lookup occurs when a saved coupon is opened.

## Version distinction

```text
API version          public constructors and rendering module
schema version       saved vector field layout and meaning
framework version    supported geometry and validation behavior
release              project milestone
containing Git commit exact complete repository source
```

A file cannot embed the hash of the future commit that will contain it. The object records the accepted framework base commit, while Git itself records the containing commit.

## Historical records

API versions 1 and 2 remain unchanged for earlier diagnostic and first-layer recipes. Their record layouts and compatibility aliases are retained as history, not used by the new coupon files.
