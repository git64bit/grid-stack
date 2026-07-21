# Grid Stack

Grid Stack is a preset-driven OpenSCAD framework for continuous-nozzle-path grids and first-layer trace objects.

## Active workbenches

Open the required entry point directly:

```text
workbenches/coupons.scad      generic rectangular coupon generator
workbenches/laboratory.scad   mutable rectangular Grid Panel generator
workbenches/first-layer.scad  variable parallel-trace first-layer generator
workbenches/catalog.scad      immutable-product registry entry point
```

`default.scad` remains the broad development wrapper.

## Coupon workflow

Coupons are no longer represented by hard-coded matrices or one source file per variation. The Coupon workbench exposes the same rectangular count-boundary engine used by the Laboratory. Each variation is created in the Customizer and saved as a named preset.

The active rectangular contract is:

```text
one continuous open nozzle path per deposited layer
parallel traces with perpendicular square connectors and square ends
alternating X/Y deposited layers
cell count and clear span derive the outside dimensions
no filler perimeter border
```

## First-layer workflow

The First Layer workbench retains the separate variable-trace grammar. Its trace lengths, spacing, orientation, lead-in, process, and render mode are saved in named presets.

`first-layer-0u2Z-anyXY.scad` remains as a compatibility entry point and redirects to that workbench.

## Promotion workflow

```text
mutable Customizer preset
        ↓
render and physical test
        ↓
immutable .scad geometry recipe
        ↓
Catalog registration
        ↓
associated slicer 3MF manufacturing project
```

OpenSCAD presets describe geometry. Slicer-only requirements, including horizontal expansion, remain in the associated 3MF project rather than being added to Grid Stack geometry.

## Historical implementation

The former hard-coded coupon matrix, positive-gap coupon routes, API version 3 coupon recipes, and their contract tests were retired after the preset-native workbenches passed testing. Git history and release `v0.1.0` preserve that implementation. Older batch and lesson documents are historical records and may refer to retired files.
