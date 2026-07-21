# Architecture

## Development workbench

`main.scad` performs mutable catalog orchestration:

1. load constructors, indexes, and mathematics;
2. load Customizer selectors and catalogs;
3. resolve named records;
4. validate the general data model;
5. validate rectangular framework version 2;
6. select direct or positive-gap support strategy;
7. generate ordered paths;
8. validate and report the paths;
9. render printable geometry or diagnostics.

The workbench is for exploration and qualification. Permanent objects belong under `objects/`.

## Frozen rectangular routes

### Direct-contact reference

```text
qualified process
        ↓
count_boundary rectangle
        ↓
continuous lower X path with lead-in
        ↓
continuous upper Y path
        ↓
direct-contact solid
```

### Positive-gap coupon

```text
qualified process
        ↓
count_boundary rectangle
        ↓
continuous lower Y witness with lead-in
        ↓
continuous X riser path repeated through gap
        ↓
continuous upper Y test aligned above witness
        ↓
positive-gap solid
```

The riser path creates physical access to the upper grid without independent supports, lift moves, or floating geometry.

## Terminology layers

```text
primitive trace
    nozzle diameter × one deposited layer

structural strand section
    trace width × horizontal passes
    trace height × vertical passes

structural path layer
    one complete continuous serpentine swept with the strand section

riser wall
    the structural-width path repeated through a layer-quantized gap
```

## Configuration layer

`config/` contains mutable records for materials, nozzles, processes, active count boundaries, square coupon topology, coupon gap declarations, named projects, and deferred stubs. Configuration files do not create solids.

## Path and geometry layers

`paths/` returns ordered point lists only.

`geometry/` converts validated paths into solids and does not select projects.

- `orthogonal_stack_coupon.scad` implements the direct reference.
- `vertical_gap_coupon.scad` implements the witness/riser/bridge strategy.

## Saved objects and API isolation

Permanent coupon recipes import `api/grid_stack_v3.scad`.

All behavior-affecting API v3 dependencies are inside `api/v3/`:

```text
indices
schema
math
paths
geometry
validation
reporting
```

API v3 does not import mutable workbench files. Incompatible changes require API version 4 rather than modification of version 3.

## Deferred route

Dimension boundaries, circles, polygons, mixed square/hex patterns, and expanded schedules remain named stubs. They fail workbench framework validation intentionally and do not receive partial implementations during rectangular maintenance.
