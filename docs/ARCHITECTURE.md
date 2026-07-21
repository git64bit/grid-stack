# Architecture

## Development workbench

`main.scad` performs mutable catalog orchestration:

1. load constructors, indexes, and mathematics;
2. load Customizer selectors and catalogs;
3. resolve named records;
4. validate the general data model;
5. validate the frozen rectangular coupon contract;
6. generate lower and upper continuous paths;
7. render direct contact, preview paths, or stop at an explicit stub.

The workbench is for development and qualification. Permanent printed objects belong under `objects/`.

## Frozen rectangular coupon route

```text
material + nozzle + qualified process
        ↓
count_boundary rectangle
        ↓
SQUARE_COUPON topology
        ↓
one continuous lower X path
        ↓
one continuous upper Y path
        ↓
complete structural path-layer schedule
        ↓
direct-contact solid or positive-gap stub
```

`lib/coupon_framework.scad` is the central contract. It prevents deferred boundary and pattern records from entering the active route.

## Terminology layers

```text
primitive trace
    nozzle diameter × one deposited layer

structural strand section
    trace width × horizontal passes
    trace height × vertical passes

structural path layer
    one complete continuous serpentine swept with the strand section

schedule group
    repetitions of a complete structural path layer
```

The `PLG_*` indexes and `path_layer_group()` constructor express the frozen terminology. `SG_*` and `strand_group()` remain compatibility aliases.

## Configuration layer

`config/` contains mutable records:

- materials, nozzles, and qualified processes;
- active count boundaries and deferred boundary stubs;
- square coupon topology and mixed-pattern stub;
- complete path-layer schedules;
- twelve-case coupon matrix;
- named projects;
- deferred feature registry.

Configuration files do not create solids.

## Path and geometry layers

`paths/` returns ordered point lists only.

`geometry/` converts validated paths into solids and does not select projects.

The current structural solid implementation supports zero vertical gap. Positive gaps require a support/anchor strategy and are blocked by the framework stub.

## Saved objects and API isolation

A permanent recipe must import an explicit versioned API, embed exact records, assert the API version, and call one public render module.

The audit found that API versions 1 and 2 still import some shared implementation files. The next coupon API must keep all behavior-affecting dependencies inside its own versioned directory before the coupon recipes are frozen.

## Deferred route

Dimension boundaries, circles, polygons, mixed square/hex patterns, and expanded stacks remain named records. They fail framework validation intentionally and do not receive partial implementations during rectangular coupon work.
